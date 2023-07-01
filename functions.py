import mysql.connector
import pandas as pd
import datetime
import matplotlib.pyplot as plt

def register_user(connection, cursor):
    # Prompt the user for registration information
    first_name = input("Enter your first name: ")
    last_name = input("Enter your last name: ")
    email_id = input("Enter your email address: ")
    password = input("Enter your password: ")

    try:
        # Call the RegisterUser stored procedure with the user's input
        cursor.callproc('RegisterUser', (first_name, last_name, email_id, password))

        # Commit the transaction
        connection.commit()

        # Retrieve the user id of the newly registered user
        cursor.execute("SELECT LAST_INSERT_ID()")
        user_id = cursor.fetchone()[0]

        print("User successfully registered!")

        # Prompt the user for wallet information
        wallet_address = input("Enter your wallet address: ")
        wallet_type = input("Enter your wallet type (physical or digital): ")

        # Call the InsertWallet stored procedure with the user's wallet information
        cursor.callproc('InsertWallet', (wallet_address, wallet_type, user_id))

        # Commit the transaction
        connection.commit()

        print("Wallet information added successfully!")

        cursor.close()
        return user_id

    except mysql.connector.Error as err:
        # Handle specific error for email already registered
        if err.errno == 1644:
            print("This email address belongs to a different user.")
        else:
            print(f"Error: {err}")
        cursor.close()
        return None


def login(connection, cursor):
    email_id = input("Enter your email address: ")
    password = input("Enter your password: ")

    cursor.execute(f"SELECT LoginUser('{email_id}', '{password}')")

    # Fetch the result
    result = cursor.fetchone()

    # Return the user id if login was successful, otherwise None
    return result[0] if result and result[0] != 0 else None
    cursor.close()

def login_or_register(connection):
    cursor = connection.cursor()

    while True:
        choice = input("Do you want to [l]ogin or [r]egister? ")

        if choice.lower() == 'l':
            user_id = login(connection, cursor)
            if user_id:
                print("Login successful!")
                return user_id
            else:
                print("Login failed. Please try again or register.")

        elif choice.lower() == 'r':
            user_id = register_user(connection, cursor)
            if user_id:
                print("Registration successful")
                return user_id

        else:
            print("Please choose a valid option.")
    cursor.close()

def set_or_view_preferences(connection, user_id):
    try:
        cursor = connection.cursor()

        while True:
            choice = input("Do you want to [s]et preferences or [v]iew preferences? ")

            if choice.lower() == 's':
                preferred_currency = input("Enter your preferred currency: ")
                notification_frequency = input("Enter your notification frequency (Daily, Weekly, Monthly): ")

                try:
                    # Call the SetUserPreferences stored procedure with the user's input
                    cursor.callproc('SetUserPreferences', [user_id, preferred_currency, notification_frequency])

                    # Commit the transaction
                    connection.commit()

                    print("Preferences successfully set!")
                    break

                except mysql.connector.Error as err:
                    print(f"Error: {err}")

            elif choice.lower() == 'v':
                cursor.callproc('ViewUserPreferences', [user_id])

                # Retrieve the result sets.
                results = cursor.stored_results()

                # Get the first result set.
                result = next(results, None)

                if result is None:
                    print("No preferences found. Please set your preferences.")
                else:
                    data = result.fetchone()
                    if data:
                        preferred_currency, notification_frequency = data
                        print(
                            f"Current preferences:\nPreferred Currency: {preferred_currency}\nNotification Frequency: {notification_frequency}")
                        break
                    else:
                        print("No preferences found. Please set your preferences.")

            else:
                print("Please choose a valid option.")

    except mysql.connector.Error as err:
        print(f"Database Error: {err}")
    finally:
        cursor.close()

def set_or_view_alerts(connection, user_id):
    cursor = connection.cursor()

    while True:
        choice = input("Do you want to [s]et alerts or [v]iew alerts? ")

        if choice.lower() == 's':
            # Ask the user for the alert details
            coin_name = input("Enter the name of the crypto coin for the alert: ")

            # Retrieve the crypto_id for the given coin_name
            cursor.execute(f"SELECT crypto_id FROM Cryptocurrency WHERE crypto_name = '{coin_name}'")
            result = cursor.fetchone()

            if result is None:
                print("Invalid coin name. Please try again.")
                continue

            crypto_id = result[0]
            alert_type = input("Enter the alert type (Increase or Decrease): ")
            try:
                threshold_value = float(input("Enter the threshold value: "))
            except ValueError:
                print("Invalid threshold value. Please enter a valid numeric value.")
                continue

            try:
                # Call the SetAlert stored procedure with the provided details
                cursor.callproc('SetAlert', [user_id, crypto_id, alert_type, threshold_value])

                # Commit the transaction
                connection.commit()

                print(f"Alert successfully set!")

            except mysql.connector.Error as err:
                print(f"Error: {err}")

        elif choice.lower() == 'v':
            try:
                # Call the ViewAlerts stored procedure
                cursor.callproc('ViewAlerts', [user_id])

                # Retrieve the result sets.
                results = cursor.stored_results()

                # Get the first result set.
                result = next(results, None)

                if result is None:
                    print("No alerts found. Please set an alert.")
                else:
                    data = result.fetchall()
                    column_names = ['Coin Name', 'Alert Type', 'Threshold Value']

                    if data:
                        print(f"Current alerts:")
                        df = pd.DataFrame(data, columns=column_names)
                        print(df)
                    else:
                        print("No alerts found. Please set an alert.")
            except mysql.connector.Error as err:
                print(f"Error: {err}")
        else:
            print("Please choose a valid option.")
        break
    cursor.close()

def create_or_view_portfolio(connection, user_id):
    pd.set_option("display.max_columns", None)
    pd.set_option("display.max_rows", None)

    # Ask the user if they want to create or view a portfolio
    action = input("Do you want to [c]reate or [v]iew a portfolio?: ")

    # Create a new cursor
    cursor = connection.cursor()

    if action.lower() == 'c':
        # User wants to create a portfolio

        # Ask the user for the portfolio name
        portfolio_name = input("Enter the name of the new portfolio: ")

        # Check if the portfolio already exists
        check_query = f"""
            SELECT COUNT(*) 
            FROM Portfolio 
            WHERE user_id = {user_id} AND portfolio_name = '{portfolio_name}'
        """
        cursor.execute(check_query)
        portfolio_exists = cursor.fetchone()[0]

        if portfolio_exists > 0:
            print("A portfolio with this name already exists. Please choose a different name.")
            return

        try:
            # Call the CreatePortfolio stored procedure with the user_id and portfolio_name
            cursor.callproc('CreatePortfolio', (user_id, portfolio_name))

            # Commit the transaction
            connection.commit()

            print(f"Portfolio: '{portfolio_name}' successfully created!")

        except mysql.connector.Error as err:
            print(f"Error: {err}")

    elif action.lower() == 'v':
        # User wants to view a portfolio

        # Ask the user for the portfolio name
        portfolio_name = input("Enter the name of the portfolio you want to view: ")

        # Check if the portfolio exists
        check_query = f"""
            SELECT COUNT(*) 
            FROM Portfolio 
            WHERE user_id = {user_id} AND portfolio_name = '{portfolio_name}'
        """
        cursor.execute(check_query)
        portfolio_exists = cursor.fetchone()[0]

        if portfolio_exists == 0:
            print("The specified portfolio doesn't exist. Please create a new portfolio or enter a different name.")
            return

        try:
            # Call the ViewPortfolio stored procedure with the user_id and portfolio_name
            cursor.callproc('ViewPortfolio', (user_id, portfolio_name))

            # Retrieve the result sets.
            results = cursor.stored_results()

            # Get the first result set.
            result = next(results, None)

            if result is None:
                print("No portfolio data found.")
            else:
                data = result.fetchall()
                column_names = ['Portfolio Name', 'Total Value', 'Cryptocurrencies', 'Quantities', 'Current Values']

                if data:
                    df = pd.DataFrame(data, columns=column_names)
                    print(df)
                else:
                    print("No portfolio data found.")
        except mysql.connector.Error as err:
            print(f"Error: {err}")

    else:
        print("Invalid action. Please enter a valid option.")

    cursor.close()

def view_wallet(connection, user_id):
    try:
        cursor = connection.cursor()

        # Call the stored procedure
        cursor.callproc('viewWallet', [user_id])

        # Retrieve the result sets.
        results = cursor.stored_results()

        # Get the first result set.
        result = next(results, None)

        if result is None:
            print("No wallet information found for the user.")
        else:
            wallet_data = result.fetchall()
            if not wallet_data:
                print("No wallet information found for the user.")
            else:
                print("Wallet Information:")
                for wallet_address, wallet_type in wallet_data:
                    print(f"Wallet Address: {wallet_address}")
                    print(f"Wallet Type: {wallet_type}")

        cursor.close()
    except mysql.connector.Error as err:
        print(f"Error: {err}")

def input_transaction(connection, user_id):
    cursor = connection.cursor()

    while True:
        choice = input("Do you want to [b]uy or [s]ell? ")

        if choice.lower() == 'b':
            # Handle the buy transaction
            portfolio_name = input("Enter your portfolio name: ")

            # Retrieve the portfolio_id for the given portfolio_name and user_id
            cursor.execute(
                f"SELECT portfolio_id FROM Portfolio WHERE portfolio_name = '{portfolio_name}' AND user_id = {user_id}")
            result = cursor.fetchone()

            if result is None:
                print("You don't have a portfolio called " + portfolio_name)
                continue
            portfolio_id = result[0]

            coin_name = input("Enter the name of the coin: ")
            exchange_name = input("Enter the exchange name: ")

            try:
                transaction_date = input("Enter the transaction date (YYYY-MM-DD): ")
                datetime.datetime.strptime(transaction_date, '%Y-%m-%d')
            except ValueError:
                print("Invalid input. Transaction date must be in the format YYYY-MM-DD.")
                continue

            try:
                purchase_price = float(input("Enter the purchase price: "))
            except ValueError:
                print("Invalid input. Purchase price must be a number.")
                continue

            try:
                quantity = float(input("Enter the quantity: "))
            except ValueError:
                print("Invalid input. Quantity must be a number.")
                continue

            # Retrieve the crypto_id for the given coin_name
            cursor.execute(f"SELECT crypto_id FROM Cryptocurrency WHERE crypto_name = '{coin_name}'")
            result = cursor.fetchone()

            if result is None:
                print("Invalid coin name. Please try again.")
                continue
            crypto_id = result[0]

            # Retrieve the exchange_id for the given exchange_name
            cursor.execute(f"SELECT exchange_id FROM Exchange WHERE exchange_name = '{exchange_name}'")
            result = cursor.fetchone()

            if result is None:
                print("Invalid exchange name. Please try again.")
                continue
            exchange_id = result[0]

            try:
                # Now call the BuyTransaction procedure
                cursor.callproc('BuyTransaction', (user_id, portfolio_id, crypto_id, exchange_id, transaction_date, purchase_price, quantity))

                # Commit the transaction
                connection.commit()

                print("Buy transaction successful!")

            except mysql.connector.Error as error:
                print(f"Failed to execute procedure: {error}")

        elif choice.lower() == 's':
            # Handle the sell transaction
            portfolio_name = input("Enter your portfolio name: ")

            # Retrieve the portfolio_id for the given portfolio_name and user_id
            cursor.execute(
                f"SELECT portfolio_id FROM Portfolio WHERE portfolio_name = '{portfolio_name}' AND user_id = {user_id}")
            result = cursor.fetchone()

            if result is None:
                print("You don't have a portfolio called " + portfolio_name)
                continue
            portfolio_id = result[0]

            coin_name = input("Enter the name of the coin: ")
            exchange_name = input("Enter the exchange name: ")

            try:
                transaction_date = input("Enter the transaction date (YYYY-MM-DD): ")
                datetime.datetime.strptime(transaction_date, '%Y-%m-%d')
            except ValueError:
                print("Invalid input. Transaction date must be in the format YYYY-MM-DD.")
                continue

            try:
                sale_price = float(input("Enter the sale price: "))
            except ValueError:
                print("Invalid input. Sale price must be a number.")
                continue

            try:
                quantity = float(input("Enter the quantity: "))
            except ValueError:
                print("Invalid input. Quantity must be a number.")
                continue

            # Retrieve the crypto_id for the given coin_name
            cursor.execute(f"SELECT crypto_id FROM Cryptocurrency WHERE crypto_name = '{coin_name}'")
            result = cursor.fetchone()

            if result is None:
                print("Invalid coin name. Please try again.")
                continue
            crypto_id = result[0]

            # Retrieve the exchange_id for the given exchange_name
            cursor.execute(f"SELECT exchange_id FROM Exchange WHERE exchange_name = '{exchange_name}'")
            result = cursor.fetchone()

            if result is None:
                print("Invalid exchange name. Please try again.")
                continue
            exchange_id = result[0]

            try:
                # Now call the SellTransaction procedure
                cursor.callproc('SellTransaction', (user_id, portfolio_id, crypto_id, exchange_id, transaction_date, sale_price, quantity))

                # Commit the transaction
                connection.commit()

                print("Sell transaction successful!")

            except mysql.connector.Error as error:
                print(f"Failed to execute procedure: {error}")

        else:
            print("Please choose a valid option.")
        cursor.close()
        break

def view_transactions(connection, user_id):
    pd.set_option("display.max_columns", None)
    pd.set_option("display.max_rows", None)

    # Create a new cursor
    cursor = connection.cursor()

    try:
        # Call the stored procedure
        cursor.callproc("ViewTransactions", [user_id])

        # Initialize data and column_names to None
        data = None
        column_names = None

        # Iterate over all result sets
        for result in cursor.stored_results():
            data = result.fetchall()
            column_names = [desc[0] for desc in result.description]

        # If there are no transactions, print a message and return
        if not data:
            print("You currently have no transactions. Please add a buy transaction.")
            return

        # Create a DataFrame
        df = pd.DataFrame(data, columns=column_names)

        # Print the DataFrame
        print(df)

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    except TypeError as err:
        print(f"Error: {err}. Please check your data and column names.")

    finally:
        cursor.close()

def calculate_profit(connection, user_id):
    try:
        # Prompt the user for the portfolio name
        portfolio_name = input("Please enter your portfolio name: ")

        # Create a new cursor
        cursor = connection.cursor()

        # Check if the portfolio exists for the user
        portfolio_query = f"""
            SELECT COUNT(*)
            FROM Portfolio
            WHERE user_id = {user_id} AND portfolio_name = '{portfolio_name}'
        """
        cursor.execute(portfolio_query)
        portfolio_exists = cursor.fetchone()[0]

        if portfolio_exists == 0:
            print("Portfolio not found. Please create a portfolio or enter a valid portfolio name.")
            cursor.close()
            return

        # Call the TotalCost stored procedure
        args = [user_id, portfolio_name, 0]
        result_args = cursor.callproc("TotalCost", args)

        # Fetch the value of the OUT parameter
        total_cost = result_args[2]

        # Call the TotalSales stored procedure
        args = [user_id, portfolio_name, 0]
        result_args = cursor.callproc("TotalSales", args)

        # Fetch the value of the OUT parameter
        total_sales = result_args[2]

        if total_cost is None and total_sales is None:
            print("No transactions found for the given portfolio.")
            cursor.close()
            return

        # Calculate the profit
        profit = total_sales - total_cost

        if profit < 0:
            print(f"The current loss for the portfolio '{portfolio_name}' is: {abs(profit)}")
        else:
            print(f"The current profit for the portfolio '{portfolio_name}' is: {profit}")

    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        cursor.close()

def delete_profile(connection, user_id):
    cursor = connection.cursor()

    # Ask the user for confirmation
    confirm = input("Are you sure you want to delete your profile? This will delete all your data. [y/n]: ")

    # Proceed only if the user confirms
    if confirm.lower() == "y":
        try:
            # Begin a transaction
            cursor.execute("START TRANSACTION")

            # Call the procedure to delete user from User table
            cursor.callproc("DeleteProfile", [user_id])

            # Commit the transaction
            connection.commit()

            print("Profile deleted successfully.")
            return False
        except Exception as e:
            # If an error occurred, rollback the transaction
            connection.rollback()

            print(f"An error occurred: {e}")
        finally:
            # Close the cursor
            cursor.close()
    else:
        print("Profile deletion cancelled.")

def visualize_data(connection, user_id):
    # Prompt the user to select a portfolio
    portfolio_name = input("Enter the portfolio name: ")

    # Retrieve the portfolio_id for the given portfolio_name and user_id
    cursor = connection.cursor()
    cursor.execute(
        f"SELECT portfolio_id FROM Portfolio WHERE portfolio_name = '{portfolio_name}' AND user_id = {user_id}"
    )
    result = cursor.fetchone()
    cursor.close()

    if result is None:
        print("Invalid portfolio name. Please try again.")
        return

    portfolio_id = result[0]

    # Retrieve the cryptocurrency distribution for the user's chosen portfolio
    cursor = connection.cursor()
    cursor.execute(f"""
        SELECT C.crypto_name, UC.quantity, UC.current_value
        FROM UserCryptocurrency UC
        INNER JOIN Cryptocurrency C ON UC.crypto_id = C.crypto_id
        WHERE UC.user_id = {user_id} AND UC.portfolio_id = {portfolio_id}
    """)
    data = cursor.fetchall()
    cursor.close()

    if not data:
        print("No data available for the selected portfolio.")
        return

    # Extract the crypto names and calculate total values from the data
    crypto_names = [row[0] for row in data]
    total_values = [row[1] * row[2] for row in data]

    # Create a pie chart of the cryptocurrency distribution
    fig, ax = plt.subplots()
    ax.pie(total_values, labels=crypto_names, autopct='%1.1f%%', startangle=90)
    ax.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle

    plt.title('Cryptocurrency Distribution')
    plt.show()









import mysql.connector
from mysql.connector import errorcode
from functions import login_or_register
from functions import set_or_view_preferences
from functions import create_or_view_portfolio
from functions import set_or_view_alerts
from functions import view_wallet
from functions import input_transaction
from functions import view_transactions
from functions import calculate_profit
from functions import delete_profile
from functions import visualize_data


def get_credentials():
    username = input("Enter your MySQL username: ")
    password = input("Enter your MySQL password: ")

    return username, password


def establish_connection(username, password):
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user=username,
            password=password,
            database="crypto_portfolio",
            buffered=True
        )
        return connection
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your username or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
        return None



def display_menu():
    print("\nMain Menu")
    print("1. View/Set User Preferences")
    print("2. View/Create portfolio")
    print("3. View/Set Alerts")
    print("4. View Wallet")
    print("5. Input Buy/Sell Transaction")
    print("6. View Transactions")
    print("7. View Profit/Loss")
    print("8. Visualize Portfolio Distribution")
    print("9. Delete Profile")
    print("10. Exit")


def main():
    username, password = get_credentials()
    conn = establish_connection(username, password)

    if not conn:
        print("Failed to connect to the database.")
        return
    else:
        print("Successfully connected to the database.")

    # Call the login_or_register function and store the returned user_id
    user_id = login_or_register(conn)

    while True:
        display_menu()

        try:
            choice = int(input("Choose an option from the menu: "))

            if choice == 1:
                # View/Set User Preferences
                set_or_view_preferences(conn, user_id)
            elif choice == 2:
                # View/Create portfolio
                create_or_view_portfolio(conn, user_id)
            elif choice == 3:
                # Set alert
                set_or_view_alerts(conn, user_id)
            elif choice == 4:
                # Buy/Sell Transaction
                view_wallet(conn, user_id)
            elif choice == 5:
                # Buy/Sell Transaction
                input_transaction(conn, user_id)
            elif choice == 6:
                # View Transactions
                view_transactions(conn, user_id)
            elif choice == 7:
                # View Profit/Loss
                calculate_profit(conn, user_id)
            elif choice == 8:
                # Visualize Portfolio Distribution
                visualize_data(conn, user_id)
            elif choice == 9:
                # Delete Profile
                delete_status = delete_profile(conn, user_id)
                if delete_status is False:
                    print("Exiting...")
                    conn.close()
                    break
            elif choice == 10:
                print("Exiting...")
                conn.close()
                break
            else:
                print("Invalid choice. Please choose a valid option.")

        except ValueError:
            print("Invalid choice. Please enter a number from the menu.")


main()




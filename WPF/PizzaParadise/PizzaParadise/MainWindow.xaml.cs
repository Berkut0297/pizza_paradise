using System;
using System.Windows;
using System.Windows.Input;
using MySql.Data.MySqlClient;
using System.Data;

namespace PizzaParadise
{
    public partial class MainWindow : Window
    {
        MySqlConnection connection = new MySqlConnection(
            "server=localhost;database=pizzaparadise;uid=root;password=;"
        );

        public MainWindow()
        {
            InitializeComponent();

            button_exit.Click += (_, __) => Application.Current.Shutdown();
            button_login.Click += (_, __) => TryLogin();

            PreviewKeyDown += (s, e) =>
            {
                if (e.Key == Key.Enter)
                {
                    TryLogin();
                    e.Handled = true;
                }
            };

            checkbox_showpassword.Checked += (_, __) => ShowPassword(true);
            checkbox_showpassword.Unchecked += (_, __) => ShowPassword(false);
        }

        // -----------------------------------------------------------
        // KAPCSOLAT NYITÁS / ZÁRÁS (PPT alapján)
        // -----------------------------------------------------------
        public void openConnection()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
        }

        public void closeConnection()
        {
            if (connection.State == ConnectionState.Open)
                connection.Close();
        }

        // -----------------------------------------------------------
        // JELSZÓ MEGJELENÍTÉSE
        // -----------------------------------------------------------
        private void ShowPassword(bool show)
        {
            if (show)
            {
                password_textbox.Text = password_user.Password;
                password_user.Visibility = Visibility.Collapsed;
                password_textbox.Visibility = Visibility.Visible;
            }
            else
            {
                password_user.Password = password_textbox.Text;
                password_textbox.Visibility = Visibility.Collapsed;
                password_user.Visibility = Visibility.Visible;
            }
        }

        // -----------------------------------------------------------
        // LOGIN — SQL alapú bejelentkezés a pizzaparadise.users táblából
        // -----------------------------------------------------------
        private void TryLogin()
        {
            string user = textbox_user.Text.Trim();
            string pass = checkbox_showpassword.IsChecked == true
                                ? password_textbox.Text
                                : password_user.Password;

            if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
            {
                ShowError("Kérlek tölts ki minden mezőt.");
                return;
            }

            try
            {
                openConnection();

                string query = "SELECT user_id FROM users WHERE username=@u AND password_hash=@p";

                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@u", user);
                cmd.Parameters.AddWithValue("@p", pass);

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    int userId = Convert.ToInt32(result);

                    HideError();
                    var wnd = new Rendelesek(userId);
                    wnd.Show();
                    Close();
                }
                else
                {
                    ShowError("Hibás felhasználónév vagy jelszó.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Adatbázis hiba: " + ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        // -----------------------------------------------------------
        // HIBA MEGJELENÍTÉSE
        // -----------------------------------------------------------
        private void ShowError(string msg)
        {
            if (text_error != null)
            {
                text_error.Text = msg;
                text_error.Visibility = Visibility.Visible;
            }
            else
            {
                MessageBox.Show(msg, "Bejelentkezés", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void HideError()
        {
            if (text_error != null)
                text_error.Visibility = Visibility.Collapsed;
        }
    }
}

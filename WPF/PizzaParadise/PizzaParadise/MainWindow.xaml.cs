using System;
using System.Windows;
using System.Windows.Input;

namespace PizzaParadise
{
    public partial class MainWindow : Window
    {
        // Demo bejelentkezési adatok
        private const string DemoUser = "admin";
        private const string DemoPass = "admin";

        public MainWindow()
        {
            InitializeComponent();

            // Események bekötése XAML nélkül
            button_exit.Click += (_, __) => Application.Current.Shutdown();
            button_login.Click += (_, __) => TryLogin();

            // Enter megnyomására is belép
            PreviewKeyDown += (s, e) =>
            {
                if (e.Key == Key.Enter)
                {
                    TryLogin();
                    e.Handled = true;
                }
            };
        }

        private void TryLogin()
        {
            var user = (textbox_user.Text ?? string.Empty).Trim();
            var pass = password_user?.Password ?? string.Empty;

            if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
            {
                ShowError("Kérlek tölts ki minden mezőt.");
                return;
            }

            if (string.Equals(user, DemoUser, StringComparison.OrdinalIgnoreCase) && pass == DemoPass)
            {
                HideError();
                var wnd = new Rendelesek();
                wnd.Show();
                Close();
            }
            else
            {
                ShowError("Hibás felhasználónév vagy jelszó.");
            }
        }

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

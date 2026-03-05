using System;
using System.Data;
using System.Windows;
using MySql.Data.MySqlClient;

namespace PizzaParadise
{
    public partial class Rendelesek : Window
    {
        private int loggedUserId;
        MySqlConnection connection = new MySqlConnection(
            "server=localhost;database=pizzaparadise;uid=root;password=;"
        );

        public Rendelesek(int userId)
        {
            InitializeComponent();
            loggedUserId = userId;

            LoadUserInfo();
            LoadOrders();

            // menügombok
            button_rendelesek.Click += (_, __) => LoadOrders();
            button_raktar.Click += (_, __) => new Raktar(loggedUserId).Show();
            button_kilepes.Click += (_, __) => Application.Current.Shutdown();

            // alsó gombok
            button_frissites.Click += Frissites_Click;
            button_teljesitve.Click += Teljesitve_Click;
        }

        // ----------- kapcsolat nyitás/zárás -------------
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

        // ----------- bejelentkezett user betöltése -------------
        private void LoadUserInfo()
        {
            try
            {
                openConnection();

                string query = "SELECT full_name, role FROM users WHERE user_id = @id";
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@id", loggedUserId);

                using var r = cmd.ExecuteReader();
                if (r.Read())
                {
                    textBlock_nev.Text = r.GetString("full_name");
                    textBlock_beosztas.Text = r.GetString("role");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Felhasználói adatok betöltése sikertelen:\n" + ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        // ----------- rendeléslista -------------
        private void LoadOrders()
        {
            try
            {
                openConnection();

                string query = @"
                    SELECT 
                        orders.order_id AS Id,
                        users.full_name AS Name,
                        CONCAT(products.name, ' (', orders_item.quantity, ' db)') AS Item,
                        orders.status AS Status,
                        orders.order_date AS Time
                    FROM orders
                    INNER JOIN users ON orders.user_id = users.user_id
                    INNER JOIN orders_item ON orders.order_id = orders_item.order_id
                    INNER JOIN products ON orders_item.product_id = products.product_id
                    GROUP BY orders.order_id
                    ORDER BY orders.order_date DESC;
                ";

                MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                OrdersGrid.ItemsSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba a rendelések betöltésekor:\n" + ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        // ----------- frissítés -------------
        private void Frissites_Click(object sender, RoutedEventArgs e)
        {
            LoadOrders();
        }

        // ----------- teljesítve gomb -------------
        private void Teljesitve_Click(object sender, RoutedEventArgs e)
        {
            if (OrdersGrid.SelectedItem == null)
            {
                MessageBox.Show("Válassz ki egy rendelést!");
                return;
            }

            DataRowView row = OrdersGrid.SelectedItem as DataRowView;
            int id = Convert.ToInt32(row["Id"]);

            try
            {
                openConnection();

                string update = "UPDATE orders SET status = 'delivered' WHERE order_id = @id";
                MySqlCommand cmd = new MySqlCommand(update, connection);
                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();
                MessageBox.Show("A rendelés teljesítve!");

                LoadOrders();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba frissítéskor:\n" + ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }
    }
}

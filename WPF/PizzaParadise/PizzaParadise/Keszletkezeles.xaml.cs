using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Windows;
using System.Windows.Controls;

namespace PizzaParadise
{
    public partial class Keszletkezeles : Window
    {
        MySqlConnection connection = new MySqlConnection(
            "server=localhost;database=pizzaparadise;uid=root;password=;"
        );

        public Keszletkezeles()
        {
            InitializeComponent();

            combo_category.SelectedIndex = 0;
            combo_status.SelectedIndex = 0;

            button_refresh.Click += (_, __) => LoadInventory();
            textbox_search.TextChanged += (_, __) => LoadInventory();
            combo_category.SelectionChanged += (_, __) => LoadInventory();
            combo_status.SelectionChanged += (_, __) => LoadInventory();

            LoadInventory();
        }

        // -------------------------
        // Kapcsolat nyitás / zárás
        // -------------------------
        private void OpenConnection()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
        }

        private void CloseConnection()
        {
            if (connection.State == ConnectionState.Open)
                connection.Close();
        }

        // -------------------------
        // Készlet betöltése
        // -------------------------
        private void LoadInventory()
        {
            try
            {
                OpenConnection();

                string search = textbox_search.Text.Trim();
                string category = (combo_category.SelectedItem as ComboBoxItem)?.Content?.ToString() ?? "Mind";
                string status = (combo_status.SelectedItem as ComboBoxItem)?.Content?.ToString() ?? "Mind";

                string query = @"
                    SELECT 
                        product_id AS Sku,
                        name AS Name,
                        category AS Category,
                        stock_quantity AS Stock,
                        unit AS Unit,
                        min_stock AS MinLevel,
                        last_delivery AS LastDelivery,
                        supplier AS Supplier,
                        CASE
                            WHEN stock_quantity <= 0 THEN 'Elfogyott'
                            WHEN stock_quantity <= min_stock THEN 'Alacsony készlet'
                            ELSE 'Raktáron'
                        END AS Status
                    FROM products
                    WHERE 1=1
                ";

                if (!string.IsNullOrEmpty(search))
                    query += " AND name LIKE @search";

                if (category != "Mind")
                    query += " AND category = @category";

                if (status != "Mind")
                {
                    if (status == "Raktáron")
                        query += " AND stock_quantity > min_stock";
                    else if (status == "Alacsony készlet")
                        query += " AND stock_quantity <= min_stock AND stock_quantity > 0";
                    else if (status == "Elfogyott")
                        query += " AND stock_quantity <= 0";
                }

                MySqlCommand cmd = new MySqlCommand(query, connection);

                if (!string.IsNullOrEmpty(search))
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                if (category != "Mind")
                    cmd.Parameters.AddWithValue("@category", category);

                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                grid_inventory.ItemsSource = ds.Tables[0].DefaultView;
            }
            finally
            {
                CloseConnection();
            }
        }
    }
}
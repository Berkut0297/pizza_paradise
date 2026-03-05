using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Windows;
using System.Windows.Controls;

namespace PizzaParadise
{
    public partial class Raktar : Window
    {
        private int loggedUserId;
        MySqlConnection connection = new MySqlConnection(
            "server=localhost;database=pizzaparadise;uid=root;password=;"
        );

        public Raktar(int userId)
        {
            InitializeComponent();
            loggedUserId = userId;

            LoadUserInfo();
            LoadProducts();

            // menügombok
            button_rendelesek.Click += (_, __) =>
            {
                new Rendelesek(loggedUserId).Show();
                Close();
            };

            button_raktar.Click += (_, __) => LoadProducts(); // jelenlegi oldal frissítése
            button_kilepes.Click += (_, __) => Application.Current.Shutdown();

            // termék műveletek
            button_hozzaadas.Click += Hozzaadas_Click;
            button_modositas.Click += Modositas_Click;

            // kereső események
            textBox_kereses.GotFocus += Kereses_GotFocus;
            textBox_kereses.LostFocus += Kereses_LostFocus;
            textBox_kereses.TextChanged += Kereses_TextChanged;
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

        // ----------- termékek betöltése a products táblából -------------
        private void LoadProducts(string searchTerm = "")
        {
            try
            {
                openConnection();

                string query = @"
                    SELECT 
                        p.product_id AS TermekKod,
                        p.name AS TermekNev,
                        p.description AS Leiras,
                        p.price AS Ar,
                        pt.name AS Tipus,
                        p.available AS Elerheto
                    FROM products p
                    LEFT JOIN product_types pt ON p.type_id = pt.type_id
                    WHERE 1=1";

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    query += " AND (p.name LIKE @search OR p.description LIKE @search OR pt.name LIKE @search)";
                }

                query += " ORDER BY pt.name, p.name";

                MySqlCommand cmd = new MySqlCommand(query, connection);

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                }

                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                RaktarGrid.ItemsSource = ds.Tables[0].DefaultView;

                // Oszlopfejlécek beállítása
                UpdateGridColumns();

                // Statisztikák frissítése
                UpdateStatisztikak();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba a termékek betöltésekor:\n" + ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        // ----------- DataGrid oszlopok beállítása -------------
        private void UpdateGridColumns()
        {
            // Itt állíthatod be az oszlopok tulajdonságait
            foreach (var column in RaktarGrid.Columns)
            {
                switch (column.Header.ToString())
                {
                    case "Ar":
                        // Ár formázása pénznemként
                        if (column is DataGridTextColumn textColumn)
                        {
                            textColumn.Binding.StringFormat = "{0:C} Ft";
                        }
                        break;
                    case "Elerheto":
                        // Elérhetőség megjelenítése Igen/Nem formátumban
                        if (column is DataGridTextColumn availableColumn)
                        {
                            availableColumn.Binding.StringFormat = "{} {0}"; // 1 = Igen, 0 = Nem
                        }
                        break;
                }
            }
        }

        // ----------- statisztikák frissítése -------------
        private void UpdateStatisztikak()
        {
            try
            {
                openConnection();

                // Összes termék száma
                string queryCount = "SELECT COUNT(*) FROM products";
                MySqlCommand cmdCount = new MySqlCommand(queryCount, connection);
                int totalItems = Convert.ToInt32(cmdCount.ExecuteScalar());

                // Elérhető termékek száma
                string queryAvailable = "SELECT COUNT(*) FROM products WHERE available = 1";
                MySqlCommand cmdAvailable = new MySqlCommand(queryAvailable, connection);
                int availableItems = Convert.ToInt32(cmdAvailable.ExecuteScalar());

                // Nem elérhető termékek száma
                int unavailableItems = totalItems - availableItems;

                // Utolsó frissítés időbélyeg
                string lastUpdate = DateTime.Now.ToString("yyyy.MM.dd HH:mm");
                textBlock_osszesTetel.Text = $"Összes termék: {totalItems}";
                textBlock_lastUpdate.Text = $"Utolsó frissítés: {lastUpdate}";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba a statisztikák frissítésekor:\n" + ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        // ----------- új termék hozzáadása -------------
        private void Hozzaadas_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Új termék hozzáadása funkció");
            // Új ablak: new UjTermekAblak().ShowDialog();
            // Utána: LoadProducts();
        }

        // ----------- termék módosítása -------------
        private void Modositas_Click(object sender, RoutedEventArgs e)
        {
            if (RaktarGrid.SelectedItem == null)
            {
                MessageBox.Show("Válassz ki egy terméket a módosításhoz!");
                return;
            }

            DataRowView row = RaktarGrid.SelectedItem as DataRowView;
            int productId = Convert.ToInt32(row["TermekKod"]);
            string productName = row["TermekNev"].ToString();
            decimal price = Convert.ToDecimal(row["Ar"]);
            bool available = Convert.ToBoolean(row["Elerheto"]);

            MessageBox.Show($"Termék módosítása: {productName}\nÁr: {price:C} Ft\nElérhető: {(available ? "Igen" : "Nem")}");
            // Új ablak: new TermekModositas(productId).ShowDialog();
            // Utána: LoadProducts();
        }

        // ----------- kereső mező fókusz események -------------
        private void Kereses_GotFocus(object sender, RoutedEventArgs e)
        {
            if (textBox_kereses.Text == "Keresés...")
            {
                textBox_kereses.Text = "";
                textBox_kereses.Foreground = System.Windows.Media.Brushes.Black;
            }
        }

        private void Kereses_LostFocus(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(textBox_kereses.Text))
            {
                textBox_kereses.Text = "Keresés...";
                textBox_kereses.Foreground = System.Windows.Media.Brushes.LightGray;
            }
        }

        // ----------- keresés szűrés -------------
        private void Kereses_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
        {
            if (textBox_kereses.Text != "Keresés..." && !string.IsNullOrWhiteSpace(textBox_kereses.Text))
            {
                LoadProducts(textBox_kereses.Text);
            }
            else if (string.IsNullOrWhiteSpace(textBox_kereses.Text))
            {
                LoadProducts();
            }
        }
    }
}
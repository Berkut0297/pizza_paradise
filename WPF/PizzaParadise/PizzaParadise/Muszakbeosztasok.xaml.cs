using System;
using System.Data;
using System.Windows;
using MySql.Data.MySqlClient;

namespace PizzaParadise
{
    public partial class Muszakbeosztasok : Window
    {
        private int userId;
        MySqlConnection connection = new MySqlConnection(
            "server=localhost;database=pizzaparadise;uid=root;password=;"
        );

        public Muszakbeosztasok()
        {
            InitializeComponent();
            this.userId = userId;

            LoadUserInfo();

            combo_week.SelectedIndex = 0;
            combo_role.SelectedIndex = 0;

            button_refresh.Click += (_, __) => LoadShifts();

            LoadShifts();
        }

        private void LoadUserInfo()
        {
            try
            {
                connection.Open();

                string sql = @"
                    SELECT full_name, role
                    FROM employees
                    WHERE employee_id = @id
                ";

                MySqlCommand cmd = new MySqlCommand(sql, connection);
                cmd.Parameters.AddWithValue("@id", userId);

                using var reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    textBlock_nev.Text = reader["full_name"].ToString();
                    textBlock_beosztas.Text = reader["role"].ToString();
                }
            }
            finally
            {
                connection.Close();
            }
        }

        // -------------------------
        // Műszak betöltés
        // -------------------------
        private void LoadShifts()
        {
            try
            {
                connection.Open();

                string query = @"
                    SELECT
                        e.full_name AS Employee,
                        e.role AS Role,
                        s.work_date AS Date,
                        s.start_time AS Start,
                        s.end_time AS End,
                        s.shift_name AS ShiftName,
                        s.note AS Note
                    FROM shifts s
                    JOIN employees e ON e.employee_id = s.employee_id
                ";

                MySqlDataAdapter da = new MySqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                da.Fill(dt);

                grid_shifts.ItemsSource = dt.DefaultView;
            }
            finally
            {
                connection.Close();
            }
        }
    }
}

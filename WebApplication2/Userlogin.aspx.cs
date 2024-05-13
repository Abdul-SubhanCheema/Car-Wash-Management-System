using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {
            string name = txtUsername.Text;
            string Email = txtEmail.Text;
            string Pass = txtPassword.Text;
            if((isvalidcustomer(name,Email,Pass)))
            {
                Session["Name"] = name;
                Response.Redirect("Home.aspx");
            }

        }
        private bool isvalidcustomer(string name,string Email,string Pass)
        {
            bool isValid=false;
            // SQL query to check if the user exists in the Customer table
            string query = "SELECT COUNT(*) FROM PROJECT.dbo.Customer WHERE Name = @Username AND password = @Password AND Email=@Email";

            // Create a connection to the database
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a command with the SQL query and parameters
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the command
                    command.Parameters.AddWithValue("@Username", name);
                    command.Parameters.AddWithValue("@Password", Pass);
                    command.Parameters.AddWithValue("@Email", Email);

                    // Open the database connection
                    connection.Open();

                    // Execute the query
                    int count = (int)command.ExecuteScalar();

                    // Check if a matching user was found
                    isValid = count > 0;

                    // Close the database connection
                    connection.Close();
                }
            }

            return isValid;
        }
        
    }
}
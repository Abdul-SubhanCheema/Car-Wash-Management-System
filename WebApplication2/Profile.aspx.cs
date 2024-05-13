using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    
    public partial class Profile : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Session["Name"] as string;

            string query = "SELECT Name, Email, Address FROM PROJECT.dbo.Customer WHERE Name = @Username";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblName.Text = reader["Name"].ToString();
                            lblEmail.Text = reader["Email"].ToString();
                            lblAddress.Text = reader["Address"].ToString();
                        }
                    }
                }
            }
        }
        public void updateprofile(Object sender, EventArgs e)
        {
            Response.Redirect("updateprofile.aspx");

        }
    }
  
}
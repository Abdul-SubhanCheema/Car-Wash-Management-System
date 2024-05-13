using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        string connectionstring = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void update(object sender, EventArgs e)
        {
            string username = Session["Name"] as string;
            string name = txtusername.Text;
            string Pass = txtpassword.Text;
            if (!(IsUsernameTakenCustomer(name, connectionstring)))
            {
                insertdata(username, name, Pass, connectionstring);
                Response.Redirect("Profile.aspx");
            }
        }
        private bool IsUsernameTakenCustomer(string username, string connectionString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the username already exists in the customer table
                string query = "SELECT COUNT(*) FROM PROJECT.dbo.Customer WHERE Name = @Username";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }
        private void insertdata(string username, string name, string pass, string connectionstring)
        {
            string query = "UPDATE Customer SET Name = @NewName, password = @NewPassword WHERE Name = @Username";

            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@NewName", name);
                    command.Parameters.AddWithValue("@NewPassword", pass);
                    command.Parameters.AddWithValue("@Username", username);

                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
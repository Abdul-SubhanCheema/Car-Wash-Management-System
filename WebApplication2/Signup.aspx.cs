using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace WebApplication2
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string connectionstring = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Signup(Object sender, EventArgs e)
        {
            string name = txtUsername.Text;
            string Email = txtEmail.Text;
            string Pass = txtPassword.Text;
            string Address = txtAdress.Text;
            string phone = Txtphone.Text;
            string gender1 = TxtGender.Text;
            if (!(IsUsernameTakenCustomer(name, connectionstring)))
            {
                insertdata(name, Email, Pass, Address, gender1, phone, connectionstring);
                Response.Redirect("Userlogin.aspx");
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
        private void insertdata(string name,string Email,string Pass,string Address,string gender1,string phone,string connectionstring)
        {
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                connection.Open();

                string insertQuery = "INSERT INTO PROJECT.dbo.Customer (Gender, Name, Email, phone_no, Address, password) " +
                                     "VALUES (@Gender, @Name, @Email, @Phone, @Address, @Password)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, connection))
                {

                    cmd.Parameters.AddWithValue("@Gender", gender1);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", Email);
                    cmd.Parameters.AddWithValue("@Password", Pass);
                    cmd.Parameters.AddWithValue("@Address", Address);
                    cmd.Parameters.AddWithValue("@Phone", phone);


                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class contactus : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        string userid;
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Session["Name"] as string;

            string query = "SELECT customer_id FROM PROJECT.dbo.Customer WHERE Name = @Username";

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
                            userid = reader["customer_id"].ToString();
                        }
                    }
                }
            }
            if (!IsPostBack)
            {
                for (int i = 1; i <= 5; i++)
                {
                    ddlRange.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
            }
        }
        public void contact(object sender, EventArgs e)
        {
            string selectedValue = ddlRange.SelectedValue;
            string subject = txtSubject.Text;
            string comment = txtMessage.Text;
            string appointmentDate = Request.Form["appointmentDate"];
            DateTime parsedDate = DateTime.Parse(appointmentDate);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();


                string insertQuery = "INSERT INTO PROJECT.dbo.Feedback (comment, subject, rating, Date, customer_id) " +
                                     "VALUES (@Comment, @Subject, @Rating, @Date, @CustomerId)";

                // Create a SqlCommand object with the query and connection
                using (SqlCommand cmd = new SqlCommand(insertQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@Comment", comment);
                    cmd.Parameters.AddWithValue("@Subject", subject);
                    cmd.Parameters.AddWithValue("@Rating", selectedValue);
                    cmd.Parameters.AddWithValue("@Date", parsedDate);
                    cmd.Parameters.AddWithValue("@CustomerId", userid);


                    cmd.ExecuteNonQuery();
                    Response.Redirect("Home.aspx");
                }
            }
        }
    }
}
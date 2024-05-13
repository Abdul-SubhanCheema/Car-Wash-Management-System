using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WebApplication2
{
    public partial class userbooking : System.Web.UI.Page
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
            List<BookingDetails> userBookingDetails = GetUserBookingDetails(userid);
            BookingDetailsRepeater.DataSource = userBookingDetails;
            BookingDetailsRepeater.DataBind();
        }
        private List<BookingDetails> GetUserBookingDetails(string userId)
        {
            List<BookingDetails> userBookingDetails = new List<BookingDetails>();

           
            string query = "SELECT booking_id, status, date FROM PROJECT.dbo.Booking WHERE customer_id = @CustomerId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CustomerId", userId);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int bookingId = reader.GetInt32(reader.GetOrdinal("booking_id"));
                            string status = reader.GetString(reader.GetOrdinal("status"));
                            DateTime date = reader.GetDateTime(reader.GetOrdinal("date"));

                            // Create a BookingDetails object and add it to the list
                            userBookingDetails.Add(new BookingDetails
                            {
                                BookingId = bookingId,
                                Status = status,
                
                            });
                        }
                    }
                }
            }

            return userBookingDetails;
        }


    }
    public class BookingDetail
    {
        public int BookingId { get; set; }
        public string Status { get; set; }

    }
}
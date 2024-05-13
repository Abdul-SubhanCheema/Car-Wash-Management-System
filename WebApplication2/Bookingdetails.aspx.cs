using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public class BookingInfo
{
    public int BookingId { get; set; }
}
public class BookingDetails
{
    public int BookingId { get; set; }
    public List<string> Services { get; set; } = new List<string>();

    public string CustomerName { get; set; }
    public string CustomerPhone { get; set; }
    public string VehicleMake { get; set; }
    public string VehicleModel { get; set; }
    public int VehicleYear { get; set; }
    public string Status { get; set; }
}
namespace WebApplication2
{
    public partial class Bookingdetails : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        List<int> bookingIdList= new List<int>();
        public List<BookingInfo> GetBookingIds()
        {

            List<BookingInfo> bookingIds = new List<BookingInfo>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT booking_id FROM PROJECT.dbo.Booking";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int bookingId = reader.GetInt32(0);
                            bookingIds.Add(new BookingInfo { BookingId = bookingId });
                        }
                    }
                }
            }

            return bookingIds;
        }


        protected void ProcessBooking_Command(object sender, CommandEventArgs e)
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);
            

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "UPDATE PROJECT.dbo.Booking SET status = 'complete' WHERE booking_id = @BookingId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BookingId", bookingId);
                    command.ExecuteNonQuery();
                }
            }
            Response.Redirect("Adminhome.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the list of booking IDs
                List<BookingInfo> bookingIds = GetBookingIds();
                List<int> bookingIdList = bookingIds.Select(bookingInfo => bookingInfo.BookingId).ToList();

                // Get booking details for each booking ID
                List<BookingDetails> details = GetBookingDetails(bookingIdList);

                // Bind the booking details to the Repeater control
                BookingDetailsRepeater.DataSource = details;
                BookingDetailsRepeater.DataBind();
            }
        }
        protected string RenderServices(List<string> services)
        {
            string html = "";
            foreach (var service in services)
            {
                html += $"<li class='service-item'>{service}</li>";
            }
            return html;
        }

        public List<BookingDetails> GetBookingDetails(List<int> bookingIds)
        {
            List<BookingDetails> detailsList = new List<BookingDetails>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                            string query = @"
                        SELECT 
                            b.booking_id,
                            b.status,
                            c.Name AS CustomerName,
                            c.phone_no AS CustomerPhone,
                            v.Make AS VehicleMake,
                            v.Model AS VehicleModel,
                            v.Year AS VehicleYear
                        FROM 
                            PROJECT.dbo.Booking b
                        INNER JOIN 
                            PROJECT.dbo.Customer c ON b.customer_id = c.customer_id
                        INNER JOIN 
                            PROJECT.dbo.Vehicle v ON b.Vehicle_ID = v.Vehicle_ID
                        WHERE 
                            b.booking_id IN ({0});
                    ";

                // Create a parameterized string for the IN clause
                string bookingIdParams = string.Join(", ", bookingIds);
                query = string.Format(query, bookingIdParams);

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            BookingDetails details = new BookingDetails
                            {
                                BookingId = Convert.ToInt32(reader["booking_id"]),
                                CustomerName = reader["CustomerName"].ToString(),
                                CustomerPhone = reader["CustomerPhone"].ToString(),
                                VehicleMake = reader["VehicleMake"].ToString(),
                                VehicleModel = reader["VehicleModel"].ToString(),
                                Status = reader["status"].ToString(),
                                VehicleYear = Convert.ToInt32(reader["VehicleYear"])
                            };

                            detailsList.Add(details);
                        }
                    }
                }
                foreach (var detail in detailsList)
                {
                    string serviceQuery = @"
                        SELECT s.Service_Name
                        FROM PROJECT.dbo.CustomerServices cs
                        JOIN PROJECT.dbo.Services s ON cs.Service_id = s.Service_id
                        WHERE cs.booking_id = @BookingId;
                    ";

                    using (SqlCommand serviceCommand = new SqlCommand(serviceQuery, connection))
                    {
                        serviceCommand.Parameters.AddWithValue("@BookingId", detail.BookingId);

                        using (SqlDataReader serviceReader = serviceCommand.ExecuteReader())
                        {
                            while (serviceReader.Read())
                            {
                                string serviceName = serviceReader.GetString(0);
                                detail.Services.Add(serviceName);
                            }
                        }
                    }
                }
            }

            return detailsList;
        }

    }


}
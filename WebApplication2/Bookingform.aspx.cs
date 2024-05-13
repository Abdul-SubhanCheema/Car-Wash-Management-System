using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Bookingform : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        string id;
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
                            id = reader["customer_id"].ToString();
                        }
                    }
                }
            }
        }
        
        protected void Book(object sender, EventArgs e)
        {
            string selectedServicesJSON = HiddenFieldSelectedServices.Value;
            List<string> selectedServices = new JavaScriptSerializer().Deserialize<List<string>>(selectedServicesJSON);
           
            string vehicleNumber = txtVehicleNumber.Text;
            string make = txtMake.Text;
            string model = txtModel.Text;
            string year = txtYear.Text;
            int parsedYear = int.Parse(year);
            string appointmentDate = Request.Form["appointmentDate"];
            DateTime parsedDate = DateTime.Parse(appointmentDate);



            if (!IsvehiclenumberTaken(vehicleNumber, connectionString))
            {
                InsertVehicle(vehicleNumber, parsedDate, parsedYear, make, model, int.Parse(id));
            }
            string vehicleid = getvehicleid(vehicleNumber);
            InsertBooking(parsedDate, int.Parse(id), int.Parse(vehicleid));




            int bookingid = GetUnpaidBookingId();


            foreach (string serviceName in selectedServices)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string serviceQuery = "INSERT INTO PROJECT.dbo.CustomerServices (booking_id, Service_id) VALUES (@bookingid, (SELECT Service_id FROM Services WHERE Service_Name = @ServiceName));";

                    using (SqlCommand command = new SqlCommand(serviceQuery, connection))
                    {
                        command.Parameters.AddWithValue("@bookingid", bookingid);
                        command.Parameters.AddWithValue("@ServiceName", serviceName);

                        command.ExecuteNonQuery();
                    }
                }
            }
            Response.Redirect("payment.aspx");
        }
        public string getvehicleid(string vehicleNumber)
        {
            string vehicleid=null;
            string query = "SELECT Vehicle_ID FROM PROJECT.dbo.Vehicle WHERE License_plate_number = @Username";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", vehicleNumber);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            vehicleid = reader["Vehicle_ID"].ToString();
                        }
                    }
                }
            }
            return vehicleid;
        }
        public void InsertBooking(DateTime date, int customerId, int vehicleId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertSql = "INSERT INTO PROJECT.dbo.Booking (date, customer_id, Vehicle_ID) " +
                                   "VALUES (@Date, @CustomerId, @VehicleId)";

                using (SqlCommand cmd = new SqlCommand(insertSql, connection))
                {
                    cmd.Parameters.AddWithValue("@Date", date);
                    cmd.Parameters.AddWithValue("@CustomerId", customerId);
                    cmd.Parameters.AddWithValue("@VehicleId", vehicleId);

                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void InsertVehicle(string licensePlate, DateTime lastWashedDate, int year, string make,string model, int customerId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string insertSql = "INSERT INTO PROJECT.dbo.Vehicle (License_plate_number, Last_Washed_Date, Year, Make,Model, customer_id) " +
                                   "VALUES (@LicensePlate, @LastWashedDate, @Year, @Make,@Model, @CustomerId)";

                using (SqlCommand cmd = new SqlCommand(insertSql, connection))
                {
                    cmd.Parameters.AddWithValue("@LicensePlate", licensePlate);
                    cmd.Parameters.AddWithValue("@LastWashedDate", lastWashedDate);
                    cmd.Parameters.AddWithValue("@Year", year);
                    cmd.Parameters.AddWithValue("@Make", make);
                    cmd.Parameters.AddWithValue("@Model", model);
                    cmd.Parameters.AddWithValue("@CustomerId", customerId);

                    cmd.ExecuteNonQuery();
                }
            }
        }
        private bool IsvehiclenumberTaken(string numer, string connectionString)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

           
                string query = "SELECT COUNT(*) FROM PROJECT.dbo.Vehicle WHERE License_plate_number = @Username";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", numer);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }
        public List<servicearr1> getbookingservices()

        {
            string query = "SELECT Service_id, Service_Name,Description  FROM PROJECT.dbo.Services";
            List<servicearr1> Services = new List<servicearr1>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            servicearr1 servicearr1 = new servicearr1
                            {
                                serviceid = reader["Service_id"].ToString(),
                                servicename = reader["Service_Name"].ToString(),
                                description = reader["Description"].ToString(),
                            };
                            Services.Add(servicearr1);
                        }
                    }
                }
            }
            return Services;
        }
        public int GetUnpaidBookingId()
        {
            int unpaidBookingId = -1; // Default value if no unpaid booking is found

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string sql = "SELECT TOP 1 b.booking_id " +
                             "FROM PROJECT.dbo.Booking AS b " +
                             "LEFT JOIN PROJECT.dbo.Payment AS p ON b.booking_id = p.booking_id " +
                             "WHERE p.booking_id IS NULL";

                using (SqlCommand cmd = new SqlCommand(sql, connection))
                {
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        unpaidBookingId = (int)result; // Assuming booking_id is an INT
                    }
                }
            }

            return unpaidBookingId;
        }
    }
    public class servicearr1
    {
        public string serviceid { get; set; }
        public string servicename { get; set; }
        public string description { get; set; }
    }
}
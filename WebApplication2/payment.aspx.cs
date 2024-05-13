using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication2
{

    public partial class payment : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";
        int bookingid;
        decimal totalBill;
        decimal discount;

        protected void Page_Load(object sender, EventArgs e)
        {
            bookingid = GetUnpaidBookingId();
                List<Payment> services = getservices();
                ServiceRepeater.DataSource = services;
                ServiceRepeater.DataBind();



                 totalBill = CalculateTotalBill(services);
                int custid = getcustomerid();
                bool check = discountcheck(custid);
                if(check)
                {
                    discount = 10;
                    totalBill -= discount;
                    Span2.InnerText = discount.ToString("0.00");
                    Span1.InnerText = totalBill.ToString("0.00");
                }
                else
                {
                    Span1.InnerText = totalBill.ToString("0.00");
                    discount = 0;
                    Span2.InnerText = discount.ToString("0.00"); 
                }

        }
        protected void processPayment(object sender, EventArgs e)
        {
            DateTime bookingDate = DateTime.Now;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT date FROM PROJECT.dbo.Booking WHERE booking_id = @BookingId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BookingId", bookingid);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                             bookingDate = reader.GetDateTime(0);
                        }
                    }
                }
            }
            insertpay(bookingDate);
           
        }
        public void insertpay(DateTime bookingDate)
        {
            Response.Write(totalBill);
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "INSERT INTO PROJECT.dbo.Payment (Payment_Amount, Payment_Date, Discounts, booking_id)" +
                                "VALUES (@PaymentAmount, @PaymentDate, @Discounts, @BookingId)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@PaymentAmount", totalBill);
                    command.Parameters.AddWithValue("@PaymentDate", bookingDate);
                    command.Parameters.AddWithValue("@Discounts", discount);
                    command.Parameters.AddWithValue("@BookingId", bookingid);

                    command.ExecuteNonQuery();
                    Response.Redirect("Home.aspx");
                }
            }

        }
        protected bool discountcheck(int customerIdToCheck)
        {
            bool check=false;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT COUNT(*) AS BookingCount FROM PROJECT.dbo.Booking WHERE customer_id = @CustomerId HAVING COUNT(*) > 5";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CustomerId", customerIdToCheck);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int bookingCount = reader.GetInt32(0);
                            if (bookingCount > 5)
                            {
                               check= true;
                            }
                            else
                            {
                                check= false;
                            }
                        }
                    }
                }
            }
            return check;   
        }
        private decimal CalculateTotalBill(List<Payment> services)
        {
            decimal total = 0;

            foreach (Payment service in services)
            {
                if (decimal.TryParse(service.payserviceprice, out decimal servicePrice))
                {
                    total += servicePrice;
                }
            }

            return total;
        }
        public int GetUnpaidBookingId()
        {
            int unpaidBookingId = -1; 

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
                        unpaidBookingId = (int)result; 
                    }
                }
            }

            return unpaidBookingId;
        }
        public int getcustomerid()
        {
            int customerId=-1;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
               
                string query = "SELECT customer_id FROM PROJECT.dbo.Booking WHERE booking_id = @BookingId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BookingId", bookingid);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                             customerId = reader.GetInt32(0);
                        }
                    }
                }
            }
            return customerId;
        }
        public List<Payment> getservices()
        {
            string query = @"
            SELECT
                s.Service_id,
                s.Service_Name,
                SUM(1 * i.Price) AS TotalServicePrice
            FROM
                PROJECT.dbo.Services s
            INNER JOIN
                PROJECT.dbo.ServiceInventory si ON s.Service_id = si.Service_id
            INNER JOIN
                PROJECT.dbo.Inventory i ON si.Inventory_ID = i.Inventory_ID
            WHERE
                s.Service_id IN (SELECT Service_id FROM PROJECT.dbo.CustomerServices WHERE booking_id = @BookingId)
            GROUP BY
                s.Service_id, s.Service_Name;
        ";


            List<Payment> Services = new List<Payment>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BookingId", bookingid);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Payment servicearr = new Payment
                            {
                                payservicename = reader["Service_Name"].ToString(),
                                payserviceprice = reader["TotalServicePrice"].ToString(),

                            };
                            Services.Add(servicearr);
                        }
                    }
                }
            }
            return Services;
        }
    }
    public class Payment
    {
        public string payserviceprice { get; set; }
        public string payservicename { get; set; }

    }
}
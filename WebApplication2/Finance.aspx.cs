using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public class PaymentInfo
{
    public int TransactionId { get; set; }
    public decimal PaymentAmount { get; set; }
    public DateTime PaymentDate { get; set; }
    public decimal Discounts { get; set; }
    public string CustomerName { get; set; }
    public int BookingId { get; set; }
}


namespace WebApplication2
{
    public partial class Finance : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            List<PaymentInfo> paymentInfo = GetPaymentInfo();
            PaymentInfoRepeater.DataSource = paymentInfo;
            PaymentInfoRepeater.DataBind();
        }
        public List<PaymentInfo> GetPaymentInfo()
        {
            List<PaymentInfo> payments = new List<PaymentInfo>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = @"
            SELECT 
                p.Transaction_id, 
                p.Payment_Amount, 
                p.Payment_Date, 
                p.Discounts, 
                c.Name AS CustomerName,
                p.booking_id
            FROM 
                PROJECT.dbo.Payment p
            INNER JOIN 
                PROJECT.dbo.Booking b ON p.booking_id = b.booking_id
            INNER JOIN 
                PROJECT.dbo.Customer c ON b.customer_id = c.customer_id;
        ";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            PaymentInfo payment = new PaymentInfo
                            {
                                TransactionId = reader.GetInt32(0),
                                PaymentAmount = reader.GetDecimal(1),
                                PaymentDate = reader.GetDateTime(2),
                                Discounts = reader.GetDecimal(3),
                                CustomerName = reader.GetString(4),
                                BookingId = reader.GetInt32(5)
                            };

                            payments.Add(payment);
                        }
                    }
                }
            }

            return payments;
        }

    }
}
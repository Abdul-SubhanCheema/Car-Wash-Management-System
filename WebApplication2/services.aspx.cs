using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class services : System.Web.UI.Page
    {
        string connectionString = @"Data Source=DANIYAL\SQLEXPRESS;Initial Catalog=PROJECT;Integrated Security=True;TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public  List<servicearr>  getservices()
        {
            string query = "SELECT Service_id, Service_Name,Description  FROM PROJECT.dbo.Services";
            List<servicearr> Services = new List<servicearr>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using(SqlDataReader reader = command.ExecuteReader()) 
                    {
                        while (reader.Read())
                        {
                            servicearr servicearr = new servicearr
                            {
                                serviceid  =  reader["Service_id"].ToString(),
                                servicename = reader["Service_Name"].ToString(),
                                description = reader["Description"].ToString(), 
                            };
                            Services.Add(servicearr);
                        }
                    }
                }
            }
            return Services;
        }
    }
    public class servicearr
    {
        public string serviceid {  get; set; }
        public string servicename { get; set; }
        public string description { get; set; }
    }
}
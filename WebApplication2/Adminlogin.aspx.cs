using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void adminlogin(object sender, EventArgs e)
        {
            string name = txtUsername.Text;
            string Email = txtEmail.Text;
            string Pass = txtPassword.Text;
            if ((name=="Admin" && Email=="@" && Pass=="pass"))
            {
                Session["Name"] = name;
                Response.Redirect("Adminhome.aspx");
            }

        }
    }
}
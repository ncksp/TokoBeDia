using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TokoBeDia.View.Master
{
    public partial class Guest : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                navlogout.Visible = false;
                navprofile.Visible = false;
                return;
            }

            navlogin.Visible = false;

            if (Int32.Parse((string)Session["roleid"]) == Constants.Roles.ADMIN_ROLE)
            {
                navuser.Visible = true;
                navproductlist.Visible = true;
                navpayment.Visible = true;
                navreport.Visible = true;
            }

            if (Int32.Parse((string)Session["roleid"]) == Constants.Roles.USER_ROLE)
            {
                navcart.Visible = true;
                navhistory.Visible = true;
            }
            //Logout.Text = (string)Session["roleid"];

        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session["userid"] = null;
            Session["roleid"] = null;
            Response.Redirect(Constants.Routes.HOME_ROUTE);
        }
    }
}
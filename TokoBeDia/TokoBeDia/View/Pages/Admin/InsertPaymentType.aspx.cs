using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;

namespace TokoBeDia.View.Pages.Admin
{
    public partial class InsertPaymentType : System.Web.UI.Page
    {
        static PaymentTypeController payment = new PaymentTypeController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["roleid"] == null)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }

            if (Int32.Parse((string)Session["roleid"]) != Constants.Roles.ADMIN_ROLE)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }
        }
        [System.Web.Services.WebMethod]
        public static String[] Insert(String type)
        {
            String[] message = payment.Add(type);
            return message;
        }
    }
}
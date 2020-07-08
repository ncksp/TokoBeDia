using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;

namespace TokoBeDia.View.Pages.Admin
{
    public partial class UpdatePaymentType : System.Web.UI.Page
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

            int id = Int32.Parse(Request.QueryString["id"]);
            txtid.Attributes["Value"] = id.ToString();
            setDataForm(id);
        }
        private void setDataForm(int id)
        {
            var productData = payment.GetPaymentType(id);
            if (productData == null)
            {
                Response.Redirect(Constants.Routes.PAYMENT_TYPE_ROUTE);
                return;
            }
            txttype.Attributes["Value"] = productData.Type.ToString();
            txttypeold.Attributes["Value"] = productData.Type.ToString();
        }

        [System.Web.Services.WebMethod]
        public static String[] Update(String id, String oldType, String type)
        {
            String[] message = payment.Update(id, oldType, type);
            return message;
        }
    }
}
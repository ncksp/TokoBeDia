using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;

namespace TokoBeDia.View.Pages.Admin
{
    public partial class PaymentTypes : System.Web.UI.Page
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
            loadDataPaymentType();
        }
        public void loadDataPaymentType()
        {
            payment = new PaymentTypeController();
            dataProductTypes.DataSource = payment.GetPaymentTypes();
            dataProductTypes.DataBind();
        }

        protected void LinkButtonEdit_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)(sender);
            Response.Redirect(Constants.Routes.UPDATE_PAYMENT_TYPE_ROUTE + "?id=" + button.CommandArgument);
        }

        [System.Web.Services.WebMethod]
        public static String[] Delete(String id)
        {
            String[] message = payment.Delete(id);
            return message;
        }
    }
}
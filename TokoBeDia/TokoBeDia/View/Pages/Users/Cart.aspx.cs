using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Model;

namespace TokoBeDia.View.Pages.Users
{
    public partial class Cart : System.Web.UI.Page
    {
        static CartController controller = new CartController();
        static PaymentTypeController payment = new PaymentTypeController();
        protected int userID;
        protected string grandTotal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["roleid"] == null || Int32.Parse((string)Session["roleid"]) != Constants.Roles.USER_ROLE)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }
            this.userID = Int32.Parse(Session["userid"].ToString());
            
            this.loadDataProduct();

            var paymentList = payment.GetPaymentTypes();
            txtpayment.Items.Add(new ListItem("-----", "", false));
            foreach (PaymentType productType in paymentList)
            {
                txtpayment.Items.Add(new ListItem(productType.Type, productType.ID.ToString()));

            }

        }

        public void loadDataProduct()
        {
            controller = new CartController();
            var data = controller.GetCarts(this.userID);

            dataCart.DataSource = data;
            dataCart.DataBind();

            if (dataCart.Rows.Count == 0)
                checkoutForm.Visible = false;

        }
        [System.Web.Services.WebMethod]
        public static String[] Add(String productID, String userID)
        {
            String[] message = controller.Add(Int32.Parse(productID), Int32.Parse(userID), 1);
            return message;
        }
        [System.Web.Services.WebMethod]
        public static String[] Delete(String id)
        {
            String[] message = controller.Delete(id);
            return message;
        }
        [System.Web.Services.WebMethod]
        public static String[] Checkout(String paymentID, String userID)
        {
            String[] message = controller.Checkout(Int32.Parse(userID), Int32.Parse(paymentID));
            return message;
        }
        protected void LinkButtonEdit_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)(sender);
            Response.Redirect(Constants.Routes.UPDATE_CART + "?id=" + button.CommandArgument);
        }

    }
}
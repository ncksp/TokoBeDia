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
    public partial class UpdateCart : System.Web.UI.Page
    {
        static CartController controller = new CartController();
        protected int userID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["roleid"] == null || Int32.Parse((string)Session["roleid"]) != Constants.Roles.USER_ROLE)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }
            this.userID = Int32.Parse(Session["userid"].ToString());
            int id = Int32.Parse(Request.QueryString["id"]);
            txtid.Attributes["Value"] = id.ToString();
            setDataForm(id);
        }

        protected void setDataForm(int id)
        {
            var cartItem = controller.GetCart(id);
            if (cartItem == null)
            {
                Response.Redirect(Constants.Routes.CART_ROUTE);
                return;
            }
            txtname.InnerText = cartItem.Product.Name;
            txttype.InnerText = cartItem.Product.ProductType.Name;
            txtqty.Attributes["Value"] = cartItem.Quantity.ToString();
        }

        [System.Web.Services.WebMethod]
        public static String[] Update(String id,String qty, String userID)
        {
            String[] message = controller.Update(Int32.Parse(id), Int32.Parse(userID), Int32.Parse(qty));
            return message;

        }
    }
}
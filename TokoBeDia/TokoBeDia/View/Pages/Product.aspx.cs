using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Repositories;

namespace TokoBeDia.View.Pages
{
    public partial class Product : System.Web.UI.Page
    {
        static ProductController productController = new ProductController();

        protected int userID;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.dataProduct.Columns[5].Visible = false;
            this.dataProduct.Columns[6].Visible = false;

            addCartScript.Visible = false;
            productManagement.Visible = false;
            if (Session["roleid"] != null && Int32.Parse((string)Session["roleid"]) == Constants.Roles.ADMIN_ROLE)
            {
                this.dataProduct.Columns[5].Visible = true;
                btnaddproduct.Attributes.Remove("hidden");
                productManagement.Visible = true;
            }

            if (Session["roleid"] != null && Int32.Parse((string)Session["roleid"]) == Constants.Roles.USER_ROLE)
            {
                this.dataProduct.Columns[6].Visible = true;
                this.userID = Int32.Parse(Session["userid"].ToString());
                addCartScript.Visible = true;
            }
            loadDataProduct();
        }
        public void loadDataProduct()
        {
            productController = new ProductController();
            dataProduct.DataSource = productController.GetProducts();
            dataProduct.DataBind();
        }

        [System.Web.Services.WebMethod]
        public static String[] Delete(String id)
        {
            String[] message = productController.Delete(id);
            return message;
        }

        protected void LinkButtonEdit_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)(sender);
            Response.Redirect(Constants.Routes.UPDATE_PRODUCT_ROUTE + "?id=" + button.CommandArgument);
        }
    }
}
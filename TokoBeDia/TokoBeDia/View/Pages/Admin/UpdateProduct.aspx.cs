using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Repositories;

namespace TokoBeDia.View.Pages.Admin
{
    public partial class UpdateProduct : System.Web.UI.Page
    {
        static ProductTypeController productTypeController = new ProductTypeController();
        static ProductController productController = new ProductController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["roleid"] == null)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }

            if (Int32.Parse((string)Session["roleid"]) != Constants.Roles.ADMIN_ROLE)
            {
                Response.Redirect(Constants.Routes.PRODUCT_ROUTE);
                return;
            }
            var ProductTypeList = productTypeController.GetProductTypes();
            txttype.Items.Add(new ListItem("-----", "", false));
            foreach (var productType in ProductTypeList)
            {
                txttype.Items.Add(new ListItem(productType.Name, productType.ProductTypeID.ToString()));
            }

            int id = Int32.Parse(Request.QueryString["id"]);
            txtid.Attributes["Value"] = id.ToString();
            setDataForm(id);
        }
        
        protected void setDataForm(int id)
        {
            var productData = productController.GetProduct(id);
            if (productData == null)
            {
                Response.Redirect(Constants.Routes.PRODUCT_ROUTE);
                return;
            }
            txtname.Attributes["Value"] = productData.Name;
            txtprice.Attributes["Value"] = productData.Price.ToString();
            txtqty.Attributes["Value"] = productData.Stock.ToString();

            var selectOption = txttype.Items.FindByValue(productData.ProductTypeID.ToString());
            if (selectOption != null)
                selectOption.Selected = true;

        }
        [System.Web.Services.WebMethod]
        public static String[] Update(String id,String name, String productTypeID, String price, String qty)
        {
            String[] message = productController.Update(id, name, productTypeID, price, qty);

            return message;
            
        }
    }
}
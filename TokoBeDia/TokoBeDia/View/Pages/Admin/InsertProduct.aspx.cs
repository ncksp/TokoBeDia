using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Handler;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.View.Pages.Admin
{
    public partial class InsertProduct : System.Web.UI.Page
    {
        static ProductTypeController productTypeController = new ProductTypeController() ;
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
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }

            var ProductTypeList = productTypeController.GetProductTypes();
            txttype.Items.Add(new ListItem("-----", "",false));
            foreach (ProductType productType in ProductTypeList)
            {
                txttype.Items.Add(new ListItem(productType.Name, productType.ProductTypeID.ToString()));

            }
        }

        [System.Web.Services.WebMethod]
        public static String[] Insert(String name, String productTypeID, String price, String qty)
        {
            productController.Add(name, Int32.Parse(productTypeID), Int32.Parse(price), Int32.Parse(qty));
            return JSONResponse.setMessage("success", "Yeay.." , "Product has been added");
        }
    }
}
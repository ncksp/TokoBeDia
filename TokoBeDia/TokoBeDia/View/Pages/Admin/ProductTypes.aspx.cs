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
    public partial class ProductTypes : System.Web.UI.Page
    {
        static ProductTypeController productType = new ProductTypeController();
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
            LoadDataProductType();
        }
        public void LoadDataProductType()
        {
            productType = new ProductTypeController();
            dataProductTypes.DataSource = productType.GetProductTypes();
            dataProductTypes.DataBind();
        }

        protected void LinkButtonEdit_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)(sender);
            Response.Redirect(Constants.Routes.UPDATE_PRODUCT_TYPE_ROUTE + "?id=" + button.CommandArgument);
        }

        [System.Web.Services.WebMethod]
        public static String[] Delete(String id)
        {
            String[] message = productType.Delete(id);
            return message;
        }
    }
}
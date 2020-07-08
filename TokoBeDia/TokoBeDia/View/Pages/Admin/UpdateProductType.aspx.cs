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
    public partial class UpdateProductTypes : System.Web.UI.Page
    {
        static ProductTypeController typeController = new ProductTypeController();
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
            var productData = typeController.GetProductType(id);
            if (productData == null)
            {
                Response.Redirect(Constants.Routes.PRODUCT_TYPE_ROUTE);
                return;
            }
            txtnameold.Attributes["Value"] = productData.Name.ToString();
            txtname.Attributes["Value"] = productData.Name.ToString();
            txtdesc.InnerHtml = productData.Description.ToString();
        }


        [System.Web.Services.WebMethod]
        public static String[] Update(String id, String nameOld, String name, String desc)
        {
            String[] message = typeController.Update(id, nameOld, name, desc);

            return message;
        }
    }
}
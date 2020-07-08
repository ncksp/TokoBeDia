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
    public partial class InsertProductTypes : System.Web.UI.Page
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
        }

        [System.Web.Services.WebMethod]
        public static String[] Insert(String name, String desc)
        {
            String[] message = typeController.Add(name, desc);

            return message;
        }
    }
}
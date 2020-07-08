using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Factories;
using TokoBeDia.Repositories;

namespace TokoBeDia.View.Pages
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }
            txtid.Attributes["Value"] = Session["userid"].ToString();
        }

        [System.Web.Services.WebMethod]
        public static String[] changePassword(String id, String old, String newPass)
        {
            UserController userController = new UserController();

            string[] message = userController.ChangePassword(id, old, newPass);

            return message;
        }
    }
}
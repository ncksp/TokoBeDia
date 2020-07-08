using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Model;

namespace TokoBeDia.View.Pages
{
    public partial class Profile : System.Web.UI.Page
    {
        static UserController userController = new UserController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }
            txtid.Attributes["Value"] = Session["userid"].ToString();
            var user = userController.GetUser(Int32.Parse(Session["userid"].ToString()));

            email.Attributes["Value"] = user.Email;
            name.Attributes["Value"] = user.Name;

            gender.Items.FindByValue(user.Gender).Selected = true;
        }

        [System.Web.Services.WebMethod]
        public static String[] update(String id, String oldEmail, String email, String name, String gender)
        {
            String[] message = userController.Update(id, oldEmail, email, name, gender);

            return message;
        }
    }
}
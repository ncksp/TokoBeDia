using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using TokoBeDia.Repositories;
using TokoBeDia.Controllers;
using TokoBeDia.Model;

namespace TokoBeDia.View.Pages
{
    public partial class Register : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
            }
        }

        [System.Web.Services.WebMethod]
        public static String[] Regist(String email, String name, String password, String gender)
        {
            AuthController auth = new AuthController();
            String[] message = auth.RegisterUser(email, name, password, gender);

            return message;
        }
    }
}
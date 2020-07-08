using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;

namespace TokoBeDia.View.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        AuthController Auth = new AuthController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] != null)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
            }
            if (Request.Cookies["login"] != null)
            {
                HttpCookie reqCookies = Request.Cookies["login"];
                txtemail.Attributes["value"] = reqCookies["email"].ToString();
                txtpassword.Attributes["value"] = reqCookies["password"].ToString();
            }
            if (Session["error"] != null)
            {
                lblerror.Text = Session["error"].ToString();
                Session["error"] = null;
            }

            
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtemail.Text.ToString();
            string password = txtpassword.Text.ToString();
            
            var user = Auth.CheckUser(email, password);
            if (user == null)
            {
                Session["error"] = "Email / password incorrect";
                Response.Redirect(Constants.Routes.LOGIN_ROUTE);
                return;
            }

            string status = Auth.GetUserStatus(user);
            if (status == "Banned")
            {
                Session["error"] = "Account has been banned";
                Response.Redirect(Constants.Routes.LOGIN_ROUTE);
                return;
            }

            if (remember.Checked)
            {
                HttpCookie reqCookies = Request.Cookies["login"];

                reqCookies.Expires = DateTime.Now.AddDays(-10);

                HttpCookie cookie = new HttpCookie("login");

                cookie["email"] = email.ToString();
                cookie["password"] = password.ToString();

                cookie.Expires = DateTime.Now.AddDays(10);

                Response.Cookies.Add(cookie);
            }

            Session["userid"] = user.UserID.ToString();
            Session["roleid"] = user.RoleID.ToString();
            Response.Redirect(Constants.Routes.HOME_ROUTE);
        }
    }
}
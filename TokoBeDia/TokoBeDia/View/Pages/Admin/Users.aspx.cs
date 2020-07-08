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
    public partial class Users : System.Web.UI.Page
    {
        static UserController controller = new UserController();
        
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
            loadDataUser();
        }

        public void loadDataUser()
        {
            controller = new UserController();
            dataUser.DataSource = controller.GetUsers();
            dataUser.DataBind();
        }

        public void setOptionList()
        {
            role.Items.Clear();
            status.Items.Clear();
            role.Items.Add(new ListItem("Admin", "1"));
            role.Items.Add(new ListItem("User", "2"));

            status.Items.Add(new ListItem("Active", "Active"));
            status.Items.Add(new ListItem("Banned", "Banned"));

        }

        protected void LinkButtonEdit_Click1(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)(sender);
            if (button.CommandArgument.ToString() == Session["userid"].ToString())
            {
                errordiv.Attributes.Remove("hidden");
                return;
            }
            errordiv.Attributes.Add("hidden", "hidden");
            formEdit.Attributes.Remove("hidden");
            setOptionList();
            txtid.Attributes["Value"] = button.CommandArgument.ToString();

            var user = controller.GetUser(Int32.Parse(button.CommandArgument));

            lblHeader.InnerText = "Edit User";
            role.Items.FindByValue(user.RoleID.ToString()).Selected = true;
            status.Items.FindByValue(user.Status).Selected = true;
        }

        [System.Web.Services.WebMethod]
        public static String[] updateRole(String id, String role, String status)
        {
            String[] message = controller.UpdateStatus(id, role, status);

            return message;
        }
    }
}
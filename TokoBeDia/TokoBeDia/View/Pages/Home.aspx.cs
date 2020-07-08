using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Model;
using TokoBeDia.Report;
using TokoBeDia.Repositories;

namespace TokoBeDia.View.Pages
{
    public partial class Home : System.Web.UI.Page
    {
        HomeController home = new HomeController();
        //protected int total { get { return 10; } }
        protected int userID;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.dataProduct.Columns[4].Visible = false;

            addCartScript.Visible = false;
            if (Session["roleid"] != null && Int32.Parse((string)Session["roleid"]) == Constants.Roles.USER_ROLE)
            {
                this.dataProduct.Columns[4].Visible = true;
                this.userID = Int32.Parse(Session["userid"].ToString());
                addCartScript.Visible = true;
            }

            loadDataProduct();
            

        }
        
        private void loadDataProduct()
        {
            dataProduct.DataSource = home.GetRandomProduct();
            dataProduct.DataBind();
        }

    }
}
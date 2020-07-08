using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Model;
using System.Web.Script.Serialization;

namespace TokoBeDia.View.Pages.Users
{
    public partial class History : System.Web.UI.Page
    {
        static TransactionController transactionController = new TransactionController();
        protected int userID;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["roleid"] == null || Int32.Parse((string)Session["roleid"]) != Constants.Roles.USER_ROLE)
            {
                Response.Redirect(Constants.Routes.HOME_ROUTE);
                return;
            }

            this.userID = Int32.Parse(Session["userid"].ToString());

            transactionController = new TransactionController();
            dataHistory.DataSource = transactionController.GetTransactionHistories(userID);
            dataHistory.DataBind();
        }


        [System.Web.Services.WebMethod]
        public static string GetDetails(String userid, String headerid)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            return jsSerializer.Serialize(transactionController.GetDetailTransaction(userid, headerid));
        }

        protected void LinkButtonReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReportHistory.aspx");
        }
    }
}
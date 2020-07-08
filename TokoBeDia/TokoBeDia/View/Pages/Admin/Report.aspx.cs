using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TokoBeDia.Controllers;
using TokoBeDia.Model;
using TokoBeDia.Report;

namespace TokoBeDia.View.Pages
{
    public partial class Report : System.Web.UI.Page
    {

        protected CrystalDecisions.Web.CrystalReportViewer crystalReport;
        readonly TransactionController transaction = new TransactionController();
        protected void Page_Load(object sender, EventArgs e)
        {

            TransactionReport report = new TransactionReport();
            crystalReport.ReportSource = report;
            report.SetDataSource(GetReport(transaction.GetTransactions()));

        }
        private ReportDataSet GetReport(List<HeaderTransaction> transactions)
        {
            ReportDataSet dataSet = new ReportDataSet();

            var header = dataSet.HeaderTransactions;
            var detail = dataSet.DetailTransactions;

            foreach (var ht in transactions)
            {
                var headerTransaction = header.NewRow();

                headerTransaction["TransactionID"] = ht.TransactionID;
                headerTransaction["Username"] = ht.User.Name;
                headerTransaction["Date"] = ht.Date;

                header.Rows.Add(headerTransaction);
                foreach (var dt in ht.DetailTransactions)
                {
                    var detailTransaction = detail.NewRow();
                    detailTransaction["TransactionID"] = dt.TransactionID;
                    detailTransaction["ProductName"] = dt.Product.Name;
                    detailTransaction["Quantity"] = dt.Quantity;
                    detailTransaction["Price"] = dt.Product.Price;

                    detail.Rows.Add(detailTransaction);
                }
            }

            return dataSet;
        }

    }
}
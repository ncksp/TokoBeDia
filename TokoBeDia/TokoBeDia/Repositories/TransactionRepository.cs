using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;

namespace TokoBeDia.Repositories
{
    public class TransactionHistory
    {
        public int ID { set; get; }
        public DateTime? DateTime { set; get; }
        public String Payment { set; get; }
        public int TotalItem { set; get; }
        public int? TotalQuantity { set; get; }
        public int? TotalPrice { set; get; }
    }

    public class DetailTransactionUser
    {
        public String ProductName { set; get; }
        public String ProductType { set; get; }
        public int? Quantity { set; get; }
        public int? Price { set; get; }
        public int? SubTotal { set; get; }
    }
    public class TransactionRepository
    {
        TokoBeDiaEntities db = Database.GetInstance();

        public List<TransactionHistory> GetTransactionsHistoriesByUser(int userid)
        {
            return db.HeaderTransactions.Where(x => x.UserID == userid).Select(s => new TransactionHistory()
            {
                ID = s.TransactionID,
                DateTime = s.Date,
                Payment = s.PaymentType.Type,
                TotalItem = s.DetailTransactions.Count(),
                TotalQuantity = s.DetailTransactions.Sum(d => d.Quantity),
                TotalPrice = s.DetailTransactions.Sum(d => d.Product.Price * d.Quantity),
            }).ToList();
        }

        public List<DetailTransactionUser> GetDetailTransactions(int userid, int headerid)
        {
            return db.DetailTransactions.Where(x => x.HeaderTransaction.UserID == userid && x.TransactionID == headerid).Select(s => new DetailTransactionUser()
            {
                ProductName = s.Product.Name,
                ProductType = s.Product.ProductType.Name,
                Quantity = s.Quantity,
                Price = s.Product.Price,
                SubTotal = s.Quantity * s.Product.Price
            }).ToList();
        }

        public List<HeaderTransaction> GetTransactions()
        {
            return db.HeaderTransactions.ToList();
        }
    }

}
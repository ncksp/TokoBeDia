using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Factories
{
    public class CartFactory
    {
        CartRepository cartRepository = new CartRepository();
        TokoBeDiaEntities db = new TokoBeDiaEntities();
        public bool checkout(int userID, int paymentID)
        {
            HeaderTransaction header = new HeaderTransaction();
            header.UserID = userID;
            header.PaymentTypesID = paymentID;
            header.Date = DateTime.Now;
            var head = db.HeaderTransactions.Add(header);
            if (head == null)
                return false;

            db.SaveChanges();
            var carts = cartRepository.GetCartByUser(userID);
            foreach(Cart item in carts)
            {
                DetailTransaction detail = new DetailTransaction();
                detail.TransactionID = head.TransactionID;
                detail.ProductID = item.ProductID.Value;
                detail.Quantity = item.Quantity.Value;
                db.DetailTransactions.Add(detail);

                decreaseStock(item.ProductID.Value, item.Quantity.Value);

                cartRepository.deleteCart(item.ID);
                db.SaveChanges();
            }
            return true;
        }

        public void decreaseStock(int productId, int qty)
        {
            ProductRepository product = new ProductRepository();

            var data = product.getProduct(productId);

            data.Stock -= qty;

            db.SaveChanges();
        }
    }
}
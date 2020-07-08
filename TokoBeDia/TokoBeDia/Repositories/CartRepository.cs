using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;
namespace TokoBeDia.Repositories
{
    public class CartRepository
    {
        TokoBeDiaEntities db = Database.GetInstance();
        public List<Cart> GetCarts()
        {
            return db.Carts.ToList();
        }
        public Cart GetCart(int id)
        {
            return db.Carts.Where(x => x.ID == id).FirstOrDefault();
        }
        public List<Cart> GetCartByUser(int userid)
        {
            return db.Carts.Where(x => x.UserID == userid).ToList();
        }
        public Cart GetCartByUserAndID(int id, int userid)
        {
            return db.Carts.Where(x => x.ID == id && x.UserID == userid).FirstOrDefault();

        }
        public Cart GetCart(int productid, int userid)
        {
            return db.Carts.Where(x => x.ProductID == productid && x.UserID == userid).FirstOrDefault();
        }

        public void insertCart(Cart cart)
        {
            db.Carts.Add(cart);

            db.SaveChanges();
        }
        public void updateCart(int id, Cart cart)
        {
            if (GetCart(id) == null)
                return;

            var oldData = GetCart(id);
            oldData.Quantity = cart.Quantity;
            db.SaveChanges();
        }

        public Boolean deleteCart(int id)
        {
            if (GetCart(id) == null)
                return false;
            try
            {
                db.Carts.Remove(GetCart(id));
                db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Constants;
using TokoBeDia.Factories;
using TokoBeDia.Handler;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Controllers
{
    public class CartController
    {
        CartHandler handler = new CartHandler();
        CartRepository repository = new CartRepository();
        CartFactory factory = new CartFactory();
        public String[] Add(int productID, int userID, int qty)
        {
            var itemExist = handler.itemExist(productID, userID);

            Cart cart = new Cart();
            if (itemExist != null){
                itemExist.Quantity += 1;
                repository.updateCart(itemExist.ID, itemExist);
                return JSONResponse.setMessage("success", "Yeay...", CartStatus.UPDATE_QTY);
            }

            cart.ProductID = productID;
            cart.UserID = userID;
            cart.Quantity = qty;
            repository.insertCart(cart);
            return JSONResponse.setMessage("success", "Yeay...", CartStatus.CORRECT);
        }

        public String[] Update(int id, int userid, int qty)
        {
            var canEdit = handler.isValidData(id.ToString());

            if (!canEdit || !handler.isValidData(id, userid)) 
                return JSONResponse.setMessage("error", "Opss...", "Cart Item not found");

            if (handler.updateQtyItemExist(id, qty) == CartStatus.QTY_MORE_THAN_STOCK) 
                return JSONResponse.setMessage("error", "Opss...", CartStatus.QTY_MORE_THAN_STOCK);


            Cart cart = new Cart();
            cart.Quantity = qty;
            repository.updateCart(id, cart);

            return JSONResponse.setMessage("success", "Yeay...", CartStatus.UPDATE_QTY);
        }

        public String[] Delete(string id)
        {
            var canDelete = repository.GetCart(Int32.Parse(id));

            if (canDelete == null)
                return JSONResponse.setMessage("error", "Opss...", "Cart Item not found!");

            if (!repository.deleteCart(Int32.Parse(id)))
                return JSONResponse.setMessage("error", "Opss...", "Cart Item cannot deleted!");


            return JSONResponse.setMessage("success", "Yeay...", "Cart Item has been deleted");
        }
        public String[] Checkout(int userid, int paymentid)
        {
            bool success = factory.checkout(userid, paymentid);

            if(!success)
                return JSONResponse.setMessage("error", "Opss...", "Checkout Failed");

            return JSONResponse.setMessage("success", "Yeay...", "Checkout Success");
        }
        public Cart GetCart(int id)
        {
            return repository.GetCart(id);
        }
        public List<Cart> GetCarts(int userid)
        {
            return repository.GetCartByUser(userid);
        }
    }
}
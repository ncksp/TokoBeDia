using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Constants;
using TokoBeDia.Interfaces;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Handler
{
    public class CartHandler : IModifiable
    {
        CartRepository cart = new CartRepository();
        ProductRepository product = new ProductRepository();
        public Cart itemExist(int productID, int userID)
        {
            var existItem = cart.GetCart(productID, userID);

            return existItem;
        }

        public bool isValidData(string identity)
        {
            if (cart.GetCart(Int32.Parse(identity)) == null)
                return false;

            return true;
        }

        public bool isValidData(int id, int userid)
        {
            if (cart.GetCartByUserAndID(id, userid) == null)
                return false;

            return true;
        }
        public string updateQtyItemExist(int id, int qty)
        {
            var cartItem = cart.GetCart(id);

            var productItem = product.getProduct(Int32.Parse(cartItem.ProductID.ToString()));

            if (productItem.Stock < qty)
                return CartStatus.QTY_MORE_THAN_STOCK;

            return CartStatus.UPDATE_QTY;

        }
    }
}
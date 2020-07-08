using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TokoBeDia.Constants
{
    public class Routes
    {
        public readonly static string HOME_ROUTE = "~/View/Pages/Home.aspx";
        public readonly static string LOGIN_ROUTE = "~/View/Pages/Login.aspx";
        public readonly static string REGISTER_ROUTE = "~/View/Pages/Register.aspx";
        public readonly static string PRODUCT_ROUTE = "~/View/Pages/Product.aspx";
        public readonly static string PRODUCT_TYPE_ROUTE = "~/View/Pages/Admin/ProductTypes.aspx";
        public readonly static string PAYMENT_TYPE_ROUTE = "~/View/Pages/Admin/ProductTypes.aspx";
        public readonly static string UPDATE_PRODUCT_ROUTE = "~/View/Pages/Admin/UpdateProduct.aspx";
        public readonly static string UPDATE_PRODUCT_TYPE_ROUTE = "~/View/Pages/Admin/UpdateProductType.aspx";
        public readonly static string UPDATE_PAYMENT_TYPE_ROUTE = "~/View/Pages/Admin/UpdatePaymentType.aspx";
        public readonly static string CART_ROUTE = "~/View/Pages/Users/Cart.aspx";
        public readonly static string UPDATE_CART = "~/View/Pages/Users/UpdateCart.aspx";
    }
}
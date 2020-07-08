using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Interfaces;
using TokoBeDia.Repositories;

namespace TokoBeDia.Handler
{
    public class ProductHandler : IModifiable
    {
        ProductRepository products = new ProductRepository();
        public bool isValidData(string identity)
        {
            if (products.getProduct(Int32.Parse(identity)) == null)
                return false;

            return true;
        }
    }
}
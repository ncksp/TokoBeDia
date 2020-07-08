using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Controllers
{
    public class HomeController
    {
        ProductRepository productRepository = new ProductRepository();
        public List<Product> GetRandomProduct()
        {
            return productRepository.GetProductsRandom();
        }
    }
}
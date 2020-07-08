using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;

namespace TokoBeDia.Factories
{
    public class ProductFactory
    {
        public Product createProduct(string name, int productTypeId, int price, int qty)
        {
            Product product = new Product();
            product.Name = name;
            product.ProductTypeID = productTypeId;
            product.Price = price;
            product.Stock = qty;

            return product;
        }

        public Product updateProduct(Product product, Product newData)
        {
            product.Name = newData.Name;
            product.ProductTypeID = newData.ProductTypeID;
            product.Price = newData.Price;
            product.Stock = newData.Stock;

            return product;
        }
    }
}
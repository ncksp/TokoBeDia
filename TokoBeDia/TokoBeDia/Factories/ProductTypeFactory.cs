using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;

namespace TokoBeDia.Factories
{
    public class ProductTypeFactory
    {
        public ProductType createProductType(string name, string desc)
        {
            ProductType productType = new ProductType();
            productType.Name = name;
            productType.Description = desc;

            return productType;
        }

        public ProductType updateProductType(ProductType productType, ProductType newData)
        {
            productType.Name = newData.Name;
            productType.Description = newData.Description;
            return productType;
        }
    }
}
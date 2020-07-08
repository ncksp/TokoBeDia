using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Factories;
using TokoBeDia.Model;

namespace TokoBeDia.Repositories
{
    public class ProductTypeRepository
    {
        TokoBeDiaEntities db = Database.GetInstance();
        ProductTypeFactory typeFactory = new ProductTypeFactory();
        public List<ProductType> GetProductTypes()
        {
            return db.ProductTypes.ToList();
        }
        public ProductType getProductTypes(int id)
        {
            return db.ProductTypes.Where(x => x.ProductTypeID == id).FirstOrDefault();
        }
        public ProductType getProductTypes(string name)
        {
            return db.ProductTypes.Where(x => x.Name == name).FirstOrDefault();
        }

        public void insertProduct(ProductType productType)
        {
            db.ProductTypes.Add(productType);

            db.SaveChanges();
        }
        public void updateProduct(int id, ProductType productType)
        {
            if (getProductTypes(id) == null)
                return;

            typeFactory.updateProductType(getProductTypes(id), productType);
            db.SaveChanges();
        }

        public Boolean deleteProductType(int id)
        {
            if (getProductTypes(id) == null)
                return false;
            try
            {
                db.ProductTypes.Remove(getProductTypes(id));
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
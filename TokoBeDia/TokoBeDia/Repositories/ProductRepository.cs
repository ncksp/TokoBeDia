using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Factories;
using TokoBeDia.Model;
namespace TokoBeDia.Repositories
{
    public class ProductRepository
    {
        TokoBeDiaEntities db = Database.GetInstance();
        ProductFactory productFactory = new ProductFactory();
        public List<Product> GetProductsRandom()
        {
            return db.Products.ToList().OrderBy(e => Guid.NewGuid()).Take(5).ToList();
        }
        public List<Product> GetProducts()
        {
            return db.Products.ToList();
        }

        public void insertProduct(Product product)
        {
            db.Products.Add(product);

            db.SaveChanges();
        }
        public Product getProduct(int id)
        {
            return db.Products.Where(x => x.ProductID == id).FirstOrDefault();
        }

        public void updateProduct(int id, Product product)
        {
            if (getProduct(id) == null)
                return;

            productFactory.updateProduct(getProduct(id) , product);
            db.SaveChanges();
        }

        public Boolean deleteProduct(int id)
        {
            if (getProduct(id) == null)
                return false;
            try
            {
                db.Products.Remove(getProduct(id));
                db.SaveChanges();
                return true;
            }catch(Exception)
            {
                return false;
            }
        }
    }
}
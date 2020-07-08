using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Factories;
using TokoBeDia.Handler;
using TokoBeDia.Interfaces;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Controllers
{
    public class ProductController
    {
        ProductRepository productRepository = new ProductRepository();
        ProductFactory productFactory = new ProductFactory();
        ProductHandler productHandler = new ProductHandler();
        public List<Product> GetProducts()
        {
            return productRepository.GetProducts();
        }
        public Product GetProduct(int id)
        {
            return productRepository.getProduct(id);
        }

        public void Add(String name, int productTypeID, int price, int qty)
        {
            Product product = productFactory.createProduct(name, productTypeID, price, qty);
            productRepository.insertProduct(product);
        }

        public string[] Update(String id, String name, String productTypeID, String price, String qty)
        {
            bool canEdit = productHandler.isValidData(id);
            if (!canEdit)
                return JSONResponse.setMessage("error", "Opss...", "Product not found");
            
            Product product = productFactory.createProduct(name, Int32.Parse(productTypeID), Int32.Parse(price), Int32.Parse(qty));

            productRepository.updateProduct(Int32.Parse(id), product);
            return JSONResponse.setMessage("success", "Yeay...", "Product has been updated");
        }
        public String[] Delete(string id)
        {
            bool canDelete = productHandler.isValidData(id);

            if (!canDelete)
                return JSONResponse.setMessage("error", "Opss...", "Product not found!");

            if (!productRepository.deleteProduct(Int32.Parse(id)))
                return JSONResponse.setMessage("error", "Opss...", "Product cannot deleted!");


            return JSONResponse.setMessage("success", "Yeay...", "Product has been deleted");
        }
    }
}
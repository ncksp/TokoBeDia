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
    public class ProductTypeController
    {
        readonly ProductTypeRepository typeRepository = new ProductTypeRepository();
        readonly ProductTypeFactory typeFactory = new ProductTypeFactory();

        public String[] Add(String name, String desc)
        {
            if (typeRepository.getProductTypes(name) != null)
                return JSONResponse.setMessage("error", "Opss...", "Product type already exist");

            ProductType productType = typeFactory.createProductType(name, desc);
            typeRepository.insertProduct(productType);

            return JSONResponse.setMessage("success", "Yeay..", "Product type has been added");
        }

        public String[] Delete(String id)
        {
            var canDelete = typeRepository.getProductTypes(Int32.Parse(id));

            if (canDelete == null)
                return JSONResponse.setMessage("error", "Opss...", "Product Type not found!");

            if (!typeRepository.deleteProductType(Int32.Parse(id)))
                return JSONResponse.setMessage("error", "Opss...", "Product Type cannot deleted!");


            return JSONResponse.setMessage("success", "Yeay...", "Product Type has been deleted");
        }

        public List<ProductType> GetProductTypes()
        {
            return typeRepository.GetProductTypes();
        }

        public ProductType GetProductType(int id)
        {
            return typeRepository.getProductTypes(id);
        }

        public String[] Update(String id, String nameOld, String name, String desc)
        {
            var canEdit = typeRepository.getProductTypes(Int32.Parse(id));

            if (canEdit == null)
                return JSONResponse.setMessage("error", "Opss...", "Product type not found");


            if (nameOld != name && typeRepository.getProductTypes(name) != null)
                return JSONResponse.setMessage("error", "Opss...", "Product type already exist");

            ProductType productType = typeFactory.createProductType(name, desc);
            typeRepository.updateProduct(Int32.Parse(id), productType);

            return JSONResponse.setMessage("success", "Yeay...", "Product type has been updated");
        }
    }
}
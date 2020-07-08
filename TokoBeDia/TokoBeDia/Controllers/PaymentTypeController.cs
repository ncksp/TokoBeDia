using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Handler;
using TokoBeDia.Model;
using TokoBeDia.Repositories;
using TokoBeDia.View.Pages.Admin;

namespace TokoBeDia.Controllers
{
    public class PaymentTypeController
    {
        PaymentTypeRepository payment = new PaymentTypeRepository();
        public String[] Add(string type)
        {
            if (payment.getPaymentType(type) != null)
                return JSONResponse.setMessage("error", "Opss...", "Payment type already exist");

            PaymentType paymentType = new PaymentType();
            paymentType.Type = type;

            payment.insertPayment(paymentType);

            return JSONResponse.setMessage("success", "Yeay..", "Payment type has been added");
        }
        public String[] Update(string id, string oldType, string type)
        {
            var canEdit = payment.getPaymentType(Int32.Parse(id));

            if (canEdit == null)
                return JSONResponse.setMessage("error", "Opss...", "Payment type not found");


            if (oldType != type && payment.getPaymentType(type) != null)
                return JSONResponse.setMessage("error", "Opss...", "Payment type already exist");

            PaymentType paymentType = new PaymentType() ;
            paymentType.Type = type;
            payment.updatePayment(Int32.Parse(id), paymentType);

            return JSONResponse.setMessage("success", "Yeay...", "Payment type has been updated");
        }
        public String[] Delete(string id)
        {
            var canDelete = payment.getPaymentType(Int32.Parse(id));

            if (canDelete == null)
                return JSONResponse.setMessage("error", "Opss...", "Payment Type not found!");

            if (!payment.deletePaymentType(Int32.Parse(id)))
                return JSONResponse.setMessage("error", "Opss...", "Payment Type cannot deleted!");


            return JSONResponse.setMessage("success", "Yeay...", "Payment Type has been deleted");
        }

        public List<PaymentType> GetPaymentTypes()
        {
            return payment.GetPaymentTypes();
        }

        public PaymentType GetPaymentType(int id)
        {
            return payment.getPaymentType(id);
        }
    }
}
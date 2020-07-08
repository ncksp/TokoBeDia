using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;

namespace TokoBeDia.Repositories
{
    public class PaymentTypeRepository
    {
        TokoBeDiaEntities db = Database.GetInstance();
        public List<PaymentType> GetPaymentTypes()
        {
            return db.PaymentTypes.ToList();
        }
        public PaymentType getPaymentType(int id)
        {
            return db.PaymentTypes.Where(x => x.ID == id).FirstOrDefault();
        }
        public PaymentType getPaymentType(string type)
        {
            return db.PaymentTypes.Where(x => x.Type == type).FirstOrDefault();
        }

        public void insertPayment(PaymentType paymentTypes)
        {
            db.PaymentTypes.Add(paymentTypes);

            db.SaveChanges();
        }
        public void updatePayment(int id, PaymentType paymentTypes)
        {
            if (getPaymentType(id) == null)
                return;

            var oldData = getPaymentType(id);
            oldData.Type = paymentTypes.Type;
            db.SaveChanges();
        }

        public Boolean deletePaymentType(int id)
        {
            if (getPaymentType(id) == null)
                return false;
            try
            {
                db.PaymentTypes.Remove(getPaymentType(id));
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Handler;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Controllers
{
    public class TransactionController
    {
        TransactionRepository repository = new TransactionRepository();
        UserHandler userHandler = new UserHandler();
        public List<TransactionHistory> GetTransactionHistories(int userID)
        {
            if (!userHandler.isValidData(userID.ToString()))
                return null;

            return repository.GetTransactionsHistoriesByUser(userID);
        }

        public List<DetailTransactionUser> GetDetailTransaction(String userid, String headerid)
        {
            if (!userHandler.isValidData(userid))
                return null;

            return repository.GetDetailTransactions(Int32.Parse(userid), Int32.Parse(headerid));
        }

        public List<HeaderTransaction> GetTransactions()
        {
            return repository.GetTransactions();
        }
    }
}
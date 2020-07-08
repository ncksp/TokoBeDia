using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Model;

namespace TokoBeDia.Repositories
{
    public class Database
    {
        private static TokoBeDiaEntities db;

        private Database() { }

        public static TokoBeDiaEntities GetInstance()
        {
            if (db == null)
                db = new TokoBeDiaEntities();

            return db;
        }

    }
}
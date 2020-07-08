using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Factories;
using TokoBeDia.Model;

namespace TokoBeDia.Repositories
{
    public class UserRepository
    {
        TokoBeDiaEntities db = Database.GetInstance();
        UserFactory UserFactory = new UserFactory();
        
        public void insertUser(User user)
        {
            db.Users.Add(user);
            db.SaveChanges();
        }

        public List<User> getUsers()
        {
            return db.Users.ToList();
        }
        public User getUser(string email)
        {
            return db.Users.Where(x => x.Email == email).FirstOrDefault();
        }
        public User getUser(int id)
        {
            return db.Users.Where(x => x.UserID == id).FirstOrDefault();
        }

        public User checkUser(string email, string password)
        {
            password = password.GetHashCode().ToString();
            return db.Users.Where(u => u.Email.Equals(email) && u.Password.Equals(password)).FirstOrDefault();
        }
        public String checkStatus(string email, string password)
        {
            password = password.GetHashCode().ToString();
            return db.Users.Where(x => x.Email.Equals(email) && x.Password.Equals(password))
                           .Select(x => x.Status)
                           .FirstOrDefault();
        }

        public void update(int id, int role, String status)
        {
            UserFactory.update(getUser(id), role, status);
            db.SaveChanges();
        }
        public void update(User user)
        {
            UserFactory.update(getUser(user.UserID), user);
            db.SaveChanges();
        }
        public void changePassword(int id, String newPass)
        {
            UserFactory.changePassword(getUser(id), newPass);
            db.SaveChanges();
        }
    }
}
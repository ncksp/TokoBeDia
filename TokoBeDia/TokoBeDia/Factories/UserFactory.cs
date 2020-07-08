using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using TokoBeDia.Constants;
using TokoBeDia.Model;

namespace TokoBeDia.Factories
{
    public class UserFactory
    {
        public User createUser(string email, string name, string password, string gender)
        {
            User user = new User();
            user.Email = email;
            user.Name = name;
            user.Password = password;
            user.Gender = gender;
            user.RoleID = Roles.USER_ROLE;
            user.Status = "Active";
            return user;
        }

        public User update(User user, int role, String status)
        {
            user.RoleID = role;
            user.Status = status;
            return user;
        }
        public User update(User user, User newData)
        {
            user.Email = newData.Email;
            user.Name = newData.Name;
            user.Gender = newData.Gender;
            return user;
        }

        public User changePassword(User user, String newPass)
        {
            user.Password = newPass;
            return user;
        }

    }
}
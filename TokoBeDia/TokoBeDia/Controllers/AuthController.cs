using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Factories;
using TokoBeDia.Handler;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Controllers
{
    public class AuthController
    {
        UserRepository userRepository = new UserRepository();
        UserFactory userFactory = new UserFactory();
        public User CheckUser(string email, string password)
        {
            return userRepository.checkUser(email, password);
        }
        public string GetUserStatus(User user)
        {
            return userRepository.checkStatus(user.Email, user.Password);
        }

        public String[] RegisterUser(string email, string name, string password, string gender)
        {
            if (userRepository.getUser(email) != null)
                return JSONResponse.setMessage("error", "Opss...", "Account already registered");

            User user = userFactory.createUser(email, name, password.GetHashCode().ToString(), gender);
            userRepository.insertUser(user);
            return JSONResponse.setMessage("success", "Yeay...", "Account success to registered");
        }
    }
}
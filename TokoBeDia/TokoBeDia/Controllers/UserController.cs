using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Constants;
using TokoBeDia.Handler;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Controllers
{
    public class UserController
    {
        UserRepository userRepository = new UserRepository();
        UserHandler userHandler = new UserHandler();
        public String[] ChangePassword(string id, string old, string newPass)
        {
            
            newPass = newPass.GetHashCode().ToString();

            string status = userHandler.GetStatusPasswordChanged(id, old);

            if(status == ChangePasswordStatus.OLD_PASSWORD_INCORRECT || status == ChangePasswordStatus.USER_NOT_FOUND)
                return JSONResponse.setMessage("error", "Opss...", status);

            userRepository.changePassword(Int32.Parse(id), newPass);

            return JSONResponse.setMessage("success", "Yeay...", status);
        }
        public List<User> GetUsers()
        {
            return userRepository.getUsers();
        }
        public User GetUser(int id)
        {
            return userRepository.getUser(id);
        }

        public String[] Update(String id, String oldEmail, String email, String name, String gender)
        {
            if(GetUser(Int32.Parse(id)) == null)
                return JSONResponse.setMessage("error", "Opss...", "User not found");

            if (oldEmail != email && userRepository.getUser(email) != null)
                return JSONResponse.setMessage("error", "Opss...", "Email already registered");


            User user = new User();
            user.UserID = Int32.Parse(id);
            user.Email = email;
            user.Name = name;
            user.Gender = gender;
            userRepository.update(user);
            return JSONResponse.setMessage("success", "Yeay...", "User has been updated");
        }

        public String[] UpdateStatus(String id, String role, String status)
        {
            var data = userRepository.getUser(Int32.Parse(id));

            if (data == null)
                return JSONResponse.setMessage("error", "Opss...", "User not found");

            userRepository.update(Int32.Parse(id), Int32.Parse(role), status);
            return JSONResponse.setMessage("success", "Yeay...", "User has been updated");
        }
    }
}
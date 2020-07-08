using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TokoBeDia.Constants;
using TokoBeDia.Controllers;
using TokoBeDia.Interfaces;
using TokoBeDia.Model;
using TokoBeDia.Repositories;

namespace TokoBeDia.Handler
{
    public class UserHandler : System.Web.UI.Page, IModifiable
    {
        UserRepository userRepository = new UserRepository();
        public string GetStatusPasswordChanged(string id, string old)
        {
            var user = userRepository.getUser(Int32.Parse(id));

            if(Int32.Parse(Session["userid"].ToString()) != user.UserID)
                return ChangePasswordStatus.USER_NOT_FOUND;

            if (user == null)
                return ChangePasswordStatus.USER_NOT_FOUND;
            
            old = old.GetHashCode().ToString();
            if (old != user.Password)
                return ChangePasswordStatus.OLD_PASSWORD_INCORRECT;
            

            return ChangePasswordStatus.CORRECT;
        }

        public bool isValidData(string identity)
        {
            var data = userRepository.getUser(Int32.Parse(identity));

            if (data == null)
                return false;

            return true;
        }
    }
}
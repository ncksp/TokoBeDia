using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TokoBeDia.Handler
{
    public class JSONResponse
    {
        public static String[] setMessage(string icon, string title, string text)
        {
            String[] message = new String[4];
            message[0] = icon;
            message[1] = title;
            message[2] = text;

            return message;
        }
    }
}
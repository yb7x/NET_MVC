using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Web.Security;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 这里是储存用户身份和数据
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class MyFormsPrincipal<T> : IPrincipal where T : class,new() // 要求只能接收包含无参构造器的类
    {
        public IIdentity Identity { get; set; }

        public T userData { get; set; }

        public MyFormsPrincipal(FormsAuthenticationTicket tickt, T UserData) 
        {
            Identity = new FormsIdentity(tickt); // 票据
            userData = UserData;
        }

        public bool IsInRole(string role)
        {
            throw new NotImplementedException();
        }
    }
}

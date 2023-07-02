using Autofac;
using Autofac.Integration.Mvc;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;

namespace HPIT.RentHouse.Admin
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            #region ioc配置
            //1、创建ioc容器，创建实例
            var builder = new ContainerBuilder();
            //2、把当前程序集中的所有的Controller 都注册
            builder.RegisterControllers(typeof(MvcApplication).Assembly).PropertiesAutowired();
            //3、获取所有相关类库的程序集
            Assembly[] assemblies = new Assembly[] { Assembly.Load("HPIT.RentHouse.Service") };
            //4、当请求这个程序集下的接口里面的方法时候。就会返回对应的Services类里面的实现
            builder.RegisterAssemblyTypes(assemblies)
            .Where(type => !type.IsAbstract
                    && typeof(IServiceSupport).IsAssignableFrom(type))
                    .AsImplementedInterfaces().PropertiesAutowired();
            //如果一个实现类中定义了其他类型的接口属性,会自动给属性进行“注入”
            //Assign：赋值
            //type1.IsAssignableFrom(type2)   type2是否实现了type1接口/type2是否继承自type1
            //typeof(IServiceSupport).IsAssignableFrom(type)只注册实现了IServiceSupport的类
            //避免其他无关的类注册到AutoFac中

            var container = builder.Build();
            //5、注册系统级别的DependencyResolver，这样当MVC框架创建Controller等对象的时候都是管Autofac要对象。
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
            #endregion
        }

        /// <summary>
        /// 配置获取信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // 首先
            HttpApplication application = sender as HttpApplication;
            // 获取当前上下文 Http 请求
            HttpContext context = application.Context;
            // 返回当前上下文对象获取要使用的 cookie 
            HttpCookie cookie = context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie != null)
            {
                // 取出 Value 值
                if(cookie.Value != null)
                {
                    // 解密
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
                    // 取出信息，以内储存的 JSON 格式，所以要反序列化
                    AdminLoginDataDTO dto = JsonConvert.DeserializeObject<AdminLoginDataDTO>(ticket.UserData);
                    // 将用户数据和票据保存在当前用户对象中
                    context.User = new MyFormsPrincipal<AdminLoginDataDTO>(ticket, dto);
                }
            }
        }
    }
}

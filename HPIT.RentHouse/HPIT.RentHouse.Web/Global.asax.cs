using Autofac;
using Autofac.Integration.Mvc;
using HPIT.RentHouse.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace HPIT.RentHouse.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            #region ioc����
            //1������ioc����������ʵ��
            var builder = new ContainerBuilder();
            //2���ѵ�ǰ�����е����е�Controller ��ע��
            builder.RegisterControllers(typeof(MvcApplication).Assembly).PropertiesAutowired();
            //3����ȡ����������ĳ���
            Assembly[] assemblies = new Assembly[] { Assembly.Load("HPIT.RentHouse.Service") };
            //4����������������µĽӿ�����ķ���ʱ�򡣾ͻ᷵�ض�Ӧ��Services�������ʵ��
            builder.RegisterAssemblyTypes(assemblies)
            .Where(type => !type.IsAbstract
                    && typeof(IServiceSupport).IsAssignableFrom(type))
                    .AsImplementedInterfaces().PropertiesAutowired();
            //���һ��ʵ�����ж������������͵Ľӿ�����,���Զ������Խ��С�ע�롱
            //Assign����ֵ
            //type1.IsAssignableFrom(type2)   type2�Ƿ�ʵ����type1�ӿ�/type2�Ƿ�̳���type1
            //typeof(IServiceSupport).IsAssignableFrom(type)ֻע��ʵ����IServiceSupport����
            //���������޹ص���ע�ᵽAutoFac��

            var container = builder.Build();
            //5��ע��ϵͳ�����DependencyResolver��������MVC��ܴ���Controller�ȶ����ʱ���ǹ�AutofacҪ����
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
            #endregion
        }
    }
}

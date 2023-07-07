# 分层（Admin、Common、DTO、IService、Service、Web）

```
Admin：后台管理

Common：公共类

DTO：数据访问，传递数据

IService：接口服务

Service：服务

Web：前台页面
```

# 相关内容（使用到的部分功能解释）

## 控制反转（Inversion of Control，IoC） 与 依赖注入（Dependency Inversion，DI）

```
控制反转指的是将控制权从应用程序代码转移到框架或容器中，
这样框架或容器可以管理对象的生命周期和依赖关系。
它将应用程序从直接管理对象之间的依赖解耦，使得应用程序更容易扩展和测试。
```

```
依赖反转是控制反转的一种实现方式，
它强调要依赖于抽象接口而不是具体实现。
通过使用接口或抽象类来定义依赖关系，
应用程序可以更容易地替换其中的具体实现，
从而达到松耦合的效果。
```

**控制反转是一种思想，而依赖注入是这种思想的实现**

```
本项目中依赖注入采用的是构造方法实现的
```

## MD5加盐加密（注册、登录服务使用到）

**代码在 common层 CommonHelper类 中**

## 前端使用框架

```
文档地址：

Validform ：https://www.cnblogs.com/zeran/p/10795375.html

layUI：http://layui.apixx.net/layer/index.html

H-UI：http://www.h-ui.net/lib/datatables.js.shtml

layer.js官方传送门：https://layui.11dz.cn/layer/index.html
```

# Service 功能实现

首先创建 Entities文件夹 在文件夹中 EF框架 用来连接数据库，

创建 BaseEntity.cs 文件用来保存表格中相同字段，为后面创建增删改查方法做铺垫，所有的表都要继承 BaseEntity 类，以保证可扩展性。

```
然后再创建 BaseService 类，用来实现增删改查方法，使用 泛型类约束，保证传入正确类型
public class BaseService<T> where T : BaseEntity
{
        private RentHouseEntity db;
        /// <summary>
        /// 构造器，调用这个类时传入上下文对象
        /// </summary>
        /// <param name="DB">上下文对象</param>
        public BaseService(RentHouseEntity DB)
        {
            this.db = DB;
        }
}
```

## 添加

```
引入ef命名空间
using System.Data.Entity;
/// <summary>
/// 添加功能（传入一个实体对象）
/// </summary>
/// <param name="entity">实体对象</param>
/// <returns></returns>
public long Add(T entity)
{
       // ef内置方法实现添加
       db.Entry<T>(entity).State = EntityState.Added;
       db.SaveChanges(); // 永久提交数据
       return entity.Id; // 返回编号，如果添加成功编号大于0，否则为0
}
```

## 删除

```
/// <summary>
/// 删除
/// </summary>
/// <param name="entity">实体对象</param>
/// <returns>true flase</returns>
public bool Delete(T entity)
{
      // ef内置方法先查询，后开启修改状态，最后保存
      db.Set<T>().Attach(entity); // 查询
      db.Entry<T>(entity).State = EntityState.Modified; // 修改状态
      entity.IsDeleted = true;
      return db.SaveChanges() > 0;
}
```

## 修改

```
/// <summary>
/// 修改
/// </summary>
/// <param name="entity">实体对象</param>
/// <returns></returns>
public bool Update(T entity)
{
     // ef内置方法先查询，后开启修改状态，最后保存
     db.Set<T>().Attach(entity); // 查询
     db.Entry<T>(entity).State = EntityState.Modified; // 修改状态
     return db.SaveChanges() > 0;
}
```

## 查询

### 查询集合

```
/// <summary>
/// 查询所有未删除的数据
/// </summary>
/// <param name="WhereLambda">Lambda 表达式条件，返回true false</param>
/// <returns>可查询的泛型集合</returns>
public IQueryable<T> GetTable(Expression<Func<T, bool>> WhereLambda)
{
     return db.Set<T>().Where(WhereLambda).Where(a => a.IsDeleted == false);
}
```

### 查询一个实体

```
/// <summary>
/// 查询实体
/// </summary>
/// <param name="WhereLambda">Lambda 表达式查询条件</param>
/// <returns>一个实体对象</returns>
public T GetT(Expression<Func<T, bool>> whereLambda)
{
     return GetTable(whereLambda).FirstOrDefault();
}
```

### 排序

```
/// <summary>
/// 查询 排序
/// </summary>
/// <typeparam name="Tkey"></typeparam>
/// <param name="whereLambda">Lambda 表达式查询条件</param>
/// <param name="orderBy">排序字段</param>
/// <param name="isAsc">排序方式 true：升序 false：降序</param>
/// <returns></returns>
        public IQueryable<T> GetOrderBy<Tkey>(Expression<Func<T, bool>> whereLambda, Expression<Func<T, Tkey>> orderBy, bool isAsc)
        {
            // 升序：asc   降序：desc
            if (isAsc)
            {
                return GetTable(whereLambda).OrderBy(orderBy); // 升序
            }
            else
            {
                return GetTable(whereLambda).OrderByDescending(orderBy); // 降序
            }
        }
```

### 分页

```
        /// <summary>
        /// 分页
        /// </summary>
        /// <typeparam name="Tkey"></typeparam>
        /// <param name="PageIndex">索引 从0开始</param>
        /// <param name="PageSize">每页数据数量</param>
        /// <param name="rowCount">总行数，返回所有数据行数</param>
        /// <param name="whereLambda">Lambda 表达式条件</param>
        /// <param name="orderBy">排序条件</param>
        /// <param name="isAsc">是否升序排列 true 升序， false 降序</param>
        /// <returns></returns>
        public IQueryable<T> GetPageTable<Tkey>(int PageIndex, int PageSize, ref int rowCount, Expression<Func<T, bool>> whereLambda, Expression<Func<T, Tkey>> orderBy, bool isAsc)
        {
            rowCount = GetTable(whereLambda).Count() ;
            if (isAsc)
            {
                return GetTable(whereLambda).Skip(PageIndex * PageSize).Take(PageSize).OrderBy(orderBy); // 升序分页
            }
            else
            {
                return GetTable(whereLambda).Skip(PageIndex * PageSize).Take(PageSize).OrderByDescending(orderBy); // 降序分页
            }
        }
```

## 实现查询显示功能

### IService => DTO => Service

### 首先在 IService 层创建接口，用来规范后续方法

**这里举例子用 AdminUsers 表展示**

```
    public interface IAdminUsersService
    {
        /// <summary>
        /// 查询所有管理员信息
        /// </summary>
        /// <returns></returns>
        List<AdminListDTO> GetAdminList();
    }
```

### 然后在 DTO 层创建类文件，显示要展示的内容

```
    public class AdminListDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string PhoneNum { get; set; }
        public string Email { get; set; }
    }
```

### 最后在 Service 层引入 DTO、 IService、 Service.Entities 并继承接口

```
    public class AdminUsersService : IAdminUsersService
    {
        /// <summary>
        /// 查询所有管理员信息
        /// </summary>
        /// <returns></returns>
        public List<AdminListDTO> GetAdminList()
        {
            // 创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                List<AdminListDTO> list = bs.GetList(a => true).Select(a => new AdminListDTO()
                {
                    Name = a.Name,
                    Email = a.Email,
                    PhoneNum = a.PhoneNum,
                    Id = a.Id
                }).ToList();
                return list;
            }
        }
    }
```

**至此完成查询所有 管理员信息**

# 在 Admin.MVC 项目中配置 相关

## 安装 Autofac.MVC5 配置 在 Global 中（依赖注入【IOC】）

**引入各部分命名空间，然后在 IService 中写命名为 IServiceSupport 的接口，所有接口都要继承这个接口！**

```
            #region ioc配置
            //1、创建ioc容器，创建实例
            var builder = new ContainerBuilder();
            //2、把当前程序集中的所有的Controller 都注册
            builder.RegisterControllers(typeof(MvcApplication).Assembly).PropertiesAutowired();
            //3、获取所有相关类库的程序集
            Assembly[] assemblies = new Assembly[] { Assembly.Load("Service 层命名空间") };
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
```

**至此完成依赖注入配置，在需要使用的地方创建构造器来使用依赖注入**

**这里是使用的是 MVC 框架**

```
        private 需要使用的接口名 _命名;
        public HomeController(需要使用的接口名 命名)
        {
            _命名 = 命名;
        }
```

**调用时**

```
_命名.方法名();
```

## 安装 Qiniu 组件以及配置(验证码)

**替换项目文件至 Admin 项目，所需文件在材料文件夹中**

1. 添加 Common 引用

2. 替换 CommonHelper、MVCHelper类文件，放在 Common 项目中

3. 找报错并安装包 System.Configuration.ConfigurationManager

4. 安装 Microsoft.AspNet.Mvc 本地

5. 重新生成解决方案

```
Qiniu 为云服务
```

```
CommonHelper 为计算MD5哈希值、生成验证码、获取服务器IP地址等
```

```
MVCHelper 为处理一些常见的需求，例如获取验证错误信息、操作查询字符串或将视图渲染为字符串等
```

## 安装 CaptchaGen 包，用来完成验证码功能

**注意需要在 CommonHelper 类中找到 "获取盐（用户登录密码）+生成验证码文字" 方法 注意使用 Session[] 来保存数据**

```
生成验证码方法

ImageFactory.GenerateImage(验证码文字,高度,宽度,字体大小,扭曲程度(越大越扭曲))

        /// <summary>
        /// 验证码随机生成
        /// </summary>
        /// <returns>图片文件类型</returns>
        public ActionResult Getvc()
        {
            // 1、生成图像 包含四个字符串类型(在CommonHelper中找到随机生成数的方法)
            string  cod= CommonHelper.CreateVerifyCode(4);
            // 保存信息 到 Session 以便验证验证码
            Session["code"] = code;
            // 2、图文文件流
            MemoryStream fs = ImageFactory.GenerateImage code, 40, 100, 20, 10);
            // 3、输出图片类型文件
            return File(fs, "image/jpeg");
        }
```

**最后在需要显示验证码的地方加入图片地址 /控制器名/方法名(Getvc)**

```
需要点击刷新时

前台代码需要写入JS
放在最下面

@section footScript{
    <script type="text/javascript">
        $("#imgVerifyCode, #btn_ChangeImg").click(function () {
            $("#imgVerifyCode").attr("src", "/RentHouse/Getvc?i=" + Math.random());
        })
    </script>    
}
```

# 登录模块（在此项目中）

## 首先在 DTO 层创建登陆所需要的四个字段，并添加特性验证，注意命名要与前台控件 name 字段匹配

```
        [Required(ErrorMessage = "请输入电话号码")]
        public int PhoneNum { get; set; }
        [Required(ErrorMessage = "请输入密码")]
        public int Password { get; set; }
        [Required(ErrorMessage = "请输入验证码")]
        public int VerCode { get; set; }
        public int IsRemember { get; set; }
```

## 然后在控制器中书写 登录 方法体，注意标记为 [HttpPost]

**首先书写失败代码**

### 在 common 中创建 AjaxResult 类，用来存储最终结果

```
    /// <summary>
    /// 枚举
    /// </summary>
    public enum ResultState
    {
        Error,
        Success
    }
    /// <summary>
    /// AJAX类，用来显示结果（使用构造器赋予值）
    /// </summary>
    public class AjaxResult
    {
        public ResultState State { get; set; }
        public string Message { get; set; }
        public AjaxResult(ResultState state, string message)
        {
            this.State = state;
            this.Message = message;
        }
    }
```

### 在控制器中书写 登录验证 模块代码，要引用 common层 命名空间，调用其中 MVCHelper 中的 GetValidMsg 方法，用来 实体验证 报错

```
        #region 依赖注入使用

        private IAdminUsersService _adminUsersService;
        public RentHouseController(IAdminUsersService adminUsersService)
        {
            _adminUsersService = adminUsersService;
        }

        #endregion
        
        
        /// <summary>
        /// 登录功能
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Login(AdminLoginDTO dto)
        {
            // 实体验证
            if (ModelState.IsValid)
            {
                // 验证验证码
                // 都转化为小写
                if (dto.VerCode.ToString().ToLower() == Session["code"].ToString().ToLower())
                {
                    // 判断手机号、密码验证是否通过
                    if (_adminUsersService.AdminLogin(dto))
                    {
                        return Json(new AjaxResult(ResultState.Success, "登陆成功"));
                    }
                    else
                    {
                        return Json(new AjaxResult(ResultState.Error, "手机号或密码输入有误输入有误"));
                    }
                }
                else
                {
                    // 验证失败
                    return Json(new AjaxResult(ResultState.Error, "验证码输入有误"));
                }
            }
            else
            {
                // 登陆失败
                return Json(new AjaxResult(ResultState.Error, MVCHelper.GetValidMsg(ModelState)));
            }
        }
```

**上述代码中使用到了依赖注入，用以通过接口访问到具体方法的实现，减少耦合性。**

**书写上述代码前要完成下述操作，以保证上述代码中 判断验证手机号、密码**

### 同时在 IService 层 IAdminUsersService 接口中 书写接口方法，用来规范 Service 层中 AdminUsersService类 的方法，用来完成登陆服务

```
IService:


    public interface IAdminUsersService : IServiceSupport
    {
        /// <summary>
        /// 管理员登陆
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        bool AdminLogin(AdminLoginDTO dto);
    }
```

**在 Service 中的 AdminUsersService类 中实现该方法**

**注意要添加 Common 的命名空间，这里使用到了CalcMD5()方法，用来加密加盐**

```
        /// <summary>
        /// 登录密码验证
        /// </summary>
        /// <param name="dto">用户输入的账户密码</param>
        /// <returns>true false</returns>
        public bool AdminLogin(AdminLoginDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                var model = bs.Get(a => a.PhoneNum == dto.PhoneNum);
                if (model != null)
                {
                    // 验证密码
                    // 用户输入的密码加盐加密后再对比表中数据
                    // 使用 Common 中的 CalcMD5()方法对输入的数据进行 MD5加密加盐 后对比表中加密加盐的数据
                    if (CommonHelper.CalcMD5(dto.Password + model.PasswordSalt) == model.PasswordHash)
                    {
                        // 成功
                        return true;
                    }
                    else
                    {
                        // 失败
                        return false;
                    }
                }
                else
                {
                    // 失败
                    return false;
                }
            }
        }
```

## 前台页面采用 AJAX+Validform 方式，用来向服务器发送登录请求

**注意前后台 命名 保持一致（name 字段与后台接收数据匹配）**

```
        // 使用 Validform 方式验证页面表单
        var vf = $("#formLogin").Validform({ tiptype: 2 });
        // 注册单击事件
        $("#btn_Login").click(function () {
            // 验证表单
            if (vf.check(false)) {
                $.ajax({
                    type: "post",
                    url: "/RentHouse/Login",
                    data: $("#formLogin").serializeArray(),
                    dataType: "json",
                    success: function (result) {
                        if (result.State == 1) {
                            location.href = "/RentHouse/Index"
                        } else {
                            // 错误
                            alert(result.Message);
                        }
                    },
                    error: function () {
                        // 错误
                        alert(result.Message);
                    }
                })
            }
        })
```

### 这里有一个 Forms 身份验证

#### 在 Admin 中配置

```
首先在 Web.config 中配置

      <!--forms验证-->
      <authentication mode="Forms">
          <forms name="LoginName" loginUrl="/RentHouse/Login" path="/" defaultUrl="/RentHouse/Index"></forms>
      </authentication>
```

#### 在 DTO 层中创建 AdminLoginDateDTO 用来传递数据

```
    public class AdminLoginDataDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }

        public string PhoneNum { get; set; }

        public string Email { get; set; }

        public string RoleName { get; set; }

    }
```

#### 在 Service层 AdminUsersService 中，需要安装 Newtonsoft.Json12.0.2 版本

**先把用户数据转化为 JSON 格式，创建 cookie 对象**

```
        /// <summary>
        /// 用户数据保存到Cookie中，用于Forms身份验证和授权
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <param name="isRemember">是否长时间验证</param>
        public void SaveUserData(AdminLoginDataDTO dto, bool isRemember)
        {
            // 把用户数据转化为  JSON 格式
            string userData = JsonConvert.SerializeObject(dto);
            FormsAuthenticationTicket tickt = new FormsAuthenticationTicket(2, "LoginName", DateTime.Now, DateTime.Now.AddDays(1), false, userData);
            // 加密
            string cookieEncrypt = FormsAuthentication.Encrypt(tickt);
            // 创建 cookie
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, cookieEncrypt);
            cookie.Path = FormsAuthentication.FormsCookiePath;
            // 设置 cookie 是否为长时间验证
            if (isRemember)
            {
                cookie.Expires = DateTime.Now.AddHours(6);
            }
            // 获取当前上下文对象来保存 cookies
            HttpContext context = HttpContext.Current;
            // 把现有的储存的 cookie 移除
            context.Response.Cookies.Remove(FormsAuthentication.FormsCookieName);
            // 响应到客户端
            context.Response.Cookies.Add(cookie);
        }
```

**在登录密码验证中**

```
                        // 添加 Cook 信息
                        //var role = model.T_Roles.FirstOrDefault();
                        //AdminLoginDataDTO dataDto = new AdminLoginDataDTO()
                        //{
                        //    Email = model.Email,
                        //    Id = model.Id,
                        //    Name = model.Name,
                        //    RoleName = role.Name,
                        //    PhoneNum = model.PhoneNum,
                        //};
                        // 把数据加密储存在 cookie 中
                        //SaveUserData(dataDto, dto.IsRemember);       
        
        
        /// <summary>
        /// 登录密码验证
        /// </summary>
        /// <param name="dto">用户输入的账户密码</param>
        /// <returns>true false</returns>
        public bool AdminLogin(AdminLoginDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers>(db);
                var model = bs.Get(a => a.PhoneNum == dto.PhoneNum);
                if (model != null)
                {
                    // 验证密码
                    // 用户输入的密码加盐加密后再对比表中数据
                    // 使用 Common 中的 CalcMD5()方法对输入的数据进行 MD5加密加盐 后对比表中加密加盐的数据
                    if (CommonHelper.CalcMD5(dto.Password + model.PasswordSalt) == model.PasswordHash)
                    {
                        // 添加 Cook 信息
                        var role = model.T_Roles.FirstOrDefault();
                        AdminLoginDataDTO dataDto = new AdminLoginDataDTO()
                        {
                            Email = model.Email,
                            Id = model.Id,
                            Name = model.Name,
                            RoleName = role.Name,
                            PhoneNum = model.PhoneNum,
                        };
                        // 把数据加密储存在 cookie 中
                        SaveUserData(dataDto, dto.IsRemember);

                        // 成功
                        return true;
                    }
                    else
                    {
                        // 失败
                        return false;
                    }
                }
                else
                {
                    // 失败
                    return false;
                }
            }
        }
```

**至此，登录模块完成 测试账号信息：电话号：15538568732 密码：123456**

## 首页显示登录人，身份信息

### 在 Global.asax 全局配置文件中配置获取信息

```
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
                    context.User = new MyformsPrincipal<AdminLoginDataDTO>(ticket, dto);
                }
            }
        }
```

### 在 DTO 层  添加一个新类 MyformsPrincipal 用来保存 Forms 身份验证信息

```
    public class MyFormsPrincipal<T> : IPrincipal where T : class,new() // 要求只能接收包含无参构造器的类
    {
        public IIdentity Identity { get; set; }

        public T userData { get; set; }

        public MyFormsPrincipal(FormsAuthenticationTicket tickt, T UserData) 
        {
            Identity = new FormsIdentity(tickt);
            userData = UserData;
        }

        public bool IsInRole(string role)
        {
            throw new NotImplementedException();
        }
    }
```

### 前台 Index 页面显示数据

```
首先定义两个字段，用来接收数据
在需要显示数据的地方使用语法 @命名
如：@userName 

@{
    string userName = "";
    string RoleName = "";
    var user = User as MyFormsPrincipal<AdminLoginDataDTO>;
    userName = user.userData.Name;
    RoleName = user.userData.RoleName;
}
```

### 添加特性，完善Forms验证

```
[Authorize]：只有满足授权的才能通过
```

# 权限管理页面搭建（显示、删除、添加、修改）

## 在 Z权限管理需要用到的材料 中找到文件 PredicateExtensions.cs 把他复制入 Common 层中，查看命名空间是否正确

## 在 DTO 层中创建页面显示需要的类文件 PermissionsDTO 其中有以下字段

```
namespace HPIT.RentHouse.DTO
{
    public class PermissionsDTO
    {
        public long Id { get; set; }

        public string Description { get; set; }

        public string Name { get; set; }
    }
}
```

## 然后去 IService 层创建接口 IPermissionsService 并继承 IServiceSupport 以保证可以使用依赖注入

```
namespace HPIT.RentHouse.IService
{
    public interface IPermissionsService:IServiceSupport
    {
        /// <summary>
        /// 查询权限
        /// </summary>
        /// <returns></returns>
        List<PermissionsDTO> GetPermissionsList(string Description);
    }
}
```

## 然后去 Service 层创建 PermissionsService 类文件，用来完成该模块逻辑，要继承 : IPermissionsServi 接口，以约束其内部方法、方便使用依赖注入

```
namespace HPIT.RentHouse.Service
{
    public class PermissionsService : IPermissionsService
    {
        /// <summary>
        /// 查询所有权限信息，若为空条件，则查询所有的，并且降序排列
        /// </summary>
        /// <param name="Description">查询条件</param>
        /// <returns></returns>eturns>
        public List<PermissionsDTO> GetPermissionsList(string Description)
        {
            // 1、创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 2、创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 3、查询(使用 Common 中的 ParameterExpression 类中的 Lambda 扩展方法)
                var lambda = PredicateExtensions.True<T_Permissions>(); // 返回所有数据
                if (!string.IsNullOrWhiteSpace(Description))
                {
                    lambda = lambda.And(a => a.Description.Contains(Description));
                }
                return bs.GetOrderBy(lambda, a => a.Id, false).Select(a => new PermissionsDTO()
                {
                    Id = a.Id,
                    Description = a.Description,
                    Name = a.Name
                }).ToList();
            }
        }
    }
}
```

## 前台页面显示时，创建一个单独的控制器，在Admin 中 创建 PermissionsController 控制器，用来完成页面显示操作

```
namespace HPIT.RentHouse.Admin.Controllers
{
    public class PermissionsController : Controller
    {
        #region 依赖注入

        private IPermissionsService _permissionsService;

        public PermissionsController(IPermissionsService permissionsService)
        {
            _permissionsService = permissionsService;
        }

        #endregion
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 查询所有数据显示
        /// </summary>
        /// <param name="Description"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult GetPermissionsList(string Description)
        {
            List<PermissionsDTO> List =  _permissionsService.GetPermissionsList(Description);
            return Json(new { recordsTotal = List.Count, recordsFiltered  = List.Count, data = List});
        }
    }
}
```

### 注意

```
使用到：H-UI
前台页面需要修改 AJAX 中 URL 的地址


后台需要三个字段返回
使用了匿名类型对象来创建一个包含三个属性的JSON对象，属性包括 recordsTotal （总记录数）、 recordsFiltered （过滤后的记录数）和 data （实际的数据列表）
return Json(new { recordsTotal = List.Count, recordsFiltered  = List.Count, data = List});
```

## 实现查询功能

### 只有查询权限信息

```
前台页面 若有文档就绪函数则需要放在文档就绪函数中


            // 查询方法
            $("#btn_Search").click(function () {
                var description = $("#pname").val();
                param.Description = description;
                // 重新加载数据
                table.ajax.reload();
            })
```

## 实现添加权限功能

### 这里直接使用 PermissionsDTO 类文件作为参数，因为有添加所需的两个字段，在 IService层 IPermissionsService 中写一个接口，规范添加方法，返回AjaxResult 类型

```
        /// <summary>
        /// 添加权限
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult AddPermissions(PermissionsDTO dto);
```

### 在 Service 层 PermissionsService 类文件中书写 Add 添加权限方法

```
        /// <summary>
        /// 添加权限信息
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns>Ajax true:1 false:0</returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult AddPermissions(PermissionsDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 创建添加对象
                T_Permissions model = new T_Permissions()
                {
                    Description = dto.Description,
                    CreateDateTime = DateTime.Now,
                    IsDeleted = false,
                    Name = dto.Name
                };
                if (bs.Add(model) > 0)
                {
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败");
                }
            }
        }
```

### 在控制器 PermissionsController 中写两个 Add 方法，第二个[HttpPost]标记的方法被页面调用来执行添加操作

```
        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(PermissionsDTO dto)
        {
            // 返回AjaxResult类型
            return Json(_permissionsService.AddPermissions(dto));
        }
```

### 前台 Add 页面使用到了 layer.js

```
@section footScript{
    // 引入这个 JS 组件
    <script src="~/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script>
        // 使用 Validform 方式验证页面表单
        var vf = $("#addfrm").Validform({ tiptype: 2 });

        // 单击按钮发送请求
        $("#btn_Add").click(function () {
            // 判断表单验证是否通过
            if (vf.check(false)) {
                $.ajax({
                    type: "post",
                    url: "/Permissions/Add",
                    data: $("#addfrm").serializeArray(),
                    dataType: "json",
                    success: function (r) {
                        if (r.State == 1) {
                            layer.msg(r.Message, { icon: 1, time: 2000 }, function () {
                                // 刷新
                                parent.location.reload();
                            })
                        } else {
                            layer.msg(r.Message, { icon: 2 })
                        }
                    },
                    error: function () {
                        layer.msg("操作异常", { icon: 2 })
                    }
                })
            }
        })
    </script>
}
```

## 实现修改权限信息功能

### 修改前查找数据

#### 首先去 IService 层 IPermissionsService 接口中写修改前查询方法

```
        /// <summary>
        /// 修改前查询权限
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        PermissionsDTO EditGetPermissions(long id);
```

#### 然后 Service 层 PermissionsService 类中实现接口

```
        /// <summary>
        /// 查询要修改权限信息，
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns>PermissionsDTO 类型</returns>
        public PermissionsDTO EditGetPermissions(long id)
        {
            // 1、创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 2、创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 执行操作，投射
                return bs.GetList(a => a.Id == id).Select(a => new PermissionsDTO()
                {
                    Description = a.Description,
                    Id = a.Id,
                    Name = a.Name
                }).FirstOrDefault();
            }
        }
```

#### 在前台控制器先调用这个查询方法

```
        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id">Id</param>
        /// <returns></returns>
        public ActionResult Edit(long id)
        {
            return View(_permissionsService.EditPermissions(id));
        }
```

**页面中添加 @model HPIT.RentHouse.DTO.PermissionsDTO 强类型试图需要引入类型**

### 查询到数据后修改

##### 首先在 IService 层 IPermissionsService 接口添加查询后修改方法

```
        /// <summary>
        /// 修改权限信息
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult EditPermissions(PermissionsDTO dto);
```

##### 然后 Service 层 PermissionsService 类中实现接口

```
         /// <summary>
        /// 查询后修改权限信息
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult EditPermissions(PermissionsDTO dto)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Permissions> bs = new BaseService<T_Permissions> (db);
                T_Permissions model = bs.Get(a => a.Id == dto.Id);
                model.Name = dto.Name;
                model.Description = dto.Description;
                // 调用修改方法
                if (bs.Update(model))
                {
                    return new AjaxResult(ResultState.Success, "修改成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "修改失败");
                }
            }
        }
```

##### 前台页面需要调用这个方法实现修改

```
        /// <summary>
        /// 查询后修改
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Edit(PermissionsDTO dto)
        {
            // 使用接口调用修改方法
            return Json(_permissionsService.EditPermissions(dto));
        }
```

#### 前台页面添加 AJAX 调用

**注意，前台 Id 键**

```
@Html.HiddenFor(a => a.Id, Model.Id)
```

```
@section footScript{
    <script src="~/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script>
        // 使用 Validform 方式验证页面表单
        var vf = $("#editfrm").Validform({ tiptype: 2 });

        // 单击按钮发送请求
        $("#btn_Edit").click(function () {
            // 判断表单验证是否通过
            if (vf.check(false)) {
                $.ajax({
                    type: "post",
                    url: "/Permissions/Edit",
                    data: $("#editfrm").serializeArray(),
                    dataType: "json",
                    success: function (r) {
                        if (r.State == 1) {
                            layer.msg(r.Message, { icon: 1, time: 2000 }, function () {
                                // 刷新
                                parent.location.reload();
                            })
                        } else {
                            layer.msg(r.Message, { icon: 2 })
                        }
                    },
                    error: function () {
                        layer.msg("操作异常", { icon: 2 })
                    }
                })
            }
        })
    </script>
}
```

## 实现软删除操作

### 首先在 IService 层 IPermissionsService 接口添加查询后修改方法

```
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id">页面Id</param>
        /// <returns></returns>
        AjaxResult Delete(int id);
```

### 然后 Service 层 PermissionsService 类中实现接口

```
        /// <summary>
        /// 删除权限信息
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        public AjaxResult Delete(int id)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                // 创建查询对象，根据条件查询数据
                BaseService<T_Permissions> bs = new BaseService<T_Permissions> (db);
                T_Permissions model = bs.Get(a =>a.Id == id);
                // 判断是否存在
                if (model != null)
                {
                    // 判断删除是否成功
                    if (bs.Delete(model))
                    {
                        return new AjaxResult(ResultState.Success, "删除成功");
                    }
                    else
                    {
                        return new AjaxResult(ResultState.Success, "删除失败");
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "已删除该权限");
                }
            }
        }
```

### 页面删除操作 AJAX

```
// 删除
        function del(t) {
            layer.confirm('你确定删除吗？', { icon: 3, title: '提示' }, function (index) {
                    var id = $(t).attr("data-id");
                    $.ajax({
                        type: "post",
                        url: "/Permissions/Delete/" + id,
                        dataType: "json",
                        success: function (r) {
                            if (r.State == 1) {
                                layer.msg(r.Message, { icon: 1, time: 1000 }, function () {
                                    // 刷新，关闭当前窗体
                                    location.reload();
                                })
                            } else {
                                layer.msg(r.Message, { icon: 2 })
                            }
                        },
                        error: function () {
                            layer.msg("操作异常", { icon: 2 })
                        }
                    })
                    layer.close(index);
            });
        }
```

**控制器中**

```
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Delete(int id)
        {
            // 使用接口调用修改方法
            return Json(_permissionsService.DeletePermissions(id));
        }
```

### 实现多个删除

#### 首先在 IService 层 IPermissionsService 接口添加查询后修改方法

```
        /// <summary>
        /// 删除 多个
        /// </summary>
        /// <param name="b">数组</param>
        /// <returns></returns>
        AjaxResult DeleteBatchPermissions(long[] b);
```

#### 然后 Service 层 PermissionsService 类中实现接口

```
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="b">数组</param>
        /// <returns></returns>
        public AjaxResult DeleteBatchPermissions(long[] b)
        {
            // 创还能上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建数据库操作对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions> (db);
                // 循环遍历数组，依次删除
                for (int i = 0; i < b.Length; i++)
                {
                    var id = b[i];
                    bs.Delete(bs.Get(a => a.Id ==id));
                }
                return new AjaxResult(ResultState.Success, "批量删除成功");
            }
        }
```

#### 页面批量删除

##### 首先控制器

```
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="b">数组</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteBatch(long[] b)
        {
            return Json(_permissionsService.DeleteBatchPermissions(b));
        }
```

##### 然后 AJAX

**页面上的删除操作**

```
        // 删除
        function del(t) {
            layer.confirm('你确定删除吗？', { icon: 3, title: '提示' }, function (index) {
                    var id = $(t).attr("data-id");
                    $.ajax({
                        type: "post",
                        url: "/Permissions/Delete/" + id,
                        dataType: "json",
                        success: function (r) {
                            if (r.State == 1) {
                                layer.msg(r.Message, { icon: 1, time: 1000 }, function () {
                                    // 刷新，关闭当前窗体
                                    location.reload();
                                })
                            } else {
                                layer.msg(r.Message, { icon: 2 })
                            }
                        },
                        error: function () {
                            layer.msg("操作异常", { icon: 2 })
                        }
                    })
                    layer.close(index);
            });
        }
```

# 角色列表页面搭载

## 实现列表显示，以及搜索操作

### DTO创建页面所需字段类

```
namespace HPIT.RentHouse.DTO
{
    public class RolesListDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }
    }
}
```

### IService 层添加新的接口 IRolesServic 继承 IServiceSupport

```
namespace HPIT.RentHouse.IService
{
    public interface IRolesService : IServiceSupport
    {
        /// <summary>
        /// 显示列表数据，附加搜索
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        List<RolesListDTO> GetRolesList(string Name);
    }
}
```

### Service 层继承并实现这个接口

```
namespace HPIT.RentHouse.Service
{
    public class RolesService : IRolesService
    {
        /// <summary>
        /// 查询，显示列表信息
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        public List<RolesListDTO> GetRolesList(string Name)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Roles> bs = new BaseService<T_Roles> (db);
                // 参数为空则查询所有的数据
                var model = PredicateExtensions.True<T_Roles> ();
                // 判断如果参数不为空
                if(!string.IsNullOrWhiteSpace(Name))
                {
                    model = model.And(a => a.Name.Contains(Name));
                }
                // 返回DTO数据
                return bs.GetOrderBy(model, a => a.Id, false).Select(a => new  RolesListDTO()
                {
                    Name = a.Name,
                    Id = a.Id
                }).ToList();
            }
        }
    }
}
```

### 页面显示，去复制之前的Index页面，修改部分代码即可，先创建控制器 RolesController ，完成依赖注入页面创建

```
namespace HPIT.RentHouse.Admin.Controllers
{
    public class RolesController : Controller
    {
        #region 依赖注入

        public IRolesService _rolesService;

        public RolesController(IRolesService rolesService)
        {
            _rolesService = rolesService;
        }

        #endregion
        // GET: Roles
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetRolesList(string Name)
        {
            var list = _rolesService.GetRolesList(Name);
            return Json(new { recordsTotal = list.Count, recordsFiltered = list.Count, data = list });
        }
    }
}
```

## 实现添加角色功能

### 首先在控制器中添加新的依赖注入 IPermissionsService

```
#region 依赖注入

        public IRolesService _rolesService;
        public IPermissionsService _permissionsService;

        public RolesController(IRolesService rolesService, IPermissionsService permissionsService)
        {
            _rolesService = rolesService;
            _permissionsService = permissionsService;
        }

        #endregion
```

### 然后在 Add 中直接查询所有权限信息并返回视图，由视图接收并显示

```
        /// <summary>
        /// 添加视图并显示所有权限信息
        /// </summary>
        /// <returns></returns>
        public ActionResult Add()
        {
            return View(_permissionsService.GetPermissionsList(null));
        }
```

### 视图中

```
@model IEnumerable<HPIT.RentHouse.DTO.PermissionsDTO>



             @{
                    foreach (var item in Model)
                    {
                        <div class="col-3">
                            <input type="checkbox" name="Permissions" value="@item.Id" /> @item.Description
                        </div>
                    }
                }
```

### 页面上需要显示多个复选框，需要引用另一个表的数据

```
@model IEnumerable<HPIT.RentHouse.DTO.PermissionsDTO>
```

### DTO 层创建 RolesAddDTO 类保存所需要的字段

```
namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 保存着添加需要的两个字段
    /// </summary>
    public class RolesAddDTO
    {
        public string Name { get; set; }
        public long[] PermissionsID { get; set; }
    }
}
```

### IService 层的 IRolesServic  接口中写添加

```
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult RolesAdd(RolesAddDTO dto);
```

### Service 层 RolesServic 中实现该方法

```
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        public AjaxResult RolesAdd(RolesAddDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建两个所需要的表对象
                BaseService<T_Roles> bs = new BaseService<T_Roles> (db);
                BaseService<T_Permissions> pbs = new BaseService<T_Permissions> (db);
                // 角色表添加字段，需要转换类型
                T_Roles rs = new T_Roles()
                {
                    IsDeleted = false,
                    Name = dto.Name,
                    CreateDateTime = DateTime.Now,
                };
                // 判断是否添加上角色信息
                if (bs.Add(rs) > 0)
                {
                    // 成功则继续为这个角色添加权限信息
                    for (int i = 0; i < dto.PermissionsID.Length; i++)
                    {
                        // 先存储权限编号
                        var b = dto.PermissionsID[i];
                        // 根据编号查询权限信息
                        var s = pbs.Get(a => a.Id == b);
                        // 添加权限
                        rs.T_Permissions.Add(s);
                    }
                    db.SaveChanges();
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败");
                }
            }
        }
```

### 控制器写添加方法

```
        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Add(RolesAddDTO dto)
        {
            return Json(_rolesService.RolesAdd(dto));
        }
```

### 页面调用方法

```
        // 单击按钮发送请求
        $("#btn_Add").click(function () {
            // 判断表单验证是否通过
            if (vf.check(false)) {
                $.ajax({
                    type: "post",
                    url: "/Roles/Add",
                    data: $("#addfrm").serializeArray(),
                    dataType: "json",
                    success: function (r) {
                        if (r.State == 1) {
                            layer.msg(r.Message, { icon: 1, time: 2000 }, function () {
                                // 刷新
                                parent.location.reload();
                            })
                        } else {
                            layer.msg(r.Message, { icon: 2 })
                        }
                    },
                    error: function () {
                        layer.msg("操作异常", { icon: 2 })
                    }
                })
            }
        })
```

## 实现修改角色功能

### DTO 层

#### 创建修改前查询方法需要用到的 GetRolesEditPermissionDTO GetRolesEditDTO 类，包含以下字段

```
GetRolesEditPermissionDTO:存储需要修改的复选框数据，在类中以泛型类型存储


namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 存储 permission 对象
    /// </summary>
    public class GetRolesEditPermissionDTO
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public bool isChecked { get; set; }
    }
}
```

```
GetRolesEditDTO:存储需要修改的信息


namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 这里是修改前查询到的字段
    /// </summary>
    public class GetRolesEditDTO
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public List<GetRolesEditPermissionDTO> PermissionsId { get; set; }
    }
}
```

---

### IService 层创建接口方法

```
        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        GetRolesEditDTO RolesGetEdit(long id);    
```

### Service 层实现该方法

```
        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public GetRolesEditDTO RolesGetEdit(long id)
        {
            // 创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建要操作的表的实例
                BaseService<T_Roles> bs = new BaseService<T_Roles>(db);
                BaseService<T_Permissions> pbs = new BaseService<T_Permissions>(db);
                // 获取要修改的角色信息
                var model = bs.Get(a => a.Id == id);
                // 创建返回值类型保存数据
                GetRolesEditDTO dto = new GetRolesEditDTO()
                {
                    Id = model.Id,
                    Name = model.Name
                };
                // 获取所有权限信息
                List<T_Permissions> permissionsList = pbs.GetList(b => true).ToList();
                // 获取 roles 表中所有权限信息,T_Permissions:代表外键
                var rolesPermissions = model.T_Permissions;
                // 为 GetRolesEditDTO 中的 PermissionsId 字段赋值
                dto.PermissionsId = new List<GetRolesEditPermissionDTO>();
                // 循环遍历出所有的权限数据
                foreach (var item in permissionsList)
                {
                    GetRolesEditPermissionDTO getPermission = new GetRolesEditPermissionDTO()
                    {
                        Description = item.Description,
                        Id = item.Id,
                        Name = item.Name,
                        // 如果当前的ID 与 权限 ID匹配那么说明被选中
                        isChecked = rolesPermissions.Any(x => x.Id == item.Id)
                    };
                    dto.PermissionsId.Add(getPermission);
                }
                return dto;
            }
        }
```

### 页面显示数据

#### 控制器调用方法

```
        /// <summary>
        /// 修改页面，显示要修改的信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Edit(long id)
        {
            return View(_rolesService.RolesGetEdit(id));
        }
```

### 页面 显示 以及 AJAX

#### 显示

```
@model HPIT.RentHouse.DTO.GetRolesEditDTO  //实体对象引用

@Html.HiddenFor(a => a.Id, Model.Id) // 隐藏 Id 键

            // 显示权限信息，并绑定 checked
          @{
                foreach (var item in Model.PermissionsId)
                {
                    <div class="col-3">
                        <input type="checkbox" name="PermissionsId" value="@item.Id" checked="@item.isChecked" /> @item.Description
                    </div>
                }

            }
```

#### Ajax

```
// 修改Ajax


@section footScript{
    <script src="~/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script>
        // 使用 Validform 方式验证页面表单
        var vf = $("#Editfrm").Validform({ tiptype: 2 });

        // 单击按钮发送请求
        $("#btn_Add").click(function () {
            // 判断表单验证是否通过
            if (vf.check(false)) {
                $.ajax({
                    type: "post",
                    url: "/Roles/Edit",
                    data: $("#Editfrm").serializeArray(),
                    dataType: "json",
                    success: function (r) {
                        if (r.State == 1) {
                            layer.msg(r.Message, { icon: 1, time: 2000 }, function () {
                                // 刷新
                                parent.location.reload();
                            })
                        } else {
                            layer.msg(r.Message, { icon: 2 })
                        }
                    },
                    error: function () {
                        layer.msg("操作异常", { icon: 2 })
                    }
                })
            }
        })
    </script>
}
```



### 实现修改功能

**要修改两个表，需要先清除另一张表中的外键**

#### DTO 中要用到的字段

```
namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 修改功能实现需要的字段
    /// </summary>
    public class RolesEditDTO
    {
        public long Id { get; set; }

        public string Name { get; set; }

        public long[] PermissionsID { get; set; }
    }
}
```

#### Iservice 中

```
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        AjaxResult RolesEdit(RolesEditDTO dto);
```

#### Service 中

```
        /// <summary>
        /// 修改功能
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult RolesEdit(RolesEditDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建要修改表的实例
                BaseService<T_Roles> bs = new BaseService<T_Roles> (db);
                BaseService<T_Permissions> pbs = new BaseService<T_Permissions>(db);
                // 查询外键，删除它 Clear():清除
                var model = bs.Get(a => a.Id == dto.Id) ;
                // 清除外键（清除当前所拥有的的权限）
                model.T_Permissions.Clear();
                // 修改这一项
                model.Name = dto.Name;
                // 先修改这个关系表
                if (bs.Update(model))
                {
                    // 向角色权限关系表添加 权限信息
                    for (int i = 0; i < dto.PermissionsID.Length; i++)
                    {
                        // 通过编号查询到权限信息
                        var id = dto.PermissionsID[i];
                        // 添加到表中
                        model.T_Permissions.Add(pbs.Get(a => a.Id == id));
                    }
                    db.SaveChanges() ;
                    return new AjaxResult(ResultState.Success, "修改成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "修改失败！");
                }
            }
        }
```

#### 页面使用 Ajax 实现修改

##### 控制器

```
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Edit(RolesEditDTO dto)
        {
            return Json(_rolesService.RolesEdit(dto));
        }
```

##### Ajax

```
@section footScript{
    <script src="~/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script>
        // 使用 Validform 方式验证页面表单
        var vf = $("#Editfrm").Validform({ tiptype: 2 });

        // 单击按钮发送请求
        $("#btn_Add").click(function () {
            // 判断表单验证是否通过
            if (vf.check(false)) {
                $.ajax({
                    type: "post",
                    url: "/Roles/Edit",
                    data: $("#Editfrm").serializeArray(),
                    dataType: "json",
                    success: function (r) {
                        if (r.State == 1) {
                            layer.msg(r.Message, { icon: 1, time: 2000 }, function () {
                                // 刷新
                                parent.location.reload();
                            })
                        } else {
                            layer.msg(r.Message, { icon: 2 })
                        }
                    },
                    error: function () {
                        layer.msg("操作异常", { icon: 2 })
                    }
                })
            }
        })
    </script>
}
```





## 实现删除角色功能

### IService 层

```
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        AjaxResult RolesDelete(long id);
```

### Service 层

```
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult RolesDelete(long id)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建数据库连接
                BaseService<T_Roles> bs = new BaseService<T_Roles>(db);
                // 查询要删除的数据
                T_Roles model = bs.Get(a => a.Id == id);
                // 判断 ,如果存在则清除对应表数据
                if (model != null)
                {
                    // 清除 对应的角色权限关系表中的数据
                    model.T_Permissions.Clear();
                    // 删除，并判断状态
                    if (bs.Delete(model))
                    {
                        return new AjaxResult(ResultState.Success, "角色删除成功！");
                    }
                    else
                    {
                        return new AjaxResult(ResultState.Error, "删除失败！");
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "该角色已删除！");
                }
            }
        }
```

### 页面显示

#### 控制器

```
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(long id)
        {
            return Json(_rolesService.RolesDelete(id));
        }
```

#### 页面Ajax

```
         // 删除
        function del(t) {
            layer.confirm('你确定删除吗？', { icon: 3, title: '提示' }, function (index) {
                    var id = $(t).attr("data-id");
                    $.ajax({
                        type: "post",
                        url: "/Roles/Delete/" + id,
                        dataType: "json",
                        success: function (r) {
                            if (r.State == 1) {
                                layer.msg(r.Message, { icon: 1, time: 1000 }, function () {
                                    // 刷新，关闭当前窗体
                                    location.reload();
                                })
                            } else {
                                layer.msg(r.Message, { icon: 2 })
                            }
                        },
                        error: function () {
                            layer.msg("操作异常", { icon: 2 })
                        }
                    })
                    layer.close(index);
            });
        }
```



## 批量删除

### IService 层

```
         /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        AjaxResult RolesDelete(long[] ids);
```

### Sercvice 层

```
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult RolesDelete(long[] ids)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建操作数据
                BaseService<T_Roles> bs = new BaseService<T_Roles>(db);
                // 首先循环遍历 删除 外键表（角色权限关系表）
                for (int i = 0; i < ids.Length; i++)
                {
                    // 把 Id 遍历出来
                    var id = ids[i];
                    // 通过遍历出来的 Id 来找到要删除的数据
                    var model = bs.Get(a => a.Id == id);
                    // 清除外键表
                    model.T_Permissions.Clear();
                    // 删除并判断状态
                    bs.Delete(model);
                }
                return new AjaxResult(ResultState.Success, "批量删除成功！");
            }
        }
```

### 页面

#### 控制器

```
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public ActionResult DeleteBatch(long[] ids)
        {
            return Json(_rolesService.RolesDelete(ids));
        }
```

#### Ajax

```
// 批量删除
            $("#deleteBatch").click(function () {
                // 创建数组用来存储数据
                var ar = [];
                // 获取用户选中的复选框 的value值
                $(":checkbox[name=selectIDs]:checked").each((index, item) => {
                    ar.push($(item).val());
                });

                if (ar.length == 0) {
                    layer.msg("请选择要批量删除的角色！", { icon: 2 })
                } else {
                    layer.confirm('你确定要删除这些项吗？', { icon: 3, title: '提示' }, function (index) {
                        $.ajax({
                            type: "post",
                            url: "/Roles/DeleteBatch",
                            data: {
                                "ids": ar
                            },
                            dataType: "json",
                            success: function (r) {
                                if (r.State == 1) {
                                    layer.msg(r.Message, { icon: 1, time: 1000 }, function () {
                                        // 刷新，关闭当前窗体
                                        location.reload();
                                    })
                                } else {
                                    layer.msg(r.Message, { icon: 2 })
                                }
                            },
                            error: function () {
                                layer.msg("操作异常", { icon: 2 })
                            }
                        })
                        layer.close(index);
                    });
                }
            })
```

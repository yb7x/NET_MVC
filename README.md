# 分层(管理、公共、DTO、IService、服务、Web)

```
管理员:后台管理

常见:公共类

DTO:数据访问,传递数据

IService:接口服务

服务:服务

网页:前台页面

拉尤伊框架
http://layui.org.cn/docs/docs.html
```

# 相关内容（使用到的部分功能解释)

## 控制反转(控制反转，IoC)与 依赖注入(依赖倒置，DI)

```
控制反转指的是将控制权从应用程序代码转移到框架或容器中,
这样框架或容器可以管理对象的生命周期和依赖关系。
它将应用程序从直接管理对象之间的依赖解耦,使得应用程序更容易扩展和测试。
```

```
依赖反转是控制反转的一种实现方式,
它强调要依赖于抽象接口而不是具体实现。
通过使用接口或抽象类来定义依赖关系,
应用程序可以更容易地替换其中的具体实现,
从而达到松耦合的效果。
```

**控制反转是一种思想,而依赖注入是这种思想的实现**

## 讯息摘要 5加盐加密（注册、登录服务使用到)

**代码在普通的层普通助手类 中**



## 前端使用框架

```
文档地址：

valid form:https://www . cn blogs . com/zeran/p/10795375 . html

layUI：http://layui.apixx.net/layer/index.html
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

**至此，登录模块完成 测试账号信息：电话号：15538568732 密码：123456**

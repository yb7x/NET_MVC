# Forms身份验证

## 首先要从登录页面获取到数据然后存储在票据中

### [Authorize] ：过滤器

### FormsAuthenticationTicket：

1. 它存储有关用户的信息，例如用户名、过期日期和任何自定义数据。 
2. 服务器在成功身份验证后创建票据，并使用机器密钥对其进行加密。 
3. 加密的票据通常作为一个Cookie存储在客户端。 
4. 客户端的Cookie在每个请求中与服务器一起发送，允许服务器对用户进行身份验证，而无需重新进行身份验证。 
5. 服务器可以解密票据，提取用户信息，并用于授权用户访问受保护的资源。 
   总的来说， `FormsAuthenticationTicket` 在Forms身份验证过程中起着重要的作用，通过安全地存储和传输用户身份验证信息，实现客户端和服务器之间的身份验证。

### FormsAuthentication：

1. 登录和注销： `FormsAuthentication` 提供了 `SetAuthCookie` 方法，用于在用户成功登录后创建和发送身份验证票据（Authentication Ticket）到客户端。同时，它还提供了 `SignOut` 方法，用于注销用户并删除相关的身份验证票据。 
2. 身份验证检查：通过 `HttpContext.Current.User.Identity.IsAuthenticated` 属性，可以检查当前用户是否已通过身份验证。 
3. 获取当前用户信息：通过 `HttpContext.Current.User.Identity.Name` 属性，可以获取当前已通过身份验证的用户的用户名。 
4. 自定义身份验证票据： `FormsAuthentication` 允许创建自定义的身份验证票据，可以包含额外的用户信息。可以使用 `FormsAuthenticationTicket` 类创建自定义票据，并将其传递给 `SetAuthCookie` 方法。 
5. 身份验证配置：通过Web.config文件中的 `<authentication>` 元素，可以配置 `FormsAuthentication` 的行为，例如指定登录页面、超时时间等。 
   总的来说， `FormsAuthentication` 是一个用于处理Forms身份验证的重要类，它提供了许多方便的方法和属性，用于管理用户身份验证和授权的过程。

## 使用 Forms 身份验证

### 流程

1. 验证表单：**ModelState.IsValid***

2. 验证用户名和密码

3. 验证通过则在客户端保存 Cookie 用来保存用户登录状态

4. 跳转主页

### 实现

#### 首先配置 Web.config (MVC项目中的)

```
        <!--forms验证-->
        <authentication mode="Forms">
            <forms name="LoginName" loginUrl="/House/Login" path="/" defaultUrl="/House/Index"></forms>
        </authentication>
```

name：命名

path：存储身份验证票证的路径

defaultUrl：用户在成功身份验证后将被重定向到的默认页面的URL

#### 写一个加密储存为 票据 的方法

**FormsAuthenticationTicket ：用来储存信息到票据**

**FormsAuthentication ：用来加密**

##### JSON化数据、创建并加密票据，响应在 cookie 中

```
        /// <summary>
        /// 用户数据 序列化 存储在票据 中后响应到 Cookie 中，用于Forms身份验证和授权
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <param name="isRemember">是否长时间验证</param>
        public void SetUserData(AdminLoginDataDTO dto, bool isRemember)
        {
            // 序列化数据，转化为JSON格式
            string LoginData = JsonConvert.SerializeObject(dto);
            // 创建票据，把数据储存在票据中
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(2, "LoginData", DateTime.Now, DateTime.Now.AddDays(2), false, LoginData);
            // 给票据加密
            string ticketEncrypt = FormsAuthentication.Encrypt(ticket);
            // 创建 cookie ，把加密的票据储存 cookie 中
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, ticketEncrypt);
            // 保存 cookie 路径
            cookie.Path = FormsAuthentication.FormsCookiePath;
            // 设置 cookie 是否为长时间验证
            if (isRemember)
            {
                // 设置 cookie 的有效时长
                cookie.Expires = DateTime.Now.AddDays(1);
            }
            // 创建 Http 请求发送 cookie 到客户端
            HttpContext context = HttpContext.Current;
            // 移除现有的 cookie 通过给客户端发送响应，移除现有的
            context.Response.Cookies.Remove(FormsAuthentication.FormsCookieName);
            // 添加新的 cookies 并响应到客户端
            context.Response.Cookies.Add(cookie);
        }
```

#### Global 文件中解密数据

```
        /// <summary>
        /// 配置 forms 身份验证获取信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // 把当前对象转换处理 Http 请求对象
            HttpApplication httpApplication = (HttpApplication)sender;
            // 获取当前 HttpContext 请求
            HttpContext httpContext = httpApplication.Context;
            // 获取当前 cookie 信息
            HttpCookie httpCookie = httpContext.Request.Cookies[FormsAuthentication.FormsCookieName];
            // 判断 cookies 是否存在
            if (httpCookie != null)
            {
                // 不为空则解密 cookie 
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(httpCookie.Value);
                // 判断 UserData 是否有数据
                if (!string.IsNullOrWhiteSpace(ticket.UserData))
                {
                    // 反序列化数据
                    AdminLoginDTO dto = JsonConvert.DeserializeObject<AdminLoginDTO>(ticket.UserData);
                    // 把 用户数据 和 票据 存储在当前用户对象中
                    httpContext.User = new MyFormsPrincipal<AdminLoginDTO>(ticket, dto);
                }
            }
        }
```

##### 解释方法

**MyFormsPrincipal< T >类实现了 现了 IPrincipal 接口，这个接口是当前用户对象的类型，可以存储**

```
namespace YB.Common
{
    /// <summary>
    /// Forms 身份验证需要的，实现了 IPrincipal 接口的类
    /// </summary>
    public class MyFormsPrincipal<T> : IPrincipal where T : class, new()
    {
        /// <summary>
        /// 接口实现的方法
        /// </summary>
        public IIdentity Identity { get; set; }
        public T userData { get; set; }

        public MyFormsPrincipal(FormsAuthenticationTicket tickt, T userData)
        {
            Identity = new FormsIdentity(tickt);
            this.userData = userData;
        }

        public bool IsInRole(string role)
        {
            throw new NotImplementedException();
        }
    }
}
```

测试账号信息：电话号：15538568732 密码：123456

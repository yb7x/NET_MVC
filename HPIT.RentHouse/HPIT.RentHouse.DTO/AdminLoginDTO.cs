using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 登录页面所需的
    /// </summary>
    public class AdminLoginDTO
    {
        [Required(ErrorMessage = "请输入电话号码")]
        public string PhoneNum { get; set; }
        [Required(ErrorMessage = "请输入密码")]
        public string Password { get; set; }
        [Required(ErrorMessage = "请输入验证码")]
        public string VerCode { get; set; }
        public bool IsRemember { get; set; }
    }
}

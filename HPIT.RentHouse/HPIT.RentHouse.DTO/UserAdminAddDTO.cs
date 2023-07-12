using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 需要添加的 字段 信息
    /// </summary>
    public class UserAdminAddDTO
    {
        [Required(ErrorMessage ="手机不能为空")]
        [RegularExpression("^1[3,5,6,7,8,9][0-9]{9}$", ErrorMessage = "电话号码格式不正确！")]
        public string PhoneNum { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Password { get; set; }

        [Required]
        public string Passwords { get; set; }

        [Required]
        [RegularExpression("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$", ErrorMessage = "邮箱格式不正确！")]
        public string Email { get; set; }

        public long? CityId { get; set; }

        // 注意字符串长度
        [Required]
        public long[] RolesId { get; set; }
    }
}

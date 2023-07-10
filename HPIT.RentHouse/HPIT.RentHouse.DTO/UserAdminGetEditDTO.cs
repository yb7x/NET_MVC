using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 修改所需字段
    /// </summary>
    public class UserAdminGetEditDTO
    {
        public long Id { get; set; }

        [Required]
        [RegularExpression("^1[3,5,6,7,8,9][0-9]{9}$", ErrorMessage = "电话号码格式不正确！")]
        public string PhoneNum { get; set; }

        [Required]
        public string Name { get; set; }


        [Required]
        [RegularExpression("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", ErrorMessage = "邮箱格式不正确！")]
        public string Email { get; set; }

        public long? CityId { get; set; }

        [Required]
        public List<UserAdminRolesDTO> RolesId { get; set; }

    }
}

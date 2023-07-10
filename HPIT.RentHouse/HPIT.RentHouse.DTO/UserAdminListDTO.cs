using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 用户管理页面显示所需字段
    /// </summary>
    public class UserAdminListDTO
    {
        public long Id { get; set; }
        public string PhoneNum { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public int LoginErrorTimes { get; set; }
        public string CityName { get; set; }
    }
}

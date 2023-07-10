using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 修改需要的 Roles 对象
    /// </summary>
    public class UserAdminRolesDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }

        public bool IsChecked { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

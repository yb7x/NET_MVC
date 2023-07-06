using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

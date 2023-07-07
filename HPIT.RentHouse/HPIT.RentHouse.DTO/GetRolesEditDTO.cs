using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

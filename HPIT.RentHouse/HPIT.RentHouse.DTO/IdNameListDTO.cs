using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 户型、房屋状态、房屋类型、装修类型
    /// </summary>
    public class IdNameListDTO
    {
        public long Id { get; set; }

        public string TypeName { get; set; }

        public string Name { get; set; }
    }
}

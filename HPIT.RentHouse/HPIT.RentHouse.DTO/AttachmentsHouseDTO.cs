using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 所有的房屋配置
    /// </summary>
    public class AttachmentsHouseDTO
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string IconName { get; set; }

    }
}

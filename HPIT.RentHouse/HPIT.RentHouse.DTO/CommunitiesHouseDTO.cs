using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 添加房源所需要的小区信息
    /// </summary>
    public class CommunitiesHouseDTO
    {
        public long Id { get; set; }


        public string Name { get; set; }


        public long RegionId { get; set; }
    }
}

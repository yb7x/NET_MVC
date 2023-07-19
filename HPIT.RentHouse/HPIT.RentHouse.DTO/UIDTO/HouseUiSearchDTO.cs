using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO.UIDTO
{
    /// <summary>
    /// 房源搜索需要的字段 
    /// </summary>
    public class HouseUiSearchDTO
    {
        /// <summary>
        /// 城市 Id
        /// </summary>
        public long? CityId { set; get; }

        /// <summary>
        /// 关键字
        /// </summary>
        public string keyWord { get; set; }

        /// <summary>
        /// 区域
        /// </summary>
        public long? RegionId { get; set; }

        /// <summary>
        /// 租金
        /// </summary>
        public string MouthRent { get; set; }

        /// <summary>
        /// 开始
        /// </summary>
        public int? StartMouthRent { get; set; }

        /// <summary>
        /// 结束
        /// </summary>
        public int? EndMouthRent { get; set; }

        /// <summary>
        /// 排序
        /// </summary>
        public string OrderBy { get; set; }
    }
}

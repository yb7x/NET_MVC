using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO.UIDTO
{
    /// <summary>
    /// 点击查看房源信息
    /// </summary>
    public class HouseUiLookDTO
    {
        /// <summary>
        /// 主键Id
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// 区域
        /// </summary>
        public string RegionName { get; set; }

        /// <summary>
        /// 小区名
        /// </summary>
        public string CommunityName { get; set; }

        /// <summary>
        /// 地段
        /// </summary>
        public string Address { get; set; }

        /// <summary>
        /// 租金
        /// </summary>
        public int MonthRent { get; set; }

        /// <summary>
        /// 房间类型*
        /// </summary>
        public string RoomTypeName { get; set; }

        /// <summary>
        /// 装修类型*
        /// </summary>
        public string DecorateStatusName { get; set; }

        /// <summary>
        /// 面积
        /// </summary>
        public decimal Area { get; set; }

        /// <summary>
        /// 小区位置
        /// </summary>
        public string LocationName { get; set; }

        /// <summary>
        /// 房屋类型*
        /// </summary>
        public string TypeName { get; set; }

        /// <summary>
        /// 总楼层
        /// </summary>
        public int TotalFloorCount { get; set; }

        /// <summary>
        /// 所在楼层
        /// </summary>
        public int FloorIndex { get; set; }

        /// <summary>
        /// 看房时间
        /// </summary>
        public DateTime LookableDateTime { get; set; }

        /// <summary>
        /// 入住时间
        /// </summary>
        public DateTime CheckInDateTime { get; set; }

        /// <summary>
        /// 朝向
        /// </summary>
        public string Direction { get; set; }


        /// <summary>
        /// 建造年限
        /// </summary>
        public int? CommunityBuiltYear { get; set; }

        /// <summary>
        /// 房屋状态*
        /// </summary>
        public string StatusName { get; set; }

        /// <summary>
        /// 房源描述
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// 附近交通
        /// </summary>
        public string CommunityTraffic { get; set; }

        /// <summary>
        /// 房源图片
        /// </summary>
        public List<HousePicDTO> HousePics { get; set; }

        /// <summary>
        /// 配置设施
        /// </summary>
        public List<AttachmentsHouseDTO> Attachments { get; set; }

        /// <summary>
        /// 相似好房 == 房屋信息表
        /// </summary>
        public List<HouseUiListDTO> OtherHouses { get; set; }

    }
}

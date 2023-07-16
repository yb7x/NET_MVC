using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.DTO
{
    /// <summary>
    /// 修改房源信息功能的
    /// </summary>
    public class HouseEditDTO
    {
        public long Id { get; set; }
        /// <summary>
        /// 区域
        /// </summary>
        public long RegionsId { get; set; }


        /// <summary>
        /// 小区名
        /// </summary>
        public long CommunityId { get; set; }


        /// <summary>
        /// 房型
        /// </summary>
        public long RoomTypeId { get; set; }


        /// <summary>
        /// 地段
        /// </summary>
        public string Address { get; set; }


        /// <summary>
        /// 月租金
        /// </summary>
        public int MonthRent { get; set; }

        /// <summary>
        /// 房屋状态
        /// </summary>
        public long StatusId { get; set; }


        /// <summary>
        /// 面积
        /// </summary>
        public decimal Area { get; set; }

        /// <summary>
        /// 装修状态
        /// </summary>
        public long DecorateStatusId { get; set; }

        /// <summary>
        /// 总楼层数
        /// </summary>
        public int TotalFloorCount { get; set; }

        /// <summary>
        /// 楼层
        /// </summary>
        public int FloorIndex { get; set; }

        /// <summary>
        /// 房屋类别
        /// </summary>
        public long TypeId { get; set; }

        /// <summary>
        /// 朝向
        /// </summary>
        public string Direction { get; set; }

        /// <summary>
        /// 可看房时间
        /// </summary>
        public DateTime LookableDateTime { get; set; }

        /// <summary>
        /// 可入住时间
        /// </summary>
        public DateTime CheckInDateTime { get; set; }

        /// <summary>
        /// 业主姓名
        /// </summary>
        public string OwnerName { get; set; }

        /// <summary>
        /// 业主电话
        /// </summary>
        public string OwnerPhoneNum { get; set; }

        /// <summary>
        /// 房源描述
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// 房屋配置编号
        /// </summary>
        public long[] AttachmentId { get; set; }
    }
}

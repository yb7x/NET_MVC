using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.DTO.UIDTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.IService.IUIService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service.UIService
{
    /// <summary>
    /// Ui 房源信息
    /// </summary>
    public class HouseUiService : IHouseUiService
    {
        #region 依赖注入

        private IIdNameService _idNameService;
        public HouseUiService(IIdNameService idNameService)
        {
            _idNameService = idNameService;
        }

        #endregion

        /// <summary>
        /// 显示具体的房源信息，点击显示
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        public HouseUiLookDTO GetHouseMessage(long houseId)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                BaseService<T_HousePics> pbs = new BaseService<T_HousePics> (db);
                BaseService<T_IdNames> ibs = new BaseService<T_IdNames> (db);
                // 先查询房源信息
                T_Houses house = bs.Get(a => a.Id ==  houseId);
                if (house != null)
                {
                    // 先添加房源信息
                    HouseUiLookDTO dto = new HouseUiLookDTO()
                    {
                        Id = houseId,
                        RegionName = house.T_Communities.T_Regions.Name,
                        CommunityName = house.T_Communities.Name,
                        Address = house.Address,
                        MonthRent = house.MonthRent,
                        Area = house.Area,
                        LocationName = house.T_Communities.Location,
                        TotalFloorCount = house.TotalFloorCount,
                        FloorIndex = house.FloorIndex,
                        LookableDateTime = house.LookableDateTime,
                        CheckInDateTime = house.CheckInDateTime,
                        Direction = house.Direction,
                        CommunityBuiltYear = house.T_Communities.BuiltYear,
                        Description = house.Description,
                        CommunityTraffic = house.T_Communities.Traffic,
                        RoomTypeName = _idNameService.GetName(house.RoomTypeId),
                        DecorateStatusName = _idNameService.GetName(house.DecorateStatusId),
                        TypeName = _idNameService.GetName(house.TypeId),
                        StatusName = _idNameService.GetName(house.StatusId)
                    };
                    // 添加 房源图片
                    dto.HousePics = new List<HousePicDTO>();
                    List<T_HousePics> hdto = pbs.GetList(a => a.HouseId == house.Id).ToList(); // 查询当前房源图片
                    foreach (var item in hdto)
                    {
                        HousePicDTO model = new HousePicDTO()
                        {
                            Id = item.Id,
                            HouseId = item.HouseId,
                            ThumbUrl = item.ThumbUrl,
                            Url = item.Url
                        };
                        dto.HousePics.Add(model);
                    }

                    // 添加 配置设施信息
                    dto.Attachments = new List<AttachmentsHouseDTO>();
                    foreach (var item in house.T_Attachments)
                    {
                        AttachmentsHouseDTO model = new AttachmentsHouseDTO()
                        {
                            Id = item.Id,
                            IconName = item.IconName,
                            Name = item.Name
                        };
                        dto.Attachments.Add(model);
                    }

                    // 添加 房屋信息表 (相似好房)
                    dto.OtherHouses = new List<HouseUiListDTO>();
                    var odto = bs.GetList(a => a.CommunityId == house.CommunityId).Take(3); // 只显示三个数据
                    foreach (var item in odto)
                    {
                        HouseUiListDTO model = new HouseUiListDTO()
                        {
                            ThumbUrl = item.T_HousePics.FirstOrDefault().ThumbUrl,
                            Community = item.T_Communities.Name,
                            MonthRent = item.MonthRent,
                            Area = item.Area,
                            RoomTypeId = item.RoomTypeId
                        };
                        dto.OtherHouses.Add(model);
                    }

                    // 户型
                    foreach (var item in dto.OtherHouses)
                    {
                        item.RoomTypeName = ibs.Get(a => a.Id == item.RoomTypeId).Name;
                    }
                    return dto;
                }
                else
                {
                    return null;
                }
            }
        }

        /// <summary>
        /// 获取房源信息
        /// </summary>
        /// <param name="cityId">城市 Id</param>
        /// <param name="start">跳过的数量</param>
        /// <param name="length"></param>
        /// <param name="KeyWord">搜索内容</param>
        /// <returns></returns>
        public List<HouseUiListDTO> GetHouseUi(long cityId, int start, int length, string KeyWord)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                BaseService<T_IdNames> ibs = new BaseService<T_IdNames>(db);
                // 查询所有数据
                var where = PredicateExtensions.True<T_Houses>();
                // 判断有无参数
                if (!string.IsNullOrWhiteSpace(KeyWord))
                {
                    where = where.And(a => a.T_Communities.Name.Contains(KeyWord) || a.Address.Contains(KeyWord) || a.Description.Contains(KeyWord));
                }
                // 判断页面传递过来的参数，为实现分页面管理
                if (cityId > 0)
                {
                    where = where.And(a => a.T_Communities.T_Regions.T_Cities.Id == cityId); // 城市条件
                }
                // 查询并返回数据
                int count = 0;
                start = (start -1) * length; // 调整为跳过的数量
                List<HouseUiListDTO> model = bs.GetPageList(start, length, ref count, where, a => a.Id, false).Select(a => new HouseUiListDTO()
                {
                    Id = a.Id,
                    RegionsName = a.T_Communities.T_Regions.Name,
                    Community = a.T_Communities.Name,
                    Address = a.Address,
                    MonthRent = a.MonthRent,
                    Area = a.Area,
                    DecorateStatusId = a.DecorateStatusId,
                    RoomTypeId = a.RoomTypeId, // 房屋类型编号
                    ThumbUrl = a.T_HousePics.FirstOrDefault().ThumbUrl
                }).ToList();
                // 查询 DecorationId RoomTypeId
                var IdNameList = ibs.GetList(a => true);
                // 遍历找到数据并赋值
                foreach (var item in model)
                {
                    item.DecorateStatusName = IdNameList.FirstOrDefault(a => a.Id == item.DecorateStatusId).Name;
                    item.RoomTypeName = IdNameList.FirstOrDefault(a => a.Id == item.RoomTypeId).Name;
                }
                return model;
            }
        }
    }
}

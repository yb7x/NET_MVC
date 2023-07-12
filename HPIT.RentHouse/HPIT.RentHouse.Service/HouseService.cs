using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service
{
    /// <summary>
    /// 房屋管理
    /// </summary>
    public class HouseService : IHouseService
    {
        /// <summary>
        /// 所有房屋信息==查询
        /// </summary>
        /// <param name="Community"></param>
        /// <returns></returns>
        public List<HouseListDTO> GetListHouse(int start,int length, ref int count, string Community)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                BaseService<T_IdNames> ibs = new BaseService<T_IdNames>(db);
                // 查询所有数据
                var where = PredicateExtensions.True<T_Houses>();
                // 判断有无参数
                if (!string.IsNullOrWhiteSpace(Community))
                {
                    where = where.And(a => a.T_Communities.Name.Contains(Community));
                }
                // 查询并返回数据
                List<HouseListDTO> model = bs.GetPageList(start, length, ref count, where, a => a.Id, false).Select(a => new HouseListDTO()
                {
                    Id = a.Id,
                    RegionsName = a.T_Communities.T_Regions.Name,
                    Community = a.T_Communities.Name,
                    Address = a.Address,
                    MonthRent = a.MonthRent,
                    Area = a.Area,
                    DecorateStatusId = a.DecorateStatusId,
                    RoomTypeId = a.RoomTypeId
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

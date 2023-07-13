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
        ///  添加房源信息
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public AjaxResult Add(HouseAddDTO dto)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                BaseService<T_Attachments> abs = new BaseService<T_Attachments>(db);
                // 要添加的信息
                T_Houses model = new T_Houses()
                {
                    CommunityId = dto.CommunityId,
                    RoomTypeId = dto.RoomTypeId,
                    Address = dto.Address,
                    MonthRent = dto.MonthRent,
                    StatusId = dto.StatusId,
                    Area = dto.Area,
                    DecorateStatusId = dto.DecorateStatusId,
                    TotalFloorCount = dto.TotalFloorCount,
                    FloorIndex = dto.FloorIndex,
                    TypeId = dto.TypeId,
                    Direction = dto.Direction,
                    LookableDateTime = dto.LookableDateTime,
                    CheckInDateTime = dto.CheckInDateTime,
                    OwnerName = dto.OwnerName,
                    OwnerPhoneNum = dto.OwnerPhoneNum,
                    Description = dto.Description,
                };
                // 复选框数据选中 房屋配置编号 的
                if (bs.Add(model) > 0)
                {
                    for (int i = 0; i < dto.AttachmentId.Length; i++)
                    {
                        long id = dto.AttachmentId[i];
                        T_Attachments ac = abs.Get(a => a.Id == id);
                        if (ac != null)
                        {
                            model.T_Attachments.Add(ac);
                        }
                    }
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败");
                }
            }
        }

        /// <summary>
        /// 删除房源信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public AjaxResult Delete(long id)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                // 先删除有当前这个表的外键关系
                T_Houses model = bs.Get(a => a.Id == id);
                if (model != null)
                {
                    // 清除外键关系
                    model.T_Attachments.Clear();
                    // 判断删除成功
                    if (bs.Delete(model))
                    {
                        return new AjaxResult(ResultState.Success, "删除成功");
                    }
                    else
                    {
                        return new AjaxResult(ResultState.Error, "删除失败！");
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "该房源已删除");
                }
            }
        }

        /// <summary>
        /// 批量删除房源信息
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public AjaxResult DeleteBatch(long[] ids)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses> (db);
                // 循环遍历所有
                for(int i = 0; i < ids.Length; i++)
                {
                    long id = ids[i];
                    T_Houses model = bs.Get(a => a.Id == id);
                    model.T_Attachments.Clear();
                    bs.Delete(model);
                }
                return new AjaxResult(ResultState.Success, "批量删除成功");
            }
        }

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

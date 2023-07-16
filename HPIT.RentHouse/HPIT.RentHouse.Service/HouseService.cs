using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.IService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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
                    CreateDateTime = DateTime.Now
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
                    db.SaveChanges(); // 保存操作
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
        /// 修改功能
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public AjaxResult Edit(HouseEditDTO dto)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                BaseService<T_Attachments> abs = new BaseService<T_Attachments> (db);
                // 查询修改对象
                T_Houses model = bs.Get(a => a.Id == dto.Id);
                model.CommunityId = dto.CommunityId;
                model.RoomTypeId = dto.RoomTypeId;
                model.Address = dto.Address;
                model.MonthRent = dto.MonthRent;
                model.StatusId = dto.StatusId;
                model.Area = dto.Area;
                model.DecorateStatusId = dto.DecorateStatusId;
                model.TotalFloorCount = dto.TotalFloorCount;
                model.FloorIndex = dto.FloorIndex;
                model.TypeId = dto.TypeId;
                model.Direction = dto.Direction;
                model.LookableDateTime = dto.LookableDateTime;
                model.CheckInDateTime = dto.CheckInDateTime;
                model.OwnerName = dto.OwnerName;
                model.OwnerPhoneNum = dto.OwnerPhoneNum;
                model.Description = dto.Description;
                // 添加 房屋配置 信息，先判断修改状态
                if (bs.Update(model))
                {
                    // 先清除所有的数据
                    model.T_Attachments.Clear();
                    // 循环遍历 AttachmentId 并添加到 T_Attachments 中
                    for (int i = 0; i < dto.AttachmentId.Length; i++)
                    {
                        var attachmentId = dto.AttachmentId[i];
                        T_Attachments attDto = abs.Get(a => a.Id ==  attachmentId);
                        model.T_Attachments.Add(attDto);
                    }
                    db.SaveChanges();
                    return new AjaxResult(ResultState.Success, "更新成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "已经修改好啦");
                }

            }
        }

        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public HouseGetEditDTO GetEdit(long id)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Houses> bs = new BaseService<T_Houses>(db);
                BaseService<T_Attachments> abs = new BaseService<T_Attachments> (db);
                // 先查询信息，并添加到所需类型
                var model = bs.Get(a => a.Id == id);
                HouseGetEditDTO dto = new HouseGetEditDTO()
                {
                    Id = id,
                    RegionsId = model.T_Communities.RegionId,
                    CommunityId = model.CommunityId,
                    RoomTypeId = model.RoomTypeId,
                    Address = model.Address,
                    MonthRent = model.MonthRent,
                    StatusId = model.StatusId,
                    Area = model.Area,
                    DecorateStatusId = model.DecorateStatusId,
                    TotalFloorCount = model.TotalFloorCount,
                    FloorIndex = model.FloorIndex,
                    TypeId = model.TypeId,
                    Direction = model.Direction,
                    LookableDateTime = model.LookableDateTime,
                    CheckInDateTime = model.CheckInDateTime,
                    OwnerName = model.OwnerName,
                    OwnerPhoneNum = model.OwnerPhoneNum,
                    Description = model.Description
                };
                // 添加房屋配置信息，先给字段创建空间
                dto.AttachmentId = new List<AttachmentsHouseIsCheckedDTO>();
                // 查询所有的房屋配置
                List<T_Attachments> list = abs.GetList(a => true).ToList();
                // 查询选中的房屋配置
                var attachments = model.T_Attachments;
                // 循环判断是否选中
                foreach (var item in list)
                {
                    // 创建接收类型
                    AttachmentsHouseIsCheckedDTO att = new AttachmentsHouseIsCheckedDTO()
                    {
                        Id = item.Id,
                        Name = item.Name,
                        IsChecked = attachments.Any(a => a.Id == item.Id)
                    };
                    dto.AttachmentId.Add(att);
                }
                return dto;
            }
        }

        /// <summary>
        /// 所有房屋信息==查询
        /// </summary>
        /// <param name="Community"></param>
        /// <returns></returns>
        public List<HouseListDTO> GetListHouse(long TypeId, int start,int length, ref int count, string Community)
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
                // 判断页面传递过来的参数，为实现分页面管理
                if (TypeId > 0)
                {
                    where = where.And(a => a.TypeId == TypeId);
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

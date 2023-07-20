using HPIT.RentHouse.Common;
using HPIT.RentHouse.DTO;
using HPIT.RentHouse.DTO.UIDTO;
using HPIT.RentHouse.IService.IUIService;
using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service.UIService
{
    /// <summary>
    /// 预约看房实现
    /// </summary>
    public class HouseUiAppointmentsService : IHouseUiAppointmentsService
    {
        /// <summary>
        /// 添加 看房预约信息
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        public AjaxResult Add(HouseUiAppointmentsAddDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_HouseAppointments> bs = new BaseService<T_HouseAppointments>(db);
                T_HouseAppointments hdto = new T_HouseAppointments()
                {
                    CreateDateTime = DateTime.Now,
                    IsDeleted = false,
                    Status = "未处理",
                    Name = dto.Name,
                    PhoneNum = dto.PhoneNum,
                    HouseId = dto.HouseId,
                    VisitDate = dto.VisitDate
                };
                if (bs.Add(hdto) > 0)
                {
                    return new AjaxResult(ResultState.Success, "预约看房成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "预约看房失败");
                }
                
            }
        }

        /// <summary>
        /// 抢单功能
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public AjaxResult Follow(long id, long adminUserId)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_HouseAppointments> bs = new BaseService<T_HouseAppointments>(db);
                var model = bs.Get(a => a.Id == id);
                if (model != null)
                {
                    // 判断订单是否被接单是自己接的单吗
                    if (model.FollowAdminUserId != null)
                    {
                        // 已经接单了,判断是不是自己接的单
                        if (model.FollowAdminUserId == adminUserId)
                        {
                            return new AjaxResult(ResultState.Error, "你已经接单啦，无需重复操作哈");
                        }
                        else
                        {
                            return new AjaxResult(ResultState.Error, "已经有人接单啦，换一个哈");
                        }
                    }
                    else
                    {
                        try
                        {
                            // 没有接单人
                            model.FollowAdminUserId = adminUserId;
                            model.FollowDateTime = DateTime.Now;
                            model.Status = "已处理";
                            db.SaveChanges();
                            return new AjaxResult(ResultState.Success, "恭喜接单成功！尽快联系客户哦");
                        }
                        catch (DbUpdateException)
                        {
                            return new AjaxResult(ResultState.Error, "接单失败，请稍后刷新");
                        }
                        
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "该订单不存在");
                }
            }
        }

        /// <summary>
        /// 预约房源信息列表 
        /// </summary>
        /// <returns></returns>
        public List<HouseAppointmentsListDTO> HouseAppointmentsList(int start, int length, ref int count)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_HouseAppointments> bs = new BaseService<T_HouseAppointments> (db);
                var model = bs.GetPageList(start, length, ref count, a => true, a => a.Status, false).Select(a => new HouseAppointmentsListDTO()
                {
                    Id = a.Id,
                    Name = a.Name,
                    PhoneNum = a.PhoneNum,
                    CreateDateTime = a.CreateDateTime,
                    VisitDate = a.VisitDate,
                    CommunityName = a.T_Houses.T_Communities.Name,
                    HouseAddress = a.T_Houses.Address,
                    Status = a.Status,
                    FollowAdminUserName = a.T_AdminUsers.Name
                }).ToList();
                return model;
            }
        }
    }
}

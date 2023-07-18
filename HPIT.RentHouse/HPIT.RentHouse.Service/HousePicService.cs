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
    /// 房源图片
    /// </summary>
    public class HousePicService : IHousePicService
    {
        /// <summary>
        /// 添加房源图片
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        public AjaxResult AddHousePic(HousePicDTO dto)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_HousePics> bs = new BaseService<T_HousePics>(db);
                T_HousePics model = new T_HousePics()
                {
                    CreateDateTime = DateTime.Now,
                    HouseId = dto.HouseId,
                    IsDeleted = false,
                    ThumbUrl = dto.ThumbUrl,
                    Url = dto.Url
                };
                // 添加
                if (bs.Add(model) > 0)
                {
                    return new AjaxResult(ResultState.Success, "图片上传成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "图片上传失败");
                }
            }
        }

        /// <summary>
        /// 图片批量删除=
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        public AjaxResult DeleteBatch(long[] houseId)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_HousePics> bs = new BaseService<T_HousePics> (db);
                for (int i = 0; i < houseId.Length; i++)
                {
                    // 依次删除
                    long id = houseId[i];
                    T_HousePics dto = bs.Get(a => a.Id == id);
                    bs.Delete(dto);
                }
                db.SaveChanges();
                return new AjaxResult(ResultState.Success, "批量删除成功");
            }
        }

        /// <summary>
        /// =查看图片
        /// </summary>
        /// <param name="houseId"></param>
        /// <returns></returns>
        public List<HousePicDTO> GetHousePicList(long houseId)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_HousePics> bs = new BaseService<T_HousePics> (db);
                return bs.GetList(a => a.HouseId == houseId).Select(a => new HousePicDTO()
                {
                    HouseId = a.HouseId,
                    ThumbUrl = a.ThumbUrl,
                    Url = a.Url,
                    Id = a.Id
                }).ToList(); // 查当前房屋图片信息
            }
        }
    }
}

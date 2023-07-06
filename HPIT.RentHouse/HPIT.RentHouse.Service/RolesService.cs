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
    public class RolesService : IRolesService
    {
        /// <summary>
        /// 查询，显示列表信息
        /// </summary>
        /// <param name="Name"></param>
        /// <returns></returns>
        public List<RolesListDTO> GetRolesList(string Name)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Roles> bs = new BaseService<T_Roles> (db);
                // 参数为空则查询所有的数据
                var model = PredicateExtensions.True<T_Roles> ();
                // 判断如果参数不为空
                if(!string.IsNullOrWhiteSpace(Name))
                {
                    model = model.And(a => a.Name.Contains(Name));
                }
                // 返回DTO数据
                return bs.GetOrderBy(model, a => a.Id, false).Select(a => new  RolesListDTO()
                {
                    Name = a.Name,
                    Id = a.Id
                }).ToList();
            }
        }

        /// <summary>
        /// 添加方法
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        public AjaxResult RolesAdd(RolesAddDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建两个所需要的表对象
                BaseService<T_Roles> bs = new BaseService<T_Roles> (db);
                BaseService<T_Permissions> pbs = new BaseService<T_Permissions> (db);
                // 角色表添加字段，需要转换类型
                T_Roles rs = new T_Roles()
                {
                    IsDeleted = false,
                    Name = dto.Name,
                    CreateDateTime = DateTime.Now,
                };
                // 判断是否添加上角色信息
                if (bs.Add(rs) > 0)
                {
                    // 成功则继续为这个角色添加权限信息
                    for (int i = 0; i < dto.PermissionsID.Length; i++)
                    {
                        // 先存储权限编号
                        var b = dto.PermissionsID[i];
                        // 根据编号查询权限信息
                        var s = pbs.Get(a => a.Id == b);
                        // 添加权限
                        rs.T_Permissions.Add(s);
                    }
                    db.SaveChanges();
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败");
                }
            }
        }
    }
}

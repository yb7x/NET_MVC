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

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult RolesDelete(long id)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建数据库连接
                BaseService<T_Roles> bs = new BaseService<T_Roles>(db);
                // 查询要删除的数据
                T_Roles model = bs.Get(a => a.Id == id);
                // 判断 ,如果存在则清除对应表数据
                if (model != null)
                {
                    // 清除 对应的角色权限关系表中的数据
                    model.T_Permissions.Clear();
                    // 删除，并判断状态
                    if (bs.Delete(model))
                    {
                        return new AjaxResult(ResultState.Success, "角色删除成功！");
                    }
                    else
                    {
                        return new AjaxResult(ResultState.Error, "删除失败！");
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "该角色已删除！");
                }
            }
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult RolesDelete(long[] ids)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建操作数据
                BaseService<T_Roles> bs = new BaseService<T_Roles>(db);
                // 首先循环遍历 删除 外键表（角色权限关系表）
                for (int i = 0; i < ids.Length; i++)
                {
                    // 把 Id 遍历出来
                    var id = ids[i];
                    // 通过遍历出来的 Id 来找到要删除的数据
                    var model = bs.Get(a => a.Id == id);
                    // 清除外键表
                    model.T_Permissions.Clear();
                    // 删除并判断状态
                    bs.Delete(model);
                }
                return new AjaxResult(ResultState.Success, "批量删除成功！");
            }
        }

        /// <summary>
        /// 修改功能
        /// </summary>
        /// <param name="dto"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult RolesEdit(RolesEditDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建要修改表的实例
                BaseService<T_Roles> bs = new BaseService<T_Roles> (db);
                BaseService<T_Permissions> pbs = new BaseService<T_Permissions>(db);
                // 查询外键，删除它 Clear():清除
                var model = bs.Get(a => a.Id == dto.Id) ;
                // 清除外键（清除当前所拥有的的权限）
                model.T_Permissions.Clear();
                // 修改这一项
                model.Name = dto.Name;
                // 先修改这个关系表
                if (bs.Update(model))
                {
                    // 向角色权限关系表添加 权限信息
                    for (int i = 0; i < dto.PermissionsID.Length; i++)
                    {
                        // 通过编号查询到权限信息
                        var id = dto.PermissionsID[i];
                        // 添加到表中
                        model.T_Permissions.Add(pbs.Get(a => a.Id == id));
                    }
                    db.SaveChanges() ;
                    return new AjaxResult(ResultState.Success, "修改成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "修改失败！");
                }
            }
        }

        /// <summary>
        /// 修改前查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public GetRolesEditDTO RolesGetEdit(long id)
        {
            // 创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建要操作的表的实例
                BaseService<T_Roles> bs = new BaseService<T_Roles>(db);
                BaseService<T_Permissions> pbs = new BaseService<T_Permissions>(db);
                // 获取要修改的角色信息
                var model = bs.Get(a => a.Id == id);
                // 创建返回值类型保存数据
                GetRolesEditDTO dto = new GetRolesEditDTO()
                {
                    Id = model.Id,
                    Name = model.Name
                };
                // 获取所有权限信息
                List<T_Permissions> permissionsList = pbs.GetList(b => true).ToList();
                // 获取 roles 表中所有权限信息,T_Permissions:代表外键
                var rolesPermissions = model.T_Permissions;
                // 为 GetRolesEditDTO 中的 PermissionsId 字段赋值，先初始化
                dto.PermissionsId = new List<GetRolesEditPermissionDTO>();
                // 循环遍历出所有的权限数据
                foreach (var item in permissionsList)
                {
                    GetRolesEditPermissionDTO getPermission = new GetRolesEditPermissionDTO()
                    {
                        Description = item.Description,
                        Id = item.Id,
                        Name = item.Name,
                        // 如果当前的ID 与 权限 ID匹配那么说明被选中
                        isChecked = rolesPermissions.Any(x => x.Id == item.Id)
                    };
                    dto.PermissionsId.Add(getPermission);
                }
                return dto;
            }
        }
    }
}

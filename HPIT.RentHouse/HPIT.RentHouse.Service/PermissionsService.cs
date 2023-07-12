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
    public class PermissionsService : IPermissionsService
    {
        /// <summary>
        /// 添加权限信息
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns>Ajax true:1 false:0</returns>
        /// <exception cref="NotImplementedException"></exception>
        public AjaxResult AddPermissions(PermissionsDTO dto)
        {
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 创建添加对象
                T_Permissions model = new T_Permissions()
                {
                    Description = dto.Description,
                    CreateDateTime = DateTime.Now,
                    IsDeleted = false,
                    Name = dto.Name
                };
                if (bs.Add(model) > 0)
                {
                    return new AjaxResult(ResultState.Success, "添加成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "添加失败");
                }
            }
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="b">数组</param>
        /// <returns></returns>
        public AjaxResult DeleteBatchPermissions(long[] b)
        {
            // 创还能上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 创建数据库操作对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions> (db);
                // 循环遍历数组，依次删除
                for (int i = 0; i < b.Length; i++)
                {
                    var id = b[i];
                    bs.Delete(bs.Get(a => a.Id ==id));
                }
                return new AjaxResult(ResultState.Success, "批量删除成功");
            }
        }

        /// <summary>
        /// 删除权限信息
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns></returns>
        public AjaxResult DeletePermissions(long id)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                // 创建查询对象，根据条件查询数据
                BaseService<T_Permissions> bs = new BaseService<T_Permissions> (db);
                T_Permissions model = bs.Get(a =>a.Id == id);
                // 判断是否存在
                if (model != null)
                {
                    // 判断删除是否成功
                    if (bs.Delete(model))
                    {
                        return new AjaxResult(ResultState.Success, "删除成功");
                    }
                    else
                    {
                        return new AjaxResult(ResultState.Success, "删除失败");
                    }
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "已删除该权限");
                }
            }
        }

        /// <summary>
        /// 查询要修改权限信息
        /// </summary>
        /// <param name="id">编号</param>
        /// <returns>PermissionsDTO 类型</returns>
        public PermissionsDTO EditGetPermissions(long id)
        {
            // 1、创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 2、创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 执行操作，投射
                return bs.GetList(a => a.Id == id).Select(a => new PermissionsDTO()
                {
                    Description = a.Description,
                    Id = a.Id,
                    Name = a.Name
                }).FirstOrDefault();
            }
        }

        /// <summary>
        /// 查询后修改权限信息
        /// </summary>
        /// <param name="dto">实体对象</param>
        /// <returns></returns>
        public AjaxResult EditPermissions(PermissionsDTO dto)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_Permissions> bs = new BaseService<T_Permissions> (db);
                T_Permissions model = bs.Get(a => a.Id == dto.Id);
                model.Name = dto.Name;
                model.Description = dto.Description;
                // 调用修改方法
                if (bs.Update(model))
                {
                    return new AjaxResult(ResultState.Success, "修改成功");
                }
                else
                {
                    return new AjaxResult(ResultState.Error, "修改失败");
                }
            }
        }

        /// <summary>
        /// 查询所有权限信息，若为空条件，则查询所有的，并且降序排列
        /// </summary>
        /// <param name="Description">查询条件</param>
        /// <returns></returns>
        public List<PermissionsDTO> GetPermissionsList(string Description)
        {
            // 1、创建上下文对象
            using (RentHouseEntity db = new RentHouseEntity())
            {
                // 2、创建查询对象
                BaseService<T_Permissions> bs = new BaseService<T_Permissions>(db);
                // 3、查询(使用 Common 中的 ParameterExpression 类中的 Lambda 扩展方法)
                var lambda = PredicateExtensions.True<T_Permissions>(); // 返回所有数据
                if (!string.IsNullOrWhiteSpace(Description))
                {
                    lambda = lambda.And(a => a.Description.Contains(Description));
                }
                return bs.GetOrderBy(lambda, a => a.Id, false).Select(a => new PermissionsDTO()
                {
                    Id = a.Id,
                    Description = a.Description,
                    Name = a.Name
                }).ToList();
            }
        }

        /// <summary>
        /// 根据 Id 查询当前权限信息
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public List<PermissionsDTO> GetPermissionsList(long userId)
        {
            using(RentHouseEntity db = new RentHouseEntity())
            {
                BaseService<T_AdminUsers> bs = new BaseService<T_AdminUsers> (db);
                // 查询当前的用户信息
                var user = bs.Get(a => a.Id ==  userId);
                // 暂时让一个用户拥有一个角色（可扩展多角色）找到第一个角色
                var role = user.T_Roles.FirstOrDefault();
                // 获取当前角色所拥有的权限
                var permisssions = role.T_Permissions;
                // 循环遍历并添加到 List<PermissionsDTO> 中返回结果
                List<PermissionsDTO> dto = new List<PermissionsDTO>();
                foreach (var permission in permisssions)
                {
                    var permissionDTO = new PermissionsDTO()
                    {
                        Id = permission.Id,
                        Description = permission.Description,
                        Name = permission.Name
                    };
                    dto.Add(permissionDTO);
                }
                return dto;
            }
        }
    }
}

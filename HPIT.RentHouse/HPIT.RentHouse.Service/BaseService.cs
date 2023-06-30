using HPIT.RentHouse.Service.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace HPIT.RentHouse.Service
{
    /// <summary>
    /// 只能传入继承了BaseEntity的类
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class BaseService<T> where T : BaseEntity
    {
        private RentHouseEntity db;
        /// <summary>
        /// 构造器，调用这个类时传入上下文对象
        /// </summary>
        /// <param name="DB"></param>
        public BaseService(RentHouseEntity DB)
        {
            this.db = DB;
        }

        #region Add

        /// <summary>
        /// 添加功能
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public long Add(T entity)
        {
            // ef内置方法实现添加
            db.Entry<T>(entity).State = EntityState.Added;
            db.SaveChanges(); // 永久提交数据
            return entity.Id; // 返回编号，如果添加成功编号大于0，否则为0
        }

        #endregion

        #region Delete(修改IsDelete字段)

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="entity">实体对象</param>
        /// <returns>true flase</returns>
        public bool Delete(T entity)
        {
            // ef内置方法先查询，后开启修改状态，最后保存
            db.Set<T>().Attach(entity); // 查询
            db.Entry<T>(entity).State = EntityState.Modified; // 修改状态
            entity.IsDeleted = true;
            return db.SaveChanges() > 0;
        }

        #endregion

        #region Update

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entity">实体对象</param>
        /// <returns></returns>
        public bool Update(T entity)
        {
            // ef内置方法先查询，后开启修改状态，最后保存
            db.Set<T>().Attach(entity); // 查询
            db.Entry<T>(entity).State = EntityState.Modified; // 修改状态
            return db.SaveChanges() > 0;
        }

        #endregion

        #region 查询


        #region 查询 集合

        /// <summary>
        /// 查询集合
        /// </summary>
        /// <param name="WhereLambda">Lambda 表达式查询条件，返回true false</param>
        /// <returns>可查询的泛型集合</returns>
        public IQueryable<T> GetList(Expression<Func<T, bool>> whereLambda)
        {
            return db.Set<T>().Where(whereLambda).Where(a => a.IsDeleted == false);
        }

        #endregion

        #region 查询 实体

        /// <summary>
        /// 查询实体
        /// </summary>
        /// <param name="WhereLambda">Lambda 表达式查询条件</param>
        /// <returns>一个实体对象</returns>
        public T Get(Expression<Func<T, bool>> whereLambda)
        {
            return GetList(whereLambda).FirstOrDefault();
        }

        #endregion

        #region 查询 排序

        /// <summary>
        /// 查询 排序
        /// </summary>
        /// <typeparam name="Tkey"></typeparam>
        /// <param name="whereLambda">Lambda 表达式查询条件</param>
        /// <param name="orderBy">排序字段</param>
        /// <param name="isAsc">排序方式 true：升序 false：降序</param>
        /// <returns></returns>
        public IQueryable<T> GetOrderBy<Tkey>(Expression<Func<T, bool>> whereLambda, Expression<Func<T, Tkey>> orderBy, bool isAsc)
        {
            // 升序：asc   降序：desc
            if (isAsc)
            {
                return GetList(whereLambda).OrderBy(orderBy); // 升序
            }
            else
            {
                return GetList(whereLambda).OrderByDescending(orderBy); // 降序
            }
        }

        #endregion

        #region 查询 分页

        /// <summary>
        /// 分页
        /// </summary>
        /// <typeparam name="Tkey"></typeparam>
        /// <param name="PageIndex">索引 从0开始</param>
        /// <param name="PageSize">每页数据数量</param>
        /// <param name="rowCount">总行数，返回所有数据行数</param>
        /// <param name="whereLambda">Lambda 表达式条件</param>
        /// <param name="orderBy">排序条件</param>
        /// <param name="isAsc">是否升序排列 true 升序， false 降序</param>
        /// <returns></returns>
        public IQueryable<T> GetPageList<Tkey>(int PageIndex, int PageSize, ref int rowCount, Expression<Func<T, bool>> whereLambda, Expression<Func<T, Tkey>> orderBy, bool isAsc)
        {
            rowCount = GetList(whereLambda).Count() ;
            if (isAsc)
            {
                return GetList(whereLambda).Skip(PageIndex * PageSize).Take(PageSize).OrderBy(orderBy); // 升序分页
            }
            else
            {
                return GetList(whereLambda).Skip(PageIndex * PageSize).Take(PageSize).OrderByDescending(orderBy); // 降序分页
            }
        }

        #endregion


        #endregion
    }
}

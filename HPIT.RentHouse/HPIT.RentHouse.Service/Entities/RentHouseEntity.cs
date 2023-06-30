using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace HPIT.RentHouse.Service.Entities
{
    public partial class RentHouseEntity : DbContext
    {
        public RentHouseEntity()
            : base("name=RentHouseEntity")
        {
        }

        public virtual DbSet<T_AdminLogs> T_AdminLogs { get; set; }
        public virtual DbSet<T_AdminUsers> T_AdminUsers { get; set; }
        public virtual DbSet<T_Attachments> T_Attachments { get; set; }
        public virtual DbSet<T_Cities> T_Cities { get; set; }
        public virtual DbSet<T_Communities> T_Communities { get; set; }
        public virtual DbSet<T_HouseAppointments> T_HouseAppointments { get; set; }
        public virtual DbSet<T_HousePics> T_HousePics { get; set; }
        public virtual DbSet<T_Houses> T_Houses { get; set; }
        public virtual DbSet<T_IdNames> T_IdNames { get; set; }
        public virtual DbSet<T_Permissions> T_Permissions { get; set; }
        public virtual DbSet<T_Regions> T_Regions { get; set; }
        public virtual DbSet<T_Roles> T_Roles { get; set; }
        public virtual DbSet<T_Settings> T_Settings { get; set; }
        public virtual DbSet<T_Users> T_Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<T_AdminUsers>()
                .Property(e => e.PhoneNum)
                .IsUnicode(false);

            modelBuilder.Entity<T_AdminUsers>()
                .Property(e => e.PasswordHash)
                .IsUnicode(false);

            modelBuilder.Entity<T_AdminUsers>()
                .Property(e => e.PasswordSalt)
                .IsUnicode(false);

            modelBuilder.Entity<T_AdminUsers>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<T_AdminUsers>()
                .HasMany(e => e.T_AdminLogs)
                .WithRequired(e => e.T_AdminUsers)
                .HasForeignKey(e => e.AdminUserId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_AdminUsers>()
                .HasMany(e => e.T_HouseAppointments)
                .WithOptional(e => e.T_AdminUsers)
                .HasForeignKey(e => e.FollowAdminUserId);

            modelBuilder.Entity<T_AdminUsers>()
                .HasMany(e => e.T_Roles)
                .WithMany(e => e.T_AdminUsers)
                .Map(m => m.ToTable("T_AdminUserRoles").MapLeftKey("AdminUserId").MapRightKey("RoleId"));

            modelBuilder.Entity<T_Attachments>()
                .Property(e => e.IconName)
                .IsUnicode(false);

            modelBuilder.Entity<T_Attachments>()
                .HasMany(e => e.T_Houses)
                .WithMany(e => e.T_Attachments)
                .Map(m => m.ToTable("T_HouseAttachments").MapLeftKey("AttachmentId").MapRightKey("HouseId"));

            modelBuilder.Entity<T_Cities>()
                .HasMany(e => e.T_AdminUsers)
                .WithOptional(e => e.T_Cities)
                .HasForeignKey(e => e.CityId);

            modelBuilder.Entity<T_Cities>()
                .HasMany(e => e.T_Regions)
                .WithRequired(e => e.T_Cities)
                .HasForeignKey(e => e.CityId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_Cities>()
                .HasMany(e => e.T_Users)
                .WithOptional(e => e.T_Cities)
                .HasForeignKey(e => e.CityId);

            modelBuilder.Entity<T_Communities>()
                .HasMany(e => e.T_Houses)
                .WithRequired(e => e.T_Communities)
                .HasForeignKey(e => e.CommunityId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_HouseAppointments>()
                .Property(e => e.PhoneNum)
                .IsUnicode(false);

            modelBuilder.Entity<T_HouseAppointments>()
                .Property(e => e.RowVersion)
                .IsFixedLength();

            modelBuilder.Entity<T_Houses>()
                .Property(e => e.OwnerPhoneNum)
                .IsUnicode(false);

            modelBuilder.Entity<T_Houses>()
                .HasMany(e => e.T_HouseAppointments)
                .WithRequired(e => e.T_Houses)
                .HasForeignKey(e => e.HouseId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_Houses>()
                .HasMany(e => e.T_HousePics)
                .WithRequired(e => e.T_Houses)
                .HasForeignKey(e => e.HouseId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_IdNames>()
                .HasMany(e => e.T_Houses)
                .WithRequired(e => e.T_IdNames)
                .HasForeignKey(e => e.DecorateStatusId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_IdNames>()
                .HasMany(e => e.T_Houses1)
                .WithRequired(e => e.T_IdNames1)
                .HasForeignKey(e => e.RoomTypeId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_IdNames>()
                .HasMany(e => e.T_Houses2)
                .WithRequired(e => e.T_IdNames2)
                .HasForeignKey(e => e.StatusId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_IdNames>()
                .HasMany(e => e.T_Houses3)
                .WithRequired(e => e.T_IdNames3)
                .HasForeignKey(e => e.TypeId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_Permissions>()
                .HasMany(e => e.T_Roles)
                .WithMany(e => e.T_Permissions)
                .Map(m => m.ToTable("T_RolePermissions").MapLeftKey("PermissionId").MapRightKey("RoleId"));

            modelBuilder.Entity<T_Regions>()
                .HasMany(e => e.T_Communities)
                .WithRequired(e => e.T_Regions)
                .HasForeignKey(e => e.RegionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<T_Users>()
                .Property(e => e.PhoneNum)
                .IsUnicode(false);

            modelBuilder.Entity<T_Users>()
                .HasMany(e => e.T_HouseAppointments)
                .WithOptional(e => e.T_Users)
                .HasForeignKey(e => e.UserId);
        }
    }
}

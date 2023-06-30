namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_HouseAppointments : BaseEntity
    {

        public long? UserId { get; set; }

        [Required]
        [StringLength(20)]
        public string Name { get; set; }

        [Required]
        [StringLength(20)]
        public string PhoneNum { get; set; }

        public DateTime VisitDate { get; set; }

        public long HouseId { get; set; }

        [Required]
        [StringLength(20)]
        public string Status { get; set; }

        public long? FollowAdminUserId { get; set; }

        public DateTime? FollowDateTime { get; set; }

        [Column(TypeName = "timestamp")]
        [MaxLength(8)]
        [Timestamp]
        public byte[] RowVersion { get; set; }


        public virtual T_AdminUsers T_AdminUsers { get; set; }

        public virtual T_Houses T_Houses { get; set; }

        public virtual T_Users T_Users { get; set; }
    }
}

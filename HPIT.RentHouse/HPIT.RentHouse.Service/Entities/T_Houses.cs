namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_Houses : BaseEntity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_Houses()
        {
            T_HouseAppointments = new HashSet<T_HouseAppointments>();
            T_HousePics = new HashSet<T_HousePics>();
            T_Attachments = new HashSet<T_Attachments>();
        }


        public long CommunityId { get; set; }

        public long RoomTypeId { get; set; }

        [Required]
        [StringLength(128)]
        public string Address { get; set; }

        public int MonthRent { get; set; }

        public long StatusId { get; set; }

        public decimal Area { get; set; }

        public long DecorateStatusId { get; set; }

        public int TotalFloorCount { get; set; }

        public int FloorIndex { get; set; }

        public long TypeId { get; set; }

        [Required]
        [StringLength(20)]
        public string Direction { get; set; }

        public DateTime LookableDateTime { get; set; }

        public DateTime CheckInDateTime { get; set; }

        [Required]
        [StringLength(20)]
        public string OwnerName { get; set; }

        [Required]
        [StringLength(20)]
        public string OwnerPhoneNum { get; set; }

        public string Description { get; set; }


        public virtual T_Communities T_Communities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_HouseAppointments> T_HouseAppointments { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_HousePics> T_HousePics { get; set; }

        public virtual T_IdNames T_IdNames { get; set; }

        public virtual T_IdNames T_IdNames1 { get; set; }

        public virtual T_IdNames T_IdNames2 { get; set; }

        public virtual T_IdNames T_IdNames3 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_Attachments> T_Attachments { get; set; }
    }
}

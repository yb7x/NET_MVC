namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_AdminUsers : BaseEntity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_AdminUsers()
        {
            T_AdminLogs = new HashSet<T_AdminLogs>();
            T_HouseAppointments = new HashSet<T_HouseAppointments>();
            T_Roles = new HashSet<T_Roles>();
        }


        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        [Required]
        [StringLength(20)]
        public string PhoneNum { get; set; }

        [Required]
        [StringLength(100)]
        public string PasswordHash { get; set; }

        [Required]
        [StringLength(20)]
        public string PasswordSalt { get; set; }

        [Required]
        [StringLength(30)]
        public string Email { get; set; }

        public long? CityId { get; set; }

        public int LoginErrorTimes { get; set; }

        public DateTime? LastLoginErrorDateTime { get; set; }



        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_AdminLogs> T_AdminLogs { get; set; }

        public virtual T_Cities T_Cities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_HouseAppointments> T_HouseAppointments { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_Roles> T_Roles { get; set; }
    }
}

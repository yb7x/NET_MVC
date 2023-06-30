namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_Users : BaseEntity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_Users()
        {
            T_HouseAppointments = new HashSet<T_HouseAppointments>();
        }


        [Required]
        [StringLength(20)]
        public string PhoneNum { get; set; }

        [Required]
        [StringLength(100)]
        public string PasswordHash { get; set; }

        [Required]
        [StringLength(20)]
        public string PasswordSalt { get; set; }

        public int LoginErrorTimes { get; set; }

        public DateTime? LastLoginErrorDateTime { get; set; }

        public long? CityId { get; set; }


        public virtual T_Cities T_Cities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_HouseAppointments> T_HouseAppointments { get; set; }
    }
}

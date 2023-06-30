namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_Regions : BaseEntity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_Regions()
        {
            T_Communities = new HashSet<T_Communities>();
        }


        [Required]
        [StringLength(50)]
        public string Name { get; set; }

        public long CityId { get; set; }

        public virtual T_Cities T_Cities { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_Communities> T_Communities { get; set; }
    }
}

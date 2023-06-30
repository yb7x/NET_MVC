namespace HPIT.RentHouse.Service.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class T_Communities : BaseEntity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public T_Communities()
        {
            T_Houses = new HashSet<T_Houses>();
        }


        [Required]
        [StringLength(20)]
        public string Name { get; set; }

        public long RegionId { get; set; }

        [Required]
        [StringLength(1024)]
        public string Location { get; set; }

        public string Traffic { get; set; }

        public int? BuiltYear { get; set; }


        public virtual T_Regions T_Regions { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<T_Houses> T_Houses { get; set; }
    }
}

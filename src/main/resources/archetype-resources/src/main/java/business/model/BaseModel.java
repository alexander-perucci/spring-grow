#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@MappedSuperclass
public class BaseModel {
   
   @Temporal(TemporalType.TIMESTAMP)
   @Column(name = "last_update", updatable = false, columnDefinition = "TIMESTAMP")
   private Date lastUpdate;

}

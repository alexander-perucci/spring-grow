#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business;

import java.util.List;

public interface CRUDService<PK, MODEL> {
   List<MODEL> findAll() throws BusinessException;
   DataTablesResponse<MODEL> findAllPaginated(DataTablesRequest dataTableRequestGrid) throws BusinessException;
   void create(MODEL model) throws BusinessException;
   MODEL findByPK(PK pk) throws BusinessException;
   void update(MODEL model) throws BusinessException;
   void delete(MODEL model) throws BusinessException;

}

#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business.impl;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.transaction.annotation.Transactional;

import ${package}.business.BusinessException;
import ${package}.business.CRUDService;
import ${package}.business.DataTablesRequest;
import ${package}.business.DataTablesResponse;
import ${package}.business.SearchField;

/**
 *
 * @param <PK>
 *           Primary Key of the Business Model
 * @param <MODEL>
 *           Generic Business Model
 */
public class JPACRUDService<PK, MODEL> implements CRUDService<PK, MODEL> {

   protected Class<MODEL> persistentClass;
   
   @PersistenceContext
   protected EntityManager em;
   
   @SuppressWarnings("unchecked")
   public JPACRUDService() {
      this.persistentClass  = (Class<MODEL>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[1];
   }

   @Override
   @Transactional
   public List<MODEL> findAll() throws BusinessException {
      String sql = "from " + persistentClass.getSimpleName() + " order by id";
      TypedQuery<MODEL> q = em.createQuery(sql, persistentClass);
      return q.getResultList();
   }

   @Override
   @Transactional(readOnly = true)
   public DataTablesResponse<MODEL> findAllPaginated(DataTablesRequest requestGrid)
         throws BusinessException {

      StringBuilder sql = new StringBuilder();
      StringBuilder sqlCount = new StringBuilder();
      sql.append("select distinct e ");
      sql.append(" from ");
      sql.append(persistentClass.getSimpleName()).append(" as e ");
      sql.append(" ");
      sqlCount.append("select count(distinct e) from ");
      sqlCount.append(persistentClass.getSimpleName()).append(" as e ");
      sqlCount.append(" ");
 
      List<SearchField> searchFields = requestGrid.getSearchFields();
      for (SearchField searchField : searchFields) {
         try {
            if (!searchField.isEmpty() && ConversionUtility.isCollectionFieldType(persistentClass, searchField.getName())) {
               sql.append(" join ").append(" e.").append(searchField.getNameRoot()).append(" as ").append(searchField.getAlias())
                     .append(" ");
               sqlCount.append(" join ").append(" e.").append(searchField.getNameRoot()).append(" as ").append(searchField.getAlias())
                     .append(" ");
            }
         } catch (NoSuchFieldException e) {
            throw new BusinessException("No Such Search Field", e);
         }

      }
      
      /* Single column search */
      boolean addWhere = true;
      for (SearchField searchField : searchFields) {
         if (!searchField.isEmpty()) {
            if (addWhere) {
               sql.append(" where ");
               sqlCount.append(" where ");
               addWhere = false;
            } else {
               sql.append(" and ");
               sqlCount.append(" and ");
            }
            try {

               if (ConversionUtility.isCollectionFieldType(persistentClass, searchField.getName())) {
                  sql.append(searchField.getNameAlias());
                  sqlCount.append(searchField.getNameAlias());
               } else {
                  sql.append(" e.").append(searchField.getName());
                  sqlCount.append(" e.").append(searchField.getName());
               }

               if (searchField.isIsNull()) {
                  sql.append(" IS NULL ");
                  sqlCount.append(" IS NULL ");
               } else if (searchField.isIsNotNull()) {
                  sql.append(" IS NOT NULL ");
                  sqlCount.append(" IS NOT NULL ");
               } else {
                  String operand = ConversionUtility.getOperand(persistentClass, searchField);
                  sql.append(operand);
                  sqlCount.append(operand);
                  if (searchField.isRangeIn()) {
                     sql.append(" (:").append(searchField.getNameParam()).append(") ");
                     sqlCount.append(" (:").append(searchField.getNameParam()).append(") ");
                  } else {
                     sql.append(searchField.getNameParam());
                     sqlCount.append(searchField.getNameParam());
                  }
               }

            } catch (NoSuchFieldException e) {
               throw new BusinessException("No Such Search Field", e);
            }
         }
      }
      
      /* Single table search */
      boolean addAnd = true;
      if (!"".equals(requestGrid.getsSearch())) {
         for (SearchField searchField : searchFields) {
            if (addWhere) {
               sql.append(" where ");
               sqlCount.append(" where ");
               addWhere = false;
            } else {
               sql.append(" or ");
               sqlCount.append(" or ");
            }
            try {
               sql.append(" e.").append(searchField.getName());
               sqlCount.append(" e.").append(searchField.getName());
               String operand = ConversionUtility.getOperand(persistentClass, searchField);
               sql.append(operand);
               sqlCount.append(operand);
               if (searchField.isRangeIn()) {
                  sql.append(" (:").append("global_".concat(searchField.getNameParam())).append(") ");
                  sqlCount.append(" (:").append("global_".concat(searchField.getNameParam())).append(") ");
               } else {
                  sql.append("global_".concat(searchField.getNameParam()));
                  sqlCount.append("global_".concat(searchField.getNameParam()));
               }

            } catch (NoSuchFieldException e) {
               throw new BusinessException("No Such Search Field", e);
            }
         }
         if (!addAnd) {
            sql.append(" ) ");
            sqlCount.append(" ) ");
         }
      }

      sql.append(" order by e.").append(requestGrid.getSortCol()).append(" ").append(requestGrid.getSortDir());

      TypedQuery<MODEL> query = em.createQuery(sql.toString(), persistentClass);
      Query queryCount = em.createQuery(sqlCount.toString());
      
      /* Set value for single column search*/
      for (SearchField searchField : searchFields) {
         if (!searchField.isEmpty() && !searchField.isIsNull() && !searchField.isIsNotNull()) {
            try {
               query.setParameter(searchField.getNameParam(), ConversionUtility.getParamObject(persistentClass, searchField.getName(),
                     searchField.getValue(), searchField.isAddPercentPrefix(), !searchField.isRange()));
               queryCount.setParameter(searchField.getNameParam(), ConversionUtility.getParamObject(persistentClass,
                     searchField.getName(), searchField.getValue(), searchField.isAddPercentPrefix(), !searchField.isRange()));
            } catch (NoSuchFieldException e) {
               throw new BusinessException("No Such Search Field", e);
            }
         }
      }
      
      /* Set value for single table search*/
      if (!"".equals(requestGrid.getsSearch())) {
         for (SearchField searchField : searchFields) {
            try {
               query.setParameter("global_".concat(searchField.getNameParam()), ConversionUtility.getParamObject(persistentClass,
                     searchField.getName(), requestGrid.getsSearch(), false, true));
               queryCount.setParameter("global_".concat(searchField.getNameParam()), ConversionUtility
                     .getParamObject(persistentClass, searchField.getName(), requestGrid.getsSearch(), false, true));
            } catch (NoSuchFieldException e) {
               throw new BusinessException("No Such Search Field", e);
            }

         }
      }
      
      // Set First and Max query results
      if (requestGrid.getiDisplayStart() > 0) {
         query.setFirstResult(requestGrid.getiDisplayStart());
      }
      
      if (requestGrid.getiDisplayLength() > 0) {
         query.setMaxResults(requestGrid.getiDisplayLength());
      }

      List<MODEL> results = query.getResultList();
      
      long records = (Long) queryCount.getSingleResult();
      return new DataTablesResponse<MODEL>(requestGrid.getsEcho(), records, records, results);
   }

   @Override
   @Transactional
   public MODEL findByPK(PK id) throws BusinessException {
      return (MODEL) em.find(persistentClass, id);
   }

   @Override
   @Transactional()
   public void create(MODEL model) throws BusinessException {
      em.persist(model);
   }

   @Override
   @Transactional()
   public void update(MODEL model) throws BusinessException {
      em.merge(model);
   } 
   @Override
   @Transactional()
   public void delete(MODEL model) throws BusinessException {
      em.remove(em.contains(model) ? model : em.merge(model));
   }
}

#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business;

import ${package}.business.model.User;

public interface UserService extends CRUDService<Long, User> {
   User findByUsername(String username) throws BusinessException;

   User findByEmail(String email) throws BusinessException;
}

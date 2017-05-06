#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business;

public class BusinessException extends  RuntimeException {
   private static final long serialVersionUID = -2747157039796007525L;
   
   public BusinessException() {
      super();
   }

   public BusinessException(String message, Throwable cause) {
      super(message, cause);
   }

   public BusinessException(String message) {
      super(message);
   }

   public BusinessException(Throwable cause) {
      super(cause);
   }
}

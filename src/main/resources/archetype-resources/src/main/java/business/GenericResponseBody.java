#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business;

public class GenericResponseBody implements java.io.Serializable {
   private static final long serialVersionUID = -2266138096109030987L;

   private GenericResponseBodyState state;
   private Object result;
   
   public GenericResponseBody(GenericResponseBodyState state) {
      super();
      this.state = state;
   }

   public GenericResponseBody(GenericResponseBodyState state, Object result) {
      super();
      this.state = state;
      this.result = result;
   }

   public GenericResponseBodyState getState() {
      return state;
   }

   public void setState(GenericResponseBodyState state) {
      this.state = state;
   }

   public Object getResult() {
      return result;
   }

   public void setResult(Object result) {
      this.result = result;
   }

   public enum GenericResponseBodyState {
      SUCCESS, ERROR;
   }

}

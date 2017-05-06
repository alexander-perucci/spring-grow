#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.business;

public class AvatarRequest implements java.io.Serializable {
   private static final long serialVersionUID = 8179385778854968258L;

   private Double x;
   private Double y;
   private Double height;
   private Double width;
   private Integer scaleX;
   private Integer scaleY;
   private Integer rotate;

   public AvatarRequest() {
      super();
   }

   public AvatarRequest(Double x, Double y, Double height, Double width, Integer scaleX, Integer scaleY,
         Integer rotate) {
      super();
      this.x = x;
      this.y = y;
      this.height = height;
      this.width = width;
      this.scaleX = scaleX;
      this.scaleY = scaleY;
      this.rotate = rotate;
   }

   public Double getX() {
      return x;
   }

   public void setX(Double x) {
      this.x = x;
   }

   public Double getY() {
      return y;
   }

   public void setY(Double y) {
      this.y = y;
   }

   public Double getHeight() {
      return height;
   }

   public void setHeight(Double height) {
      this.height = height;
   }

   public Double getWidth() {
      return width;
   }

   public void setWidth(Double width) {
      this.width = width;
   }

   public Integer getScaleX() {
      return scaleX;
   }

   public void setScaleX(Integer scaleX) {
      this.scaleX = scaleX;
   }

   public Integer getScaleY() {
      return scaleY;
   }

   public void setScaleY(Integer scaleY) {
      this.scaleY = scaleY;
   }

   public Integer getRotate() {
      return rotate;
   }

   public void setRotate(Integer rotate) {
      this.rotate = rotate;
   }
}

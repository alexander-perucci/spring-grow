#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.common.utility;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;

import ${package}.business.BusinessException;

public class Utility {

   public static Date actualDate() {
      return new Date();
   }

   public static byte[] cropImage(byte[] image, int x, int y, int height, int width, boolean flipHorizontally,
         boolean flipVertically, int rotate) throws BusinessException {
      InputStream imageInputStream = new ByteArrayInputStream(image);
      BufferedImage bufferedImage;
      try {
         bufferedImage = ImageIO.read(imageInputStream);
      } catch (IOException e) {
         throw new BusinessException("Error to read the image", e);
      }
      
      if (bufferedImage == null){
         throw new BusinessException("Error to read the image, please make sure to have an image file");
      }
      
      switch (rotate) {
      case 90:
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.CW_90, Scalr.OP_ANTIALIAS);
         break;
      case 180:
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.CW_180, Scalr.OP_ANTIALIAS);
         break;
      case 270:
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.CW_270, Scalr.OP_ANTIALIAS);
         break;
      case -90:
         // -90 degree = Rotation.CW_90 + Rotation.FLIP_HORZ +
         // Rotation.FLIP_VERT
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.CW_90, Scalr.OP_ANTIALIAS);
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_HORZ, Scalr.OP_ANTIALIAS);
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_VERT, Scalr.OP_ANTIALIAS);
         break;
      case -180:
         // -180 degree = Rotation.FLIP_HORZ + Rotation.FLIP_VERT
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_HORZ, Scalr.OP_ANTIALIAS);
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_VERT, Scalr.OP_ANTIALIAS);
         break;
      case -270:
         // -270 degree = Rotation.CW_270 + Rotation.FLIP_HORZ +
         // Rotation.FLIP_VERT
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.CW_270, Scalr.OP_ANTIALIAS);
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_HORZ, Scalr.OP_ANTIALIAS);
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_VERT, Scalr.OP_ANTIALIAS);
         break;
      }

      if (flipHorizontally) {
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_HORZ, Scalr.OP_ANTIALIAS);
      }
      
      if (flipVertically) {
         bufferedImage = Scalr.rotate(bufferedImage, Scalr.Rotation.FLIP_VERT, Scalr.OP_ANTIALIAS);
      } 

      bufferedImage = Scalr.crop(bufferedImage, x, y, width, height, Scalr.OP_ANTIALIAS);
      ByteArrayOutputStream croppedImageOutputStream = new ByteArrayOutputStream();

      try {
         ImageIO.write(bufferedImage, "jpg", croppedImageOutputStream);
      } catch (IOException e) {
         throw new BusinessException("Error to get a ByteArrayOutputStream of the cropped image", e);
      }

      return croppedImageOutputStream.toByteArray();
   }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

/**
 *
 * @author kenziemclouth
 * 
 * GOT THIS FROM: https://www.mkyong.com/java/java-md5-hashing-example/
 */
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Hashing
{
    public static String encryptString(String string) 
    {
        
        StringBuffer sb = new StringBuffer();
    	
        try{
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(string.getBytes());

            byte byteData[] = md.digest();

            //convert the byte to hex format method 1
            
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }
        
        } catch (NoSuchAlgorithmException e){
            e.printStackTrace();
        }

        return sb.toString();
    }
}

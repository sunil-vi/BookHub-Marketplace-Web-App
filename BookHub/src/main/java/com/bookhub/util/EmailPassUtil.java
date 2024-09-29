package com.bookhub.util;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailPassUtil {
	    private static final String SECRET_KEY = "MYSUPERSECRETKEY";
	    private static final String 
	    EMAIL_PATTERN = 
	    		"^(.+)@(\\S+)$",
	            
	    PASSWORD_PATTERN = 
	            "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";

	    public static String encrypt(String strToEncrypt) {
	        try {
	            SecretKeySpec secretKeySpec = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
	            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
	            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
	            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8)));
	        } catch (Exception e) {
	            System.out.println("Error while encrypting: " + e.toString());
	        }
	        return null;
	    }

		public static boolean isEmail(String email) {
			// TODO Auto-generated method stub
			Pattern pattern = Pattern.compile(EMAIL_PATTERN);
	        Matcher matcher = pattern.matcher(email);
	        return matcher.matches();
			
		}

		public static boolean isPass(String password) {
			// TODO Auto-generated method stub
			Pattern pattern = Pattern.compile(PASSWORD_PATTERN);
	        return pattern.matcher(password).matches();
		}

		/*
		 * public static String decrypt(String strToDecrypt) { try { SecretKeySpec
		 * secretKeySpec = new SecretKeySpec(SECRET_KEY.getBytes(), "AES"); Cipher
		 * cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
		 * cipher.init(Cipher.DECRYPT_MODE, secretKeySpec); return new
		 * String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt))); } catch
		 * (Exception e) { System.out.println("Error while decrypting: " +
		 * e.toString()); } return null; }
		 */
	    
	}


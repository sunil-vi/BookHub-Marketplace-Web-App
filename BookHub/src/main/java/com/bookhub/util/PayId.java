package com.bookhub.util;
import java.util.Random;

public class PayId {



	    public static String pId() {
	        String numericCharacters = "0123456789";
	        Random random = new Random();
	        StringBuilder stringBuilder = new StringBuilder(10);

	        for (int i = 0; i < 10; i++) {
	            int index = random.nextInt(numericCharacters.length());
	            char randomChar = numericCharacters.charAt(index);
	            stringBuilder.append(randomChar);
	        }

	        return stringBuilder.toString();
	    }
	

	
}

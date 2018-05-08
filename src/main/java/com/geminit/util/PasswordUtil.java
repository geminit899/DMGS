package com.geminit.util;

import org.apache.commons.codec.digest.DigestUtils;

import java.util.Random;

public class PasswordUtil {

    public static String generateSalt(){

        StringBuffer salt = new StringBuffer();
        int length = 16;

        String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();

        for(int i = 0; i < length; i++){
            int number = random.nextInt(62);
            salt.append(str.charAt(number));
        }

        return salt.toString();

    }

    public static String generateMd5BySalt(String password, String salt){

        String oneTimeMd5 = DigestUtils.md5Hex(password + salt);

        String twoTimesMd5 = DigestUtils.md5Hex(oneTimeMd5);

        return twoTimesMd5;

    }

}

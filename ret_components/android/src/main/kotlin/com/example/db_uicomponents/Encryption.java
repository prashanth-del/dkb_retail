package com.example.db_uicomponents;

import android.os.Build;
import android.util.Base64;
import android.util.Log;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class Encryption {
    public static String encCode (String val, String pk, String sl, String itr, String keyLen) throws NoSuchAlgorithmException, UnsupportedEncodingException, DecoderException {
        try {
            Log.d("NFIEncryption", "encryptCode start");
            if (checkNotNull(val) && checkNotNull(pk) && checkNotNull(sl) && checkNotNull(itr) && checkNotNull(keyLen)) {
                Log.d("NFIEncryption", "encryptCode values not empty");
                String password = val;
                String salt = sl;
                String key = pk;
                int iterations = Integer.parseInt(itr);
                int keyLength = Integer.parseInt(keyLen);
                //Conversion to MD5
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] array = md.digest(password.getBytes("UTF-8"));
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < array.length; ++i) {
                    sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
                }
                Log.d("NFIEncryption", "md5 value" + sb);
                String md5Hash = sb.toString();
                //Encoding to base64
                byte[] bytes = Hex.decodeHex(md5Hash.toCharArray());
                String base64EncodedMD5 = android.util.Base64.encodeToString(bytes, Base64.NO_WRAP);
                Log.d("NFIEncryption", "encodedMD5" + base64EncodedMD5);
                //encryption to PBKDF2
                char[] passwordChars = base64EncodedMD5.toCharArray();
                byte[] saltBytes = salt.getBytes();
                byte[] hashedBytes = hashPassword(passwordChars, saltBytes, iterations, keyLength);
                String hashedString = new String(Hex.encodeHex(hashedBytes));
                Log.d("NFIEncryption", "PBKDF2 hashed string " + hashedString);
                //encryption of PBKDF2 with public key with RSA
                String base64Enc = null;
                try {
                    base64Enc = encrypt(hashedString, key);
                } catch (Exception e) {
                }
                Log.d("NFIEncryption", "Encrypted value " + base64Enc);
                Log.d("NFIEncryption", "NFI Encryption end");
                return base64Enc;
            } else {
                Log.d("NFIEncryption", "encryptCode values empty");
                return Constants.invalidInputs;
            }
        } catch (Exception e){
            return Constants.exception;
        }
    }

    private static byte[] hashPassword( final char[] password, final byte[] salt, final int iterations, final int keyLength ) {
        try {
            SecretKeyFactory skf = SecretKeyFactory.getInstance(Constants.RSAEncryption);
            PBEKeySpec spec = new PBEKeySpec( password, salt, iterations, keyLength);
            SecretKey key = skf.generateSecret( spec );
            byte[] res = key.getEncoded( );
            return res;
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e ) {
            throw new RuntimeException( e );
        }
    }

    private static String encrypt(String plainText, String base64PublicKey) throws Exception {
        Log.d("Encrypt","Inside encrypt");
        byte[] cipherText;
        cipherText = encryptWithPublicKey(plainText, getPublicKey(base64PublicKey));
        //

        Log.d("Encrypt","After encryptW/PKey");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            Log.d("Encrypt","inside encrypt if and returning");
            return java.util.Base64.getEncoder().encodeToString(cipherText);
        } else {

            Log.d("Encrypt","inside encrypt else and returning");
            return android.util.Base64.encodeToString(cipherText,Base64.NO_WRAP);
        }
    }

    private static byte[] encryptWithPublicKey(String plainText, PublicKey publicKey) throws Exception {
        Log.d("Encrypt", "inside encryptW/PKey: step 1");
        Cipher cipher = Cipher.getInstance(Constants.cipher);

        Log.d("Encrypt", "inside encryptW/PKey: step 2");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);

        Log.d("Encrypt", "inside encryptW/PKey: step 3 and returning");
        return cipher.doFinal(plainText.getBytes(StandardCharsets.UTF_8));
    }

    private static PublicKey getPublicKey(String base64PublicKey){
        PublicKey publicKey = null;
        try{
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(android.util.Base64.decode(base64PublicKey,android.util.Base64.DEFAULT));
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            publicKey = keyFactory.generatePublic(keySpec);
            return publicKey;
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            
        }
        return publicKey;
    }

    private static boolean checkNotNull(String text) {
        return text != null && !text.trim().equals("null") && text.trim().length() > 0;
    }
}

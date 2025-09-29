package com.example.db_uicomponents;

import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

import org.jose4j.jwe.ContentEncryptionAlgorithmIdentifiers;
import org.jose4j.jwe.JsonWebEncryption;
import org.jose4j.jwe.KeyManagementAlgorithmIdentifiers;
import org.jose4j.jwk.JsonWebKey;
import org.jose4j.jws.AlgorithmIdentifiers;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.jwx.CompactSerializer;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import android.util.Log;



public class JoseEnc {

    private static String ibPubKey = "-----BEGIN PUBLIC KEY-----\r\n"
            + "MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAzpo33Iyq1hik/AlWyStJ\r\n"
            + "gNs6TiK558jKf2yNre1UeP0dxoVanX4qLT+c2NiULMZyGXFWUbPlwjYwqchMXNdG\r\n"
            + "Ixp7+amJFEDxcZN47KauYq+FWvRkdPrurYkoYL4At0IbqKhwxyR7jB1KlnvvbmU9\r\n"
            + "GWTo3ta11AcoDlpP9O5VZxFuxI0aBT97nl3bZK2+u8EgDJzsS/cxAkN0ztdrQonq\r\n"
            + "P1jmoiRXshjCnrBzdhJY6u0cV1Ml1VPmI3xT/wZ6uPOUQ8nsgrvQxRdv5UVWI9EL\r\n"
            + "pliRcWLKXn2Z/XXCJEgcymLQ6CNpolz5a7BTbpgEAAEsm0mnA1isfPCdm8uyS26l\r\n"
            + "kjAVM0y2q2TtAwB0So5jJtXp/WU+zQ6NR4R0GAoMfuqzFJIeMyMPxLh1niEzB/zY\r\n"
            + "HJ6R1dLchCB0f+q2KTg77agzXLHJyvgu2Zes0YjGOvRVLHpBx0VJQXVWJ0a/VG9/\r\n"
            + "MufrvsnOmE4nYCCDdreLRANUgGdOqHVTINzXflO+jdVbAgMBAAE=\r\n" + "\r\n" + "-----END PUBLIC KEY-----";
    private static String ibPvtKey = "-----BEGIN PRIVATE KEY-----\r\n"
            + "MIIG/AIBADANBgkqhkiG9w0BAQEFAASCBuYwggbiAgEAAoIBgQDOmjfcjKrWGKT8\r\n"
            + "CVbJK0mA2zpOIrnnyMp/bI2t7VR4/R3GhVqdfiotP5zY2JQsxnIZcVZRs+XCNjCp\r\n"
            + "yExc10YjGnv5qYkUQPFxk3jspq5ir4Va9GR0+u6tiShgvgC3QhuoqHDHJHuMHUqW\r\n"
            + "e+9uZT0ZZOje1rXUBygOWk/07lVnEW7EjRoFP3ueXdtkrb67wSAMnOxL9zECQ3TO\r\n"
            + "12tCieo/WOaiJFeyGMKesHN2Eljq7RxXUyXVU+YjfFP/Bnq485RDyeyCu9DFF2/l\r\n"
            + "RVYj0QumWJFxYspefZn9dcIkSBzKYtDoI2miXPlrsFNumAQAASybSacDWKx88J2b\r\n"
            + "y7JLbqWSMBUzTLarZO0DAHRKjmMm1en9ZT7NDo1HhHQYCgx+6rMUkh4zIw/EuHWe\r\n"
            + "ITMH/NgcnpHV0tyEIHR/6rYpODvtqDNcscnK+C7Zl6zRiMY69FUsekHHRUlBdVYn\r\n"
            + "Rr9Ub38y5+u+yc6YTidgIIN2t4tEA1SAZ06odVMg3Nd+U76N1VsCAwEAAQKCAYA0\r\n"
            + "MMIWzVQkpHIdFxDc3boCOp82eNBErLT2zonV24PA0pQwf6R9746hApZRMxjvXKwb\r\n"
            + "IEXhetP6JS1S3n3n4BvgJ0MVNQ4jVyqG+e2MvqiD1noWGXG9GVys6t6P3b+Zi7In\r\n"
            + "/3EJ5X3uTcH3VNSNqzZtkU/AZzXkm3Aze/4Bzik10bINJeXiWICWZ3hSLQ/nJyi8\r\n"
            + "9vE8WXQAceDylXmLhAJwQTl10T90Bow3gTSRqZ3brs0/hAolIz4aTcB8Rns++IzR\r\n"
            + "0SfDuwj4BRy7VpEQUSVEC1/COOtq4nBWA9mlrKafwjmKeUWsXo4hdT3yrQwe6+Tk\r\n"
            + "pM58MP8g3MwQOHkOc9+dQVhRgRhUWMH0RJnYBDxqBiJYpUdyWJYTtiBKg3D0/xPT\r\n"
            + "jwktfoxP7OOIjdLZjiSWFn87Ft3i8oWmc3eErOfDmhqHa8IYekmf0nCm8oJkX7oI\r\n"
            + "4L5qeali5/t6+qa6/6gQl1HHiwof3nO6uxJ65J9CnT5odteN1cRuH2yOH0M2E+UC\r\n"
            + "gcEA9FQzHAP4EKsrjUuAoLlQQWfeDpVTMuU627wJJrR63RyizcuQk3QeJKP+6S/x\r\n"
            + "RYJW68sIXGkqrjLDuKG/9SupvNmFee8fwxSPH3gK7g+7SJbyrxdS1pK1XHEI8YFN\r\n"
            + "SpxgcvQtQc1eZgzZ53U0FfTMtD1QYwPyrbLmotFnLD5qB6sU7g32N6zX38znd4Vq\r\n"
            + "hz3ipQLnFCWoa/qeW6qq1cSfGSFmLsF5ANYtd3MR811REr7HiSEH4cyCKl5mJ4DR\r\n"
            + "GP7fAoHBANh4rSn3cXzLA3IUr/I5GaWc1uVDKTlAWh1asP7m46GRpqp6W/18oUph\r\n"
            + "55WmkBaxthf/yAYUnxLhjoEYl7taXuVdxhpAUAZ9KKgThCg4al4CaBrrHlrygELH\r\n"
            + "llg6pph/swbDc3toyvYywbkMM4ebQlo43Gsw70Seo/AOC0vM5oK5pLiwQDc6g6eg\r\n"
            + "sDkU9S7l3844o5TyLynPQ7DjKS6hzCwvpl6rViBmu7iXGI3foB00TG1ixlYhE6RB\r\n"
            + "ZjR5szmFBQKBwCPWmeyZFHD1epzuHz70D7aYUrUW6C5F+30xtrHrtT3rrmG7Y0iN\r\n"
            + "tsIvH/v6YUyN0swhaueLMYx9u8HAUBTZQ7uEuJRrI+CMinXWONw0iIccRRqztB3v\r\n"
            + "RRT7K5GpIro399nEwUKuqhMT/X567Znu33vspnbvpFAgNr5ZMuYFfa4ERTyp5ZzD\r\n"
            + "CKM2PhmFA1w1EqKbq2OEJpE4ILRXc1mJzsBz6rYfAO3DfMXRpidpX7P9Me2GX86a\r\n"
            + "HdmzIQ7YUVN2RwKBwFe3LpPezIHA0bicYV9Je/b7wqhLupyUUu+qHCZt8Lc7icly\r\n"
            + "o2vn4IN/gJPHVoObpym6X5b3LC4+b7wn9vPX/rP6d5eTj9nRRXQ11Etn8NH/L6gY\r\n"
            + "tcgsk4R705QU0ATjWevXryfGotd4Yb9WDltYsl5UxBw7S/kGP2+6gSFJ+e3mw7SC\r\n"
            + "1sKKV2bJWh8HOwKx6yppEP/90taiQc+ffMSEk3MkK8oYq2Gdv1tg/nYes4ah9oYs\r\n"
            + "jCnCZW8dgQiqd9FK8QKBwE7Yaub/2C8vnjeeiVFkgCh3vBSNdgedctSXKF/mptzm\r\n"
            + "TXOPmZvkWgN5OSjalOPK00+4X3AtQAtox7gbkSG0/lETKVBUJo1SxAPqFalpbLa7\r\n"
            + "1wAzOcfNucIQjjRwMnRYlViWIbdO0MUINJNdN53A4JB4cpGZVfqUjtW3KPZYWUyn\r\n"
            + "hwal6W+zdWnkLLj9d+BBLLMr8VU6QqYVHIxBkRnyMDZ50sdk0hK0YBGtZ4x+hlBW\r\n" + "sQfDguWDjvsXvsNAJRH8dA==\r\n"
            + "\r\n" + "-----END PRIVATE KEY-----";

    private static String rsaPubKey = "-----BEGIN PUBLIC KEY-----\r\n"
            + "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoN7Xuk6ANhZdSrgSAe5N\r\n"
            + "Qq3XEk0AGn2gApNfJasTyF4B8ScPY2NvusYEwEcsRSaeLYC1hukGvQubwpnC8XZV\r\n"
            + "5dm4MCrJ4yPmddi3Aj2P/YOHBhWJuiX3nbGk5eXp60hywg5r6UnAJP90yvLQJ+Rx\r\n"
            + "RS51tNd4pW3gsuXsSC42rWUndVw2cKWyBzBubNMIVoBf/gGnm/oNucZCO3z4BnA1\r\n"
            + "ZccnBcTxwptJvOrhWx58dBnxp3p5L+r6ihIfMZ6b00gNKxMsbCdpvqGzkfxjYGjT\r\n"
            + "qQ/uOWM1nJlolI4mMbL1CFEP8XT2M3/6LE7KJV3Hm7vvL6rhePSbXZcn1CIHsuW0\r\n" + "wQIDAQAB\r\n" + "\r\n"
            + "-----END PUBLIC KEY-----";
    private static String rsaPvtKey = "-----BEGIN PRIVATE KEY-----\r\n"
            + "MIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCg3te6ToA2Fl1K\r\n"
            + "uBIB7k1CrdcSTQAafaACk18lqxPIXgHxJw9jY2+6xgTARyxFJp4tgLWG6Qa9C5vC\r\n"
            + "mcLxdlXl2bgwKsnjI+Z12LcCPY/9g4cGFYm6JfedsaTl5enrSHLCDmvpScAk/3TK\r\n"
            + "8tAn5HFFLnW013ilbeCy5exILjatZSd1XDZwpbIHMG5s0whWgF/+Aaeb+g25xkI7\r\n"
            + "fPgGcDVlxycFxPHCm0m86uFbHnx0GfGnenkv6vqKEh8xnpvTSA0rEyxsJ2m+obOR\r\n"
            + "/GNgaNOpD+45YzWcmWiUjiYxsvUIUQ/xdPYzf/osTsolXcebu+8vquF49JtdlyfU\r\n"
            + "Igey5bTBAgMBAAECgf8C3V5ykQJdIWMtj5IN0Rn4hvLNhkY2bsoIyTyz0OcnZoUp\r\n"
            + "3Mv4ahCp4OvpcZdBo/14aI6Wwdrc3VCG4tu7gBw0qNGIRknZm/7CZca+aR4BqXuY\r\n"
            + "a29qUiSlwNbrIwdaMMpw9YV99NnJ7P7jrWA0vxFjbcMyXqPtAvFQPkBn23nhjYJ3\r\n"
            + "rzOn87LFo0l9tlCvFgbfJ41DtqZdlNFp6omYvuBT7hEL96G1F8MjddBVyiOHX6t+\r\n"
            + "GjKnegTYgPZ+tHdZbcVBsF8MyFisUyW2NMziQ9xLL8MtNfltz4X83ZGmy/A7xuER\r\n"
            + "A48uW6FqIqJP7WqlruqzRETxeyp9J+OrRNiqwAECgYEAvuimemY+ViVyT/1jfU59\r\n"
            + "96eAn5E4vh4yavxBhpGLvlGOUayy47FIKtAke0GafZnH9wGtHxEY10K2rrCa0P41\r\n"
            + "kSydK75+oWXhLlkip+OxvPQcyrQiq41VQfxMlJJ1ycRlHFEC8NFnoBHCJIYZiJJQ\r\n"
            + "EbTz9kqrP4xV8iF3W5u3xsECgYEA17hRY44ohCgNYYTy/d9Pwj8bn5V1ML59+I6S\r\n"
            + "aiFHbf+4+v360rVw5v4C4ecdaNf3iz1T/718cPh1DXrk8RMfkp2jrD6eFs5QYiNY\r\n"
            + "Oo6DYQgwZqlwN+MvtGSwWIJzk0aybLvryOKdJnb6OelxND2exkpspzxNIgsoquOV\r\n"
            + "/VCHbgECgYAIRpuY6L/BCkSHVSuv7ewmBTvdLvVvwG1dF+xbQgn1ySFLRxpGJpRD\r\n"
            + "TtyV/0UMNtNlUMxJcXtLMZgrwHolny+BSJbTo6Fnq7v0P2byMjutPkPVQbPTDgBp\r\n"
            + "KN/E/QhgI8RiUty2xc0hMkPhQ3Lt6bHQ4rBEt/3udk3vfiXncbuowQKBgQDKvO65\r\n"
            + "CwznD6FryoB4upyCKb9zXwrRseZAaPYQCpDQP6sBMRu/Vkjyvz3EQ+pu87IxyYSd\r\n"
            + "cN94aPnRnnN2YoukxsThh8QaGPKRGTi9Z9zvn7ulcI8H51uZRZw6wveOLb5Y1NCH\r\n"
            + "bvtVADKxpMUA3PzQzXeKQPEZErW4zcXUWg++AQKBgEzAqxJSdi0bSTje4LZJPL2J\r\n"
            + "0EQ871e36XBe5oaclQrN78k1z1/BS6wgDfadGRSFQywgyPEOhkuX8hFcmBWp+xXu\r\n"
            + "EglTWZ/QnVVNSwNeDa2mhX/UDOQDB2zujAxVVCX49Br5PwNQA4KPnCBXE/y2gBPa\r\n" + "lbSuBecdLdRAoO1deEWN\r\n"
            + "\r\n" + "-----END PRIVATE KEY-----";

    @SuppressWarnings("unchecked")
    public static String encrypt(String payload) throws Exception {
        Log.d("myJoseEnd", "Enter"+payload);
        JsonWebKey jwk = JsonWebKey.Factory.newJwk(readPrivateKey(ibPvtKey));
        JsonWebSignature jws = new JsonWebSignature();
        jws.setAlgorithmHeaderValue(AlgorithmIdentifiers.RSA_USING_SHA512);
        jws.setPayload(payload);
        jws.setKey(jwk.getKey());
        jws.sign();
        System.out.println(jws.getCompactSerialization());
        JsonWebKey jwk1 = JsonWebKey.Factory.newJwk(readPublicKey(rsaPubKey));

        JsonWebEncryption jwe = new JsonWebEncryption();
        jwe.setAlgorithmHeaderValue(KeyManagementAlgorithmIdentifiers.RSA_OAEP_256);
        jwe.setEncryptionMethodHeaderParameter(ContentEncryptionAlgorithmIdentifiers.AES_256_CBC_HMAC_SHA_512);
        jwe.setKey(jwk1.getKey());
        jwe.setPayload(jws.getCompactSerialization());

        String response = jwe.getCompactSerialization();
        Log.d("myJoseEnd", "Enter seialization"+response);
        String[] jweArr = CompactSerializer.deserialize(response);
        System.out.println(jweArr.length);
        JSONObject obj = new JSONObject();
        obj.put("tc", jweArr[3]);
        obj.put("ke", jweArr[1]);
        obj.put("pd", jweArr[0]);
        obj.put("vi", jweArr[2]);
        obj.put("gt", jweArr[4]);
        String jsonString = obj.toJSONString();
        Log.d("myJoseEnd", "Exit"+jsonString);
        return jsonString;
    }

    public static String decrypt(String encryptedRequestFromUI) {
        String payload = null;
        try {
            Log.d("myJoseDec", "Enter"+encryptedRequestFromUI);
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(encryptedRequestFromUI);
            String headers = (String) json.get("pd");
            String encrypted_key = (String) json.get("ke");
            String iv = (String) json.get("vi");
            String cipherText = (String) json.get("tc");
            String tag = (String) json.get("gt");
            String request = headers+"."+encrypted_key+"."+iv+"."+cipherText+"."+tag;
            JsonWebEncryption jwe = new JsonWebEncryption();
            JsonWebKey jwk = JsonWebKey.Factory.newJwk(readPrivateKey(ibPvtKey));
            jwe.setKey(jwk.getKey());
            jwe.setCompactSerialization(request);
            String payloadOut = jwe.getPlaintextString();
            JsonWebKey jwk1 = JsonWebKey.Factory.newJwk(readPublicKey(rsaPubKey));
            JsonWebSignature jws  = new JsonWebSignature();
            jws.setDoKeyValidation(true);
            jws.setKey(jwk1.getKey());
            jws.setCompactSerialization(payloadOut);
            payload = jws.getPayload();
            Log.d("myJoseDec", "Enter"+payload);
        } catch(Exception ex) {
            
        }
        return payload;
    }

        

    private static RSAPrivateKey readPrivateKey(String pemPrivateKeyString)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        String base64KeyData = pemPrivateKeyString.replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "").replaceAll("\\s", "");
        System.out.println(base64KeyData);
        byte[] privateKeyBytes = Base64.getDecoder().decode(base64KeyData);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);

        return (RSAPrivateKey) keyFactory.generatePrivate(keySpec);
    }

    private static RSAPublicKey readPublicKey(String pemPublicKeyString)
            throws NoSuchAlgorithmException, InvalidKeySpecException {
        String base64KeyData = pemPublicKeyString.replace("-----BEGIN PUBLIC KEY-----", "")
                .replace("-----END PUBLIC KEY-----", "").replaceAll("\\s", "");

        byte[] publicKeyBytes = Base64.getDecoder().decode(base64KeyData);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);

        return (RSAPublicKey) keyFactory.generatePublic(keySpec);
    }

}

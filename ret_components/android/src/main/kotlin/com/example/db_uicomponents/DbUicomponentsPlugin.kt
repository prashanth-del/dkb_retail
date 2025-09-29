package com.example.db_uicomponents

import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DbUicomponentsPlugin */
class DbUicomponentsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "db_uicomponents")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {

    when {
      call.method.equals("getPlatformVersion") -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }

      call.method.equals("encCode") -> {
        //Log.d("call argument", call.arguments());
        val value = call.argument<Any>("val").toString()
        val pubKey = call.argument<Any>("pk").toString()
        val salt = call.argument<Any>("salt").toString()
        val itr = call.argument<Any>("itr").toString()
        val kl = call.argument<Any>("kl").toString()
        Log.d("Arguments", "value -> $value")
        Log.d("Arguments", "pubKey --> $pubKey")
        Log.d("Arguments", "salt --> $salt")
        Log.d("Arguments", "itr --> $itr")
        Log.d("Arguments", "kl --> $kl")

        try {
          val encrypt = Encryption.encCode(value, pubKey, salt, itr, kl);
          result.success(encrypt)
        } catch (e: Exception) {
          result.error("8000", "Error", "Unable to encrypt")
        }
      }

      call.method.equals("encPayload") -> {
        //Log.d("call argument", call.arguments());
        val payLoad = call.argument<Any>("payLoad").toString()
        Log.d("Arguments", "payLoad -> $payLoad")

        try {
          val encrypt = JoseEnc.encrypt(payLoad);
          result.success(encrypt)
        } catch (e: Exception) {
          result.error("9000", "Error", "Payload Encryption Error")
        }
      }

      call.method.equals("decPayload") -> {
        //Log.d("call argument", call.arguments());
        val payLoad = call.argument<Any>("payLoad").toString()
        Log.d("Arguments", "payLoad -> $payLoad")

        try {
          val encrypt = JoseEnc.decrypt(payLoad);
          result.success(encrypt)
        } catch (e: Exception) {
          result.error("9009", "Error", "Payload decryption Error")
        }
      }

      call.method.equals("detectVPN") -> {
        try {
          val status = Utils.isCurrentStateVPN();
          result.success(status)
        } catch (e: Exception) {
          result.error("9010", "Error", "VPNError")
        }
      }

    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

package com.example.dkb_retail
 
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterFragmentActivity
import android.os.Bundle
import android.view.WindowManager

class MainActivity: FlutterFragmentActivity() {
 
    companion object {
        private const val CHANNEL = "app_config"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
 
        // MethodChannel to send flavor/buildConfig info to Dart
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getConfig" -> {
                        val cfg = hashMapOf<String, Any?>(
                            "flavor" to BuildConfig.FLAVOR,           // dev, uat, etc
                            "apiBaseUrl" to BuildConfig.API_BASE_URL, // from buildConfigField
                            "flavorName" to BuildConfig.FLAVOR_NAME   // explicit string
                        )
                        result.success(cfg)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
package com.example.dkb_retail

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "app_config"
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

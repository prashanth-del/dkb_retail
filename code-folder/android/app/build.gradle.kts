import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load local.properties
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

// Safe getter
fun propOrDefault(key: String, defaultValue: String): String =
    localProperties.getProperty(key, defaultValue)

android {
    namespace = "com.example.dkb_retail"
    compileSdk = propOrDefault("flutter.compileSdkVersion", "36").toInt()
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlinOptions {
        jvmTarget = "21"
    }

    buildFeatures {
        buildConfig = true
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.dkb_retail"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = propOrDefault("flutter.minSdkVersion", "28").toInt()
        targetSdk = propOrDefault("flutter.targetSdkVersion", "36").toInt()
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        ndk {
            abiFilters += listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64")
        }
    }

    buildTypes {
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false // or true with minify true
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("dev") {
            dimension = "default"
            versionCode = 1
            versionName = "1.0.0"
            // resource names cannot contain spaces; use a valid identifier
            resValue("string", "app_name", "Dukhan Bank")
            buildConfigField("String", "API_BASE_URL", "\"http://34.18.92.50:8443\"")
            buildConfigField("String", "FLAVOR_NAME", "\"dev\"")
        }
        create("uat") {
            dimension = "default"
            versionCode = 1
            versionName = "1.0.0"
            resValue("string", "app_name", "Dukhan Bank")
            buildConfigField("String", "API_BASE_URL", "\"https://cmd.dohabank.com\"")
            buildConfigField("String", "FLAVOR_NAME", "\"uat\"")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(project(":db_uicomponents"))
    // other libs…
}

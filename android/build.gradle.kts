plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.project" // แก้เป็นของคุณ
    compileSdk = 34

    // ✅ เพิ่มตรงนี้
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.project" // แก้เป็นของคุณ
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("com.google.android.material:material:1.12.0")
    // อื่น ๆ ที่ flutter ใช้
}

package com.dostavka.dostavka

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.Build
import android.view.ViewTreeObserver
import android.view.WindowManager
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine( flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
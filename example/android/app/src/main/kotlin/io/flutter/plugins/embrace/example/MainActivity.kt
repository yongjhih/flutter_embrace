package io.flutter.plugins.embrace.example

import android.os.Bundle
import io.embrace.android.embracesdk.Embrace

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    Embrace.getInstance().logError("error log with screenshot sent to Embrace (Woo-hoo!)")
  }
}

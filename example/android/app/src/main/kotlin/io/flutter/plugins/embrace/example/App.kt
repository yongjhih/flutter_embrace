package io.flutter.plugins.embrace.example

import io.embrace.android.embracesdk.Embrace

class App : io.flutter.app.FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        Embrace.getInstance().start(this)
    }
}

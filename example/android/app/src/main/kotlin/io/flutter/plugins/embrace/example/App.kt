package io.flutter.plugins.embrace.example

import io.embrace.android.embracesdk.Embrace
import com.instabug.instabugflutter.InstabugFlutterPlugin
import androidx.multidex.MultiDex
import android.content.Context

class App : io.flutter.app.FlutterApplication() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }

    override fun onCreate() {
        super.onCreate()
        InstabugFlutterPlugin().start(this,
                "5f22ae9a98bd5e8e8e35cde6d0f8bb83",
                arrayListOf(
                        //InstabugFlutterPlugin.INVOCATION_EVENT_NONE,
                        InstabugFlutterPlugin.INVOCATION_EVENT_SCREENSHOT,
                        //InstabugFlutterPlugin.INVOCATION_EVENT_TWO_FINGER_SWIPE_LEFT,
                        //InstabugFlutterPlugin.INVOCATION_EVENT_FLOATING_BUTTON,
                        InstabugFlutterPlugin.INVOCATION_EVENT_SHAKE
                ));
        Embrace.getInstance().start(this)
    }
}

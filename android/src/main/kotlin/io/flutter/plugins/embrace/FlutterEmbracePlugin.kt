package io.flutter.plugins.embrace

import io.embrace.android.embracesdk.Embrace
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterEmbracePlugin(private val registrar: Registrar): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_embrace")
      channel.setMethodCallHandler(FlutterEmbracePlugin(registrar))
    }
  }


  override fun onMethodCall(call: MethodCall, result: Result) {
      when (call.method) {
        "start" -> {
          val enableIntegrationTesting = call.argumentsOrNull<Boolean>()
          enableIntegrationTesting?.let {
            result.complete {
              Embrace.getInstance().start(registrar.activity().application, it)
            }
          } ?:
          result.complete {
            Embrace.getInstance().start(registrar.activity().application)
          }
        }
        /*
        TODO
        Embrace.getInstance().logError("User purchase request failed", props, false)
        Embrace.getInstance().logWarning("User attempted expired credit card", props)
        Embrace.getInstance().logInfo("User has entered checkout flow", props)
        Embrace.getInstance().startEvent("purchase-cart"
          null
          shouldTakeScreenshot,
          props)
        Embrace.getInstance().endEvent("purchase-cart"
            null
            shouldTakeScreenshot,
            props)
        */
        "setUserIdentifier" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().setUserIdentifier(it)
          }
        }
        "setUsername" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().setUsername(it)
          }
        }
        "setUserEmail" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().setUserEmail(it)
          }
        }
        "logInfo" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().logInfo(it)
          }
        }
        "logWarning" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().logWarning(it)
          }
        }
        "logError" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().logError(it)
          }
        }
        "logBreadcrumb" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().logBreadcrumb(it)
          }
        }
        "setUserAsPayer" -> {
          result.complete {
            Embrace.getInstance().setUserAsPayer()
          }
        }
        "clearUserAsPayer" -> {
          result.complete {
            Embrace.getInstance().clearUserAsPayer()
          }
        }
        "clearAllUserPersonas" -> {
          result.complete {
            Embrace.getInstance().clearAllUserPersonas()
          }
        }
        "setUserPersona" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().setUserPersona(it)
          }
        }
        "clearUserPersona" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().clearUserPersona(it)
          }
        }
        // TODO: Embrace.getInstance().endAppStartup(properties)
        "endAppStartup" -> {
          result.complete {
            Embrace.getInstance().endAppStartup()
          }
        }
        "isStarted" -> {
          result.call {
            Embrace.getInstance().isStarted
          }
        }
        "endSession" -> {
          result.complete {
            Embrace.getInstance().endSession()
          }
        }
        "clearUserIdentifier" -> {
          result.complete {
            Embrace.getInstance().clearUserIdentifier()
          }
        }
        else -> {
          result.notImplemented()
        }
      }
  }
}


fun <T> MethodCall.argumentOrNull(key: String): T? = try { argument(key) } catch (e: Throwable) { null }
fun <T> MethodCall.argumentsOrNull(): T? = arguments() as? T?

//fun <T> MethodCall.argument(key: String): T? = try { argument(key) } catch (e: Throwable) { null }
//fun <T> MethodCall.arguments(): T? = arguments() as? T?
//@JvmOverloads
//fun Result.success(result: Any? = null): Unit = success(result)
fun Result.success(): Unit = success(null) // avoid shadow
fun Result.errors(code: String, message: String? = null, details: Any? = null): Unit = error(code, message, details)
fun Result.error(e: Throwable): Unit = errors(e.cause.toString(), e.message, e.stackTrace)

fun Result.complete(onRunnable: () -> Unit) {
  try {
    onRunnable()
    success()
  } catch (e: Throwable) {
    error(e)
  }
}

fun <R> Result.call(onConsumer: () -> R) {
  try {
    success(onConsumer())
  } catch (e: Throwable) {
    error(e)
  }
}

fun <T, R> Result.call(arg: T?, onSuccess: (T) -> R) {
  try {
    success(onSuccess(arg!!))
  } catch (e: Throwable) {
    error(e)
  }
}

fun <T> Result.complete(arg: T?, onComplete: (T) -> Unit) {
  try {
    onComplete(arg!!)
    success()
  } catch (e: Throwable) {
    error(e)
  }
}

fun <T, T2> Result.complete(arg: T?, arg2: T2?, onComplete: (T, T2) -> Unit) {
  try {
    onComplete(arg!!, arg2!!)
    success()
  } catch (e: Throwable) {
    error(e)
  }
}

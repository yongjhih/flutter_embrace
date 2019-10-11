package io.embrace.android.embracesdk

import android.util.Log
import io.embrace.android.embracesdk.network.http.HttpMethod
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
      Log.d(TAG, "registerWith: flutter_embrace")
      channel.setMethodCallHandler(FlutterEmbracePlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
      when (call.method) {
        "start" -> {
          val enableIntegrationTesting = call.argumentsOrNull<Boolean>()
          Log.d(TAG, "start: $enableIntegrationTesting")
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
        // TODO: Embrace.getInstance().startAppStartup(properties)
        "startAppStartup" -> {
          result.complete {
            Embrace.getInstance().startAppStartup()
          }
        }
        "isStarted" -> {
          Log.d(TAG, "isStarted")
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
        "logNetworkCall" -> {
          Log.d(TAG, "logNetworkCall")
          result.complete(
            call.argumentOrNull<String>("url"),
            call.argumentOrNull<String>("method"),
            call.argumentOrNull<Int>("statusCode"),
            call.argumentOrNull<Number>("startTime"),
            call.argumentOrNull<Number>("endTime"),
            call.argumentOrNull<Number>("bytesSent") ?: -1L,
            call.argumentOrNull<Number>("bytesReceived") ?: -1L
          ) { url, method, statusCode, startTime, endTime, bytesSent, bytesReceived ->
            Log.d(TAG, "logNetworkCall: $method $url $statusCode")
            Embrace.getInstance().logNetworkCall(
                    url,
                    HttpMethod.fromString(method),
                    statusCode,
                    startTime.toLong(),
                    endTime.toLong(),
                    bytesSent.toLong(),
                    bytesReceived.toLong()
            )
          }
        }
        "logNetworkError" -> {
          Log.d(TAG, "logNetworkError")
          result.complete(
                  call.argumentOrNull<String>("url"),
                  call.argumentOrNull<String>("method"),
                  call.argumentOrNull<Number>("startTime"),
                  call.argumentOrNull<Number>("endTime"),
                  call.argumentOrNull<String>("errorType"),
                  call.argumentOrNull<String>("errorMessage")
          ) { url, method, startTime, endTime, errorType, errorMessage ->
            Log.d(TAG, "logNetworkClientError: $method $url")
            Embrace.getInstance().logNetworkClientError(
                    url,
                    HttpMethod.fromString(method),
                    startTime.toLong(),
                    endTime.toLong(),
                    errorType,
                    errorMessage
            )
          }
        }
        "logView" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().logView(it)
          }
        }
        "logWebView" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().logWebView(it)
          }
        }
        "forceLogView" -> {
          result.complete(call.argumentsOrNull<String>()) {
            Embrace.getInstance().forceLogView(it)
          }
        }
        // TODO
        // "logTap" -> {
        //   result.complete(call.argumentsOrNull<String>()) {
        //     Embrace.getInstance().forceLogView(it)
        //   }
        // }
        "stop" -> {
          result.complete {
            Embrace.getInstance().stop()
          }
        }
        "crash" -> {
          result.complete(
                  call.argumentOrNull<String>("exception"),
                  call.argumentOrNull<List<Map<String, String>>>("stackTraceElements")
          ) { message, stackTraceElementMaps ->
            Thread {
              throw Exception(message).apply {
                stackTrace = stackTraceElementMaps.mapNotNull { stackTraceElement(it) }.toTypedArray()
              }
            }.run()
          }
        }
        else -> {
          result.notImplemented()
        }
      }
  }
}

fun stackTraceElement(errorElement: Map<String, String>): StackTraceElement? {
  return try {
    val fileName = errorElement["file"]
    val lineNumber = errorElement["line"]
    val className = errorElement["class"]
    val methodName = errorElement["method"]

    StackTraceElement(className ?: "", methodName, fileName, Integer.parseInt(lineNumber ?: "0"))
  } catch (e: Exception) {
    Log.e(FlutterEmbracePlugin::class.java.simpleName, "Unable to generate stack trace element from Dart side error.")
    null
  }
}

val Any.TAG: String
  get() {
    val tag = javaClass.simpleName
    val max = 23
    return if (tag.length <= max) tag else tag.substring(0, max)
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
    Log.e(TAG, e.message, e)
    error(e)
  }
}

fun <R> Result.call(onSuccess: () -> R) {
  try {
    success(onSuccess())
  } catch (e: Throwable) {
    Log.e(TAG, e.message, e)
    error(e)
  }
}

fun <T, R> Result.call(arg: T?, onSuccess: (T) -> R) {
  try {
    Log.d(TAG, "${arg}")
    success(onSuccess(arg!!))
  } catch (e: Throwable) {
    Log.e(TAG, e.message, e)
    error(e)
  }
}

fun <T> Result.complete(arg: T?, onComplete: (T) -> Unit) {
  try {
    Log.d(TAG, "${arg}")
    onComplete(arg!!)
    success()
  } catch (e: Throwable) {
    Log.e(TAG, e.message, e)
    error(e)
  }
}

fun <T, T2> Result.complete(arg: T?, arg2: T2?, onComplete: (T, T2) -> Unit) {
  try {
    Log.d(TAG, "${arg}")
    onComplete(arg!!, arg2!!)
    success()
  } catch (e: Throwable) {
    Log.e(TAG, e.message, e)
    error(e)
  }
}

fun <T, T2, T3, T4, T5, T6> Result.complete(arg: T?,
                                            arg2: T2?,
                                            arg3: T3?,
                                            arg4: T4?,
                                            arg5: T5?,
                                            arg6: T6?,
                                            onComplete: (T, T2, T3, T4, T5, T6) -> Unit) {
  try {
    Log.d(TAG, "${arg}")
    onComplete(arg!!, arg2!!, arg3!!, arg4!!, arg5!!, arg6!!)
    success()
  } catch (e: Throwable) {
    Log.e(TAG, e.message, e)
    error(e)
  }
}
fun <T, T2, T3, T4, T5, T6, T7> Result.complete(arg: T?,
                            arg2: T2?,
                            arg3: T3?,
                            arg4: T4?,
                            arg5: T5?,
                            arg6: T6?,
                            arg7: T7?,
                            onComplete: (T, T2, T3, T4, T5, T6, T7) -> Unit) {
  try {
    Log.d(TAG, "${arg}")
    onComplete(arg!!, arg2!!, arg3!!, arg4!!, arg5!!, arg6!!, arg7!!)
    success()
  } catch (e: Throwable) {
    Log.e(TAG, e.message, e)
    error(e)
  }
}

// hidden
fun Embrace.startAppStartup() {
  startEvent(EmbraceEventService.STARTUP_EVENT_NAME)
}

package io.embrace.android.embracesdk

import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import io.embrace.android.embracesdk.network.http.HttpMethod
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterEmbracePlugin(): FlutterPlugin, MethodCallHandler {
  private var registrar: Registrar? = null
  var channel: MethodChannel? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Log.d(TAG, "onAttachedToEngine: attaching flutter_embrace")
    channel = MethodChannel(binding.getBinaryMessenger(), "flutter_embrace")
    channel?.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel?.setMethodCallHandler(null)
    channel = null
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "start" -> {
        val enableIntegrationTesting = call.argumentsOrNull<Boolean>()
        Log.d(TAG, "start: $enableIntegrationTesting")
        enableIntegrationTesting?.let {
          result.complete {
            Embrace.getInstance().start(registrar?.activity()?.application?.applicationContext!!, it, Embrace.AppFramework.REACT_NATIVE)
          }
        } ?:
        result.complete {
          Embrace.getInstance().start(registrar?.activity()?.application?.applicationContext!!, false, Embrace.AppFramework.REACT_NATIVE)
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
          call.argumentOrNull<List<Map<String, String>>>("stackTraceElements") ?: listOf(mapOf<String, String>())
        ) { message, stackTraceElementMaps ->
          Thread {

            for(mapListed in map){
              newMap.putAll(mapListed)
            }

            var listOfElements = mutableListOf<StackTraceElement>()
            for(element in stackTraceElementMaps){
              val newElement = stackTraceElement(element)
              listOfElements.add(newElement)
            }

            val throwable = Throwable()
            throwable.stackTrace = listOfElements.toTypedArray()

            // The below doesn't work as expected with embrace-io:embrace-android-sdk:4.5.0
//            Embrace.getInstance().logError("Log 1: "+message, null, false, stackTraceElementMaps.toString())
//            Embrace.getInstance().logError("Log 2: "+message, newMap as Map<String, String>)
//            Embrace.getInstance().logError(throwable, "Log 3: "+message, null, false)
//            Embrace.getInstance().logError(throwable, "Log 4: "+message, newMap as Map<String, String>, false)
//            Embrace.getInstance().logWarning("Log 5: "+message, newMap as Map<String, String>)
//            Embrace.getInstance().logError("Log 6: "+message, null, false, stackTraceElementMaps.toString(), true)

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

fun stackTraceElement(errorElement: Map<String, String>): StackTraceElement {
  return try {

    val fileName: String? = errorElement["file"]
    val lineNumber: String? = errorElement["line"]
    val className: String? = errorElement["class"]
    val methodName: String? = errorElement["method"]

    StackTraceElement(className ?: "", methodName, fileName, lineNumber?.toIntOrNull() ?: 0)
  } catch (e: Exception) {
    Log.e(FlutterEmbracePlugin::class.java.simpleName, "Unable to generate stack trace element from Dart side error.")
//    null
    StackTraceElement("", "", "", 0)
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

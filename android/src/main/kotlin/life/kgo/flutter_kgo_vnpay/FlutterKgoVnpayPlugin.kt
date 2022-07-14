package life.kgo.flutter_kgo_vnpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.util.Log
import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity

import com.vnpay.authentication.VNP_AuthenticationActivity;
import com.vnpay.authentication.VNP_SdkCompletedCallback;
import io.flutter.embedding.android.FlutterActivity


import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.lang.ref.WeakReference

/** FlutterKgoVnpayPlugin */
class FlutterKgoVnpayPlugin: FlutterPlugin, ActivityAware, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  protected val activity get() = activityReference.get()
  protected val applicationContext get() =
    contextReference.get() ?: activity?.applicationContext

  private var activityReference = WeakReference<Activity>(null)
  private var contextReference = WeakReference<Context>(null)

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    this.flutterPluginBinding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_kgo_vnpay")
    channel.setMethodCallHandler(this)
    contextReference = WeakReference(flutterPluginBinding.applicationContext)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "show") {
        this.handleShow(call)
        result.success(null)
    } else {
      result.notImplemented()
    }
  }
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activityReference = WeakReference(binding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activityReference.clear()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activityReference = WeakReference(binding.activity)
  }

  override fun onDetachedFromActivity() {
    activityReference.clear()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun handleShow(@NonNull call: MethodCall) {
      val params = call.arguments as HashMap<*, *>
      val paymentUrl = params["paymentUrl"] as String
      val scheme = params["scheme"] as String
      val tmnCode = params["tmn_code"] as String
      val intent = Intent(applicationContext, VNP_AuthenticationActivity::class.java).apply {
        putExtra("url", paymentUrl)
        putExtra("scheme", scheme)
        putExtra("tmn_code", tmnCode)
      }
      VNP_AuthenticationActivity.setSdkCompletedCallback { action ->
        Log.wtf("VNP_AuthenticationActivity", "action: $action")
        if (action == "AppBackAction") {
          channel.invokeMethod("PaymentBack", hashMapOf("resultCode" to -1))
        }
        if (action == "CallMobileBankingApp") {
          channel.invokeMethod("PaymentBack", hashMapOf("resultCode" to 10))
        }
        if (action == "WebBackAction") {
          channel.invokeMethod("PaymentBack", hashMapOf("resultCode" to 24))
        }
        if (action == "FaildBackAction") {
          channel.invokeMethod("PaymentBack", hashMapOf("resultCode" to 99))
        }
        if (action == "FailBackAction") {
          channel.invokeMethod("PaymentBack", hashMapOf("resultCode" to 99))
        }
        if (action == "SuccessBackAction") {
          channel.invokeMethod("PaymentBack", hashMapOf("resultCode" to 0))
        }

        //action == AppBackAction
        //Người dùng nhấn back từ sdk để quay lại

        //action == CallMobileBankingApp
        //Người dùng nhấn chọn thanh toán qua app thanh toán (Mobile Banking, Ví...)
        //lúc này app tích hợp sẽ cần lưu lại mã giao dịch thanh toán (vnp_TxnRef). Khi người dùng mở lại app tích hợp với cheme thì sẽ gọi kiểm tra trạng thái thanh toán của mã TxnRef đó kiểm tra xem đã thanh toán hay chưa để thực hiện nghiệp vụ kết thúc thanh toán / thông báo kết quả cho khách hàng..

        //action == WebBackAction
        //Tạo nút sự kiện cho user click từ return url của merchant chuyển hướng về URL: http://cancel.sdk.merchantbackapp
        // vnp_ResponseCode == 24 / Khách hàng hủy thanh toán.

        //action == FaildBackAction
        //Tạo nút sự kiện cho user click từ return url của merchant chuyển hướng về URL: http://fail.sdk.merchantbackapp
        // vnp_ResponseCode != 00 / Giao dịch thanh toán không thành công

        //action == SuccessBackAction
        //Tạo nút sự kiện cho user click từ return url của merchant chuyển hướng về URL: http://success.sdk.merchantbackapp
        //vnp_ResponseCode == 00) / Giao dịch thành công
      }
      activity?.startActivity(intent)
//        activityBinding?.activity?.startActivityForResult(intent, 99)
    }
}

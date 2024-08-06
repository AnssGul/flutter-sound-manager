// package com.example.soundapp

// import android.app.NotificationManager
// import android.content.Context
// import android.content.Intent
// import android.media.AudioManager
// import android.os.Build
// import android.os.Bundle
// import androidx.annotation.NonNull
// import androidx.annotation.RequiresApi
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel

// class MainActivity : FlutterActivity() {
//     private val CHANNEL = "com.example.soundapp/sound"
//     private val REQUEST_CODE = 100

//     override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//         super.configureFlutterEngine(flutterEngine)
//         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//             if (call.method == "setSoundMode") {
//                 val mode = call.arguments<String>()
//                 if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                     val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
//                     if (!notificationManager.isNotificationPolicyAccessGranted) {
//                         requestDndPermission()
//                         result.error("PERMISSION_DENIED", "Do Not Disturb permission not granted", null)
//                         return@setMethodCallHandler
//                     }
//                 }
//                 setSoundMode(mode)
//                 result.success(null)
//             } else {
//                 result.notImplemented()
//             }
//         }
//     }

//     @RequiresApi(Build.VERSION_CODES.M)
//     private fun requestDndPermission() {
//         val intent = Intent(android.provider.Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS)
//         startActivityForResult(intent, REQUEST_CODE)
//     }

//     private fun setSoundMode(mode: String?) {
//         val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
//         val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

//         when (mode) {
//             "unmute" -> {
//                 if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                     notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALL)
//                 }
//                 audioManager.ringerMode = AudioManager.RINGER_MODE_NORMAL
//             }
//             "vibrate" -> {
//                 if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                     notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_PRIORITY)
//                 }
//                 audioManager.ringerMode = AudioManager.RINGER_MODE_VIBRATE
//             }
//             "mute" -> {
//                 if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                     notificationManager.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_NONE)
//                     audioManager.ringerMode = AudioManager.RINGER_MODE_SILENT
//                 } else {
//                     audioManager.ringerMode = AudioManager.RINGER_MODE_SILENT
//                     audioManager.setStreamMute(AudioManager.STREAM_NOTIFICATION, true)
//                     audioManager.setStreamMute(AudioManager.STREAM_ALARM, true)
//                     audioManager.setStreamMute(AudioManager.STREAM_MUSIC, true)
//                     audioManager.setStreamMute(AudioManager.STREAM_RING, true)
//                     audioManager.setStreamMute(AudioManager.STREAM_SYSTEM, true)
//                 }
//             }
//         }
//     }
// }
package com.example.soundapp

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.soundapp/sound"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "toggleMute") {
                try {
                    toggleMute()
                    result.success("Mute toggled")
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "Unable to toggle mute: ${e.localizedMessage}", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun toggleMute() {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val currentRingerMode = audioManager.ringerMode
        println("Current ringer mode: $currentRingerMode")
        when (currentRingerMode) {
            AudioManager.RINGER_MODE_SILENT -> {
                audioManager.ringerMode = AudioManager.RINGER_MODE_NORMAL
                println("Switched to NORMAL mode")
            }
            AudioManager.RINGER_MODE_NORMAL -> {
                audioManager.ringerMode = AudioManager.RINGER_MODE_SILENT
                println("Switched to SILENT mode")
            }
        }
    }
}



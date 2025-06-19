package com.example.cardinal

import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import java.net.URL

class MainActivity : FlutterActivity() {

    private val WALLPAPER_CHANNEL = "com.cardinal.wallpaper"
    private val AUDIO_CHANNEL = "com.cardinal.audio"
    private val ALARM_CHANNEL = "alarm.settings"

    private var audioServiceIntent: Intent? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        FlutterEngineCache.getInstance().put("main_engine", flutterEngine)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "audio_channel",
                "Audio Playback",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WALLPAPER_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setWallpaper") {
                val url = call.argument<String>("url")
                val target = call.argument<String>("target")

                Thread {
                    try {
                        val inputStream = URL(url).openStream()
                        val bitmap = BitmapFactory.decodeStream(inputStream)
                        val manager = WallpaperManager.getInstance(applicationContext)

                        when (target) {
                            "home" -> manager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
                            "lock" -> manager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                            "both" -> {
                                manager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
                                manager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                            }
                            else -> manager.setBitmap(bitmap)
                        }

                        runOnUiThread { result.success("Wallpaper set for $target screen") }
                    } catch (e: Exception) {
                        runOnUiThread { result.error("ERROR", "Failed to set wallpaper", e.toString()) }
                    }
                }.start()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, AUDIO_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startForeground" -> {
                    val title = call.argument<String>("title")
                    val url = call.argument<String>("url")
                    audioServiceIntent = Intent(this, AudioService::class.java).apply {
                        putExtra("title", title)
                        putExtra("url", url)
                    }
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        startForegroundService(audioServiceIntent)
                    } else {
                        startService(audioServiceIntent)
                    }
                    result.success(null)
                }

                "stopForeground" -> {
                    audioServiceIntent?.let { stopService(it) }
                    result.success(null)
                }

                "updateNotification" -> {
                    val title = call.argument<String>("title") ?: "Sleep Sound"
                    val isPlaying = call.argument<Boolean>("isPlaying") ?: false

                    val updateIntent = Intent(this, AudioService::class.java).apply {
                        action = "ACTION_UPDATE"
                        putExtra("title", title)
                        putExtra("isPlaying", isPlaying)
                    }

                    startService(updateIntent)
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ALARM_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openExactAlarmSettings" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        val intent = Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM)
                        startActivity(intent)
                        result.success(null)
                    } else {
                        result.error("UNSUPPORTED", "Not supported on this Android version", null)
                    }
                }

                "checkExactAlarmPermission" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
                        result.success(alarmManager.canScheduleExactAlarms())
                    } else {
                        result.success(true)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}

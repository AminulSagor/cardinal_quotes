package com.example.cardinal


import android.app.*
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import androidx.media.app.NotificationCompat.MediaStyle // ✅ Requires dependency
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel


class AudioService : Service() {

    private val CHANNEL_ID = "audio_channel"
    private val NOTIFICATION_ID = 1

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val title = intent?.getStringExtra("title") ?: "Playing Audio"
        val action = intent?.action

        createNotificationChannel()

        when (action) {
            "ACTION_TOGGLE" -> sendToFlutter("toggle")
            "ACTION_UPDATE" -> {
                val isPlaying = intent.getBooleanExtra("isPlaying", false)
                val notification = buildNotification(title, isPlaying)
                val manager = getSystemService(NotificationManager::class.java)
                manager.notify(NOTIFICATION_ID, notification)
            }
            else -> {
                val notification = buildNotification(title, true)
                startForeground(NOTIFICATION_ID, notification)
            }
        }

        return START_STICKY
    }


    private fun buildNotification(title: String, isPlaying: Boolean): Notification {
        val openAppIntent = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        val toggleIntent = PendingIntent.getService(
            this,
            1,
            Intent(this, AudioService::class.java).setAction("ACTION_TOGGLE"),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        val icon = if (isPlaying) android.R.drawable.ic_media_pause else android.R.drawable.ic_media_play
        val label = if (isPlaying) "Pause" else "Play"

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(title)
            .setContentText("Playing in background")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(openAppIntent)
            .addAction(icon, label, toggleIntent)
            .setStyle(MediaStyle().setShowActionsInCompactView(0))
            .setOngoing(true)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .build()
    }


    private fun sendToFlutter(method: String) {
        val engine = FlutterEngineCache
            .getInstance()
            .get("main_engine") ?: return

        MethodChannel(engine.dartExecutor.binaryMessenger, "com.cardinal.audio")
            .invokeMethod(method, null)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Audio Playback",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Background audio playback"
            }

            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    override fun onDestroy() {
        stopForeground(true)
        super.onDestroy()
    }
}

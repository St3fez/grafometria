package com.grafometria.grafometria

import android.content.ClipData
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val directShareChannel = "com.grafometria.grafometria/direct_share"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, directShareChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "shareToPackage" -> {
                        val packageName = call.argument<String>("packageName")
                        val text = call.argument<String>("text")
                        val imagePath = call.argument<String>("imagePath")
                        val mimeType = call.argument<String>("mimeType") ?: "image/jpeg"
                        val includeTextWithImage =
                            call.argument<Boolean>("includeTextWithImage") ?: true

                        if (packageName.isNullOrBlank()) {
                            result.success(false)
                            return@setMethodCallHandler
                        }
                        result.success(
                            shareToPackage(
                                packageName = packageName,
                                text = text,
                                imagePath = imagePath,
                                mimeType = mimeType,
                                includeTextWithImage = includeTextWithImage,
                            ),
                        )
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun shareToPackage(
        packageName: String,
        text: String?,
        imagePath: String?,
        mimeType: String,
        includeTextWithImage: Boolean,
    ): Boolean {
        if (!isPackageVisibleAndInstalled(packageName)) {
            return false
        }

        val intent = Intent(Intent.ACTION_SEND).apply {
            `package` = packageName
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        val hasImage = !imagePath.isNullOrBlank() && File(imagePath).exists()
        if (hasImage) {
            val file = File(imagePath!!)
            val authority = "${applicationContext.packageName}.sharefileprovider"
            val uri = try {
                FileProvider.getUriForFile(this, authority, file)
            } catch (_: Throwable) {
                return false
            }
            intent.type = if (mimeType.startsWith("image/")) "image/*" else mimeType
            intent.putExtra(Intent.EXTRA_STREAM, uri)
            intent.clipData = ClipData.newUri(contentResolver, "shared_image", uri)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            grantUriPermission(packageName, uri, Intent.FLAG_GRANT_READ_URI_PERMISSION)
            if (includeTextWithImage && !text.isNullOrBlank()) {
                intent.putExtra(Intent.EXTRA_TEXT, text)
            }
        } else {
            intent.type = "text/plain"
            if (!text.isNullOrBlank()) {
                intent.putExtra(Intent.EXTRA_TEXT, text)
            }
        }

        val canResolve = intent.resolveActivity(packageManager) != null
        if (!canResolve) {
            return false
        }

        return try {
            startActivity(intent)
            true
        } catch (_: Throwable) {
            false
        }
    }

    private fun isPackageVisibleAndInstalled(packageName: String): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES)
            true
        } catch (_: Throwable) {
            false
        }
    }
}

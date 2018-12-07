package com.annatarhe.clippingkk

import android.Manifest
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.provider.MediaStore

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import android.content.Context


class MainActivity : FlutterActivity() {

    companion object {
        val SAVE_IMAGE_CHANNEL = "com.annatarhe.clippingkk/channel";
    }

    private fun saveImage(bytes: ByteArray): Boolean {
        this.checkPermission()
        val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
        MediaStore.Images.Media.insertImage(contentResolver, bitmap, "title", "description")
        return true
    }

    private fun checkPermission() {
        val hasWriteContactsPermission = checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE);
        if (hasWriteContactsPermission != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE), 1);
            return;
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        val that = this

        MethodChannel(flutterView, SAVE_IMAGE_CHANNEL).setMethodCallHandler(
            MethodChannel.MethodCallHandler { methodCall, result ->
                if (methodCall.method == "saveImage") {
                    val bytes = methodCall.argument<ByteArray>("image")
                    val methodRtn = that.saveImage(bytes!!)
                    result.success(methodRtn)
                    return@MethodCallHandler
                }

                result.notImplemented()
                return@MethodCallHandler
            }
        )
    }
}

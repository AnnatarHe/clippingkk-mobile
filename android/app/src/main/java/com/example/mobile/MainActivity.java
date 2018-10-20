package com.example.mobile;
import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.provider.MediaStore;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
  private static final String SAVE_IMAGE_CHANNEL = "com.annatarhe.clippingkk/channel";

  private boolean saveImage(byte[] bytes) {
      this.checkPermission();
      Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
      MediaStore.Images.Media.insertImage(getContentResolver(), bitmap, "title", "description");
      return true;
  }

  private void checkPermission() {
      int hasWriteContactsPermission = checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE);
      if (hasWriteContactsPermission != PackageManager.PERMISSION_GRANTED) {
          requestPermissions(new String[] {Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1);
          return;
      }
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    final Context that = this;

    new MethodChannel(getFlutterView(), SAVE_IMAGE_CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("saveImage")) {
                    byte[] bytes = methodCall.argument("image");
                    boolean methodRtn = ((MainActivity) that).saveImage(bytes);
                    result.success(methodRtn);
                    return;
                }

                result.notImplemented();
                return;
              }
            }
    );
  }
}

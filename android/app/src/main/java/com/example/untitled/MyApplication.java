package com.example.flutter_ct;

import io.flutter.app.FlutterApplication;

import com.clevertap.android.sdk.ActivityLifecycleCallback;
import com.clevertap.android.sdk.CleverTapAPI;

//import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {
    @java.lang.Override
    public void onCreate() {
        CleverTapAPI.setDebugLevel(3);
        //CleverTapAPI.setUIEditorConnectionEnabled(true);
        ActivityLifecycleCallback.register(this);
        super.onCreate();
    }
}
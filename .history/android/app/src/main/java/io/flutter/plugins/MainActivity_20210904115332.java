
Skip to content
Sign up
letsdoit07 /
background_service

33

    24

Code
Issues 4
Pull requests
Actions
Projects
Wiki
Security

More
background_service/background_service/android/app/src/main/java/com/retroportalstudio/www/background_service/MainActivity.java /
@letsdoit07
letsdoit07 Initial Commit
Latest commit 424f2b5 on 22 Sep 2019
History
1 contributor
52 lines (39 sloc) 1.29 KB
package com.retroportalstudio.www.background_service;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private Intent forService;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    forService = new Intent(MainActivity.this,MyService.class);

    new MethodChannel(getFlutterView(),"com.retroportalstudio.messages")
            .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if(methodCall.method.equals("startService")){
          startService();
          result.success("Service Started");
        }
      }
    });


  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    stopService(forService);
  }

  private void startService(){
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
      startForegroundService(forService);
    } else {
      startService(forService);
    }
  }



}

    © 2021 GitHub, Inc.
    Terms
    Privacy
    Security
    Status
    Docs

    Contact GitHub
    Pricing
    API
    Training
    Blog
    About

Loading complete
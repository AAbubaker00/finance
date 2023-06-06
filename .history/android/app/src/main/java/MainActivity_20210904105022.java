package com.example.flutter_broadcastreceiver_alarmmanager_repeat;
  import android.content.BroadcastReceiver;
  import android.content.Context;
  import android.content.Intent;
  public class MyReceiver extends BroadcastReceiver {
      @Override
      public void onReceive(Context context, Intent intent) {
          MainActivity.callFlutter();
      }
  }
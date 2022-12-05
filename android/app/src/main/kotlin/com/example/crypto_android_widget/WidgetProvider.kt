package com.example.crypto_android_widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import com.example.crypto_android_widget.MainActivity
import com.example.crypto_android_widget.R
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                // Otvaranje aplikacije klikom na widget
                val pendingIntent =
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val crypto = widgetData.getString("_cryptoSymbol", null)
                val cryptoValue = widgetData.getString("_cryptoValue", null)

                if (cryptoValue == null && crypto == null) {
                    setTextViewText(R.id.tv_cryptoText, "Kriptovaluta nije odabrana!")
                    setTextViewText(R.id.tv_cryptoValue, "Klik za odabir!")
                } else {
                    setTextViewText(R.id.tv_cryptoText, "Vrijednost $crypto u USD je:")
                    if(cryptoValue==null) setTextViewText(R.id.tv_cryptoValue, "loading...")
                    else {
                        setTextViewText(R.id.tv_cryptoValue, "$cryptoValue")
                    }
                }

                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("myAppWidget://updatecryptovalue")
                )

                backgroundIntent.send();
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
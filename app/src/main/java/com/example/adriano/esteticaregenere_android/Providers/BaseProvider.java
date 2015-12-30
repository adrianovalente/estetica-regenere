package com.example.adriano.esteticaregenere_android.Providers;

/**
 * Created by Adriano on 12/29/15.
 */

import com.loopj.android.http.*;
import org.json.*;

import java.util.ArrayList;

import cz.msebera.android.httpclient.Header;

public class BaseProvider {
    public BaseProvider() {

    }

    public void getPath(String path, final HomeProviderCallback callback) {
        AsyncHttpClient client = new AsyncHttpClient();
        client.get(path, new JsonHttpResponseHandler() {
            @Override
            public void onSuccess(int statusCode, Header[] headers, JSONObject response) {
                System.out.println("Deu bom mlk");
                ArrayList<String> options = new ArrayList<String>();
                try {
                    int success = response.getInt("isSuccess");
                    JSONArray areas = response.getJSONObject("content").getJSONArray("areas");
                    for (int i=0; i<areas.length(); i++) {
                        JSONObject area = (JSONObject)areas.get(i);
                        String name = area.getString("name");
                        options.add(name);
                    }
                    callback.onGetAreasSuccess(options);

                } catch (JSONException e) {
                    e.printStackTrace();
                    callback.onGetAreasFailure();
                }
                super.onSuccess(statusCode, headers, response);
            }

            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                super.onFailure(statusCode, headers, responseString, throwable);
            }
        });
    }

}

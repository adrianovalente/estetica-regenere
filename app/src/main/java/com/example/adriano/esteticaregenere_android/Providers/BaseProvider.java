package com.example.adriano.esteticaregenere_android.Providers;

/**
 * Created by Adriano on 12/29/15.
 */

import android.content.Context;

import com.loopj.android.http.*;
import org.json.*;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Map;

import cz.msebera.android.httpclient.Header;
import cz.msebera.android.httpclient.entity.StringEntity;

public class BaseProvider {

    String host;
    JsonHttpResponseHandler handler;
    BaseProviderCallback callback;
    AsyncHttpClient client;

    public BaseProvider() {
        host = "http://obscure-temple-3846.herokuapp.com/";
        //host = "http://127.0.0.1:8000/";
        handler = new JsonHttpResponseHandler() {
            @Override
            public void onSuccess(int statusCode, Header[] headers, JSONObject response) {
                System.out.println("Request was successful, now let' scan it.");
                try {
                    if (response.getInt("isSuccess") == 1) {
                        handleSuccessfulResponse(response);
                    } else {
                        handleFailedResponse(response, statusCode);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                    callback.onResponseFailure();
                }

            }

            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                if (responseString != null) callback.onResponseFailure();
                else callback.onNetworkFailure();
            }
        };
    }

    AsyncHttpClient getSharedClient() {
        if (this.client == null) {
            this.client = new AsyncHttpClient();
        }
        return this.client;
    }

    // Should be overwritten
    void handleSuccessfulResponse(JSONObject response) {
        System.out.println("Success!");
    }

    // Should be overwritten
    void handleFailedResponse(JSONObject response, int statusCode) {
        System.out.println("Failure");
    }

    public void get(String path, RequestParams params, final BaseProviderCallback callback) {
        this.callback = callback;
        getSharedClient().get(host + path, params, handler);

    }

    public void post(Context context, String path, JSONObject body, final BaseProviderCallback callback) {
        this.callback = callback;
        try {
            StringEntity entity = new StringEntity(body.toString());
            getSharedClient().post(context, host+path, entity, "application/json", handler);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }

    //TODO: Remove this method once it's not used anymore
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
                    for (int i = 0; i < areas.length(); i++) {
                        JSONObject area = (JSONObject) areas.get(i);
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

package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import com.loopj.android.http.RequestParams;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by Adriano on 12/31/15.
 */
public class LoginProvider extends BaseProvider {

    public LoginProvider() {}

    public void performLogin(Context context, String login, String password, LoginProviderCallback callback) {
        JSONObject body = new JSONObject();
        try {
            body.put("email", login);
            body.put("password", password);
            post(context, "login/", body, callback);
        } catch (JSONException e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }

    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        try {
            ((LoginProviderCallback)callback).onLoginSuccess(response.getJSONObject("content").getString("token"));
        } catch (JSONException e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }

    @Override
    void handleFailedResponse(JSONObject response, int statusCode) {
        ((LoginProviderCallback)callback).onLoginFailure();
    }
}

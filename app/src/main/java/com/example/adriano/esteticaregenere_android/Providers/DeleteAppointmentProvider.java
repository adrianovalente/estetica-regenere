package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import com.loopj.android.http.RequestParams;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by Adriano on 1/29/16.
 */
public class DeleteAppointmentProvider extends BaseProvider {

    public DeleteAppointmentProvider() {}

    public void deleteAppointment(Context context, int id, DeleteAppointmentProviderCallback callback) {
        this.callback = callback;
        getAuthenticated(context, "/delete_appointment/" + Integer.toString(id), new RequestParams(), callback);
    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        super.handleSuccessfulResponse(response);
        ((DeleteAppointmentProviderCallback)callback).onDeleteAppointmentSuccess();

    }

    @Override
    void handleFailedResponse(JSONObject response, int statusCode) {
        super.handleFailedResponse(response, statusCode);
        try {
            if (response.getJSONObject("content").getString("error").equals("AUTH_FAILED")) {
                ((DeleteAppointmentProviderCallback)callback).onAuthFailed();
            } else {
                ((DeleteAppointmentProviderCallback)callback).onDeleteAppointmentFailure();
            }
        } catch (JSONException e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }
}

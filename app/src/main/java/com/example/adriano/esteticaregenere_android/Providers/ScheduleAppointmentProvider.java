package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import org.json.JSONObject;

/**
 * Created by Adriano on 2/7/16.
 */
public class ScheduleAppointmentProvider extends BaseProvider {
    public void scheduleAppointment(Context context, String serviceId, String timeToSchedule, ScheduleAppointmentProviderCallback callback) {
        this.callback = callback;
        JSONObject body = new JSONObject();
        try {
            body.put("service", serviceId);
            body.put("time", timeToSchedule);
            postAuthenticated(context, "/schedule/", body, callback);
        } catch (Exception e) {
            callback.onResponseFailure();
        }
    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        super.handleSuccessfulResponse(response);
        try {
            if(response.getInt("isSuccess") == 1) ((ScheduleAppointmentProviderCallback)callback).onScheduleAppointmentSuccess();
            else ((ScheduleAppointmentProviderCallback)callback).onScheduleAppointmentFailure();
        } catch (Exception e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }

    @Override
    void handleFailedResponse(JSONObject response, int statusCode) {
        super.handleFailedResponse(response, statusCode);
        try {
            if (response.getJSONObject("content").getString("error").equals("AUTH_FAILED")) {
                ((ScheduleAppointmentProviderCallback)callback).onScheduleAppointmentAuthFailed();
            } else {
                ((ScheduleAppointmentProviderCallback)callback).onScheduleAppointmentFailure();
            }
        } catch (Exception e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }
}

package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import com.example.adriano.esteticaregenere_android.Models.Appointment;
import com.example.adriano.esteticaregenere_android.Models.*;
import com.loopj.android.http.RequestParams;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by Adriano on 1/12/16.
 */
public class HomeProvider extends BaseProvider {

    public HomeProvider() {

    }

    public void getHomeInfo(Context context, HomeProviderCallback callback) {
        this.callback = callback;
        getAuthenticated(context, "/home", (new RequestParams()), callback);

    }

    @Override
    void handleFailedResponse(JSONObject response, int statusCode) {
        super.handleFailedResponse(response, statusCode);
        try {
            if (response.getJSONObject("content").getString("error").equals("AUTH_FAILED")) {
                ((HomeProviderCallback)callback).onAuthFailure();
            } else {
                ((HomeProviderCallback)callback).onFailure();
            }
        } catch (JSONException e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        super.handleSuccessfulResponse(response);
        try {
            JSONArray consultas = response.getJSONObject("content").getJSONArray("consultas");
            ArrayList<Appointment> appointments = new ArrayList<Appointment>();
            for(int i=0; i<consultas.length(); i++) {
                JSONObject appointment = ((JSONObject)consultas.get(i));
                JSONObject date = appointment.getJSONObject("date");
                AppointmentDate appointmentDate = new AppointmentDate(date.getInt("year"), date.getInt("month"), date.getInt("day"), date.getInt("hour"), date.getInt("minute"));
                appointments.add(new Appointment(appointment.getInt("consultaId"), appointmentDate, appointment.getString("esteticista"), appointment.getString("service")));
            }
            ((HomeProviderCallback)callback).onSuccess(appointments, response.getJSONObject("content").getString("name"));
        } catch (JSONException e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }
}

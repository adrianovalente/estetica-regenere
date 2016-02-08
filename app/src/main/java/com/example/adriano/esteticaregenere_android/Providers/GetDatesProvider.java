package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import com.example.adriano.esteticaregenere_android.Models.AppointmentOption;
import com.loopj.android.http.RequestParams;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by Adriano on 2/7/16.
 */
public class GetDatesProvider extends BaseProvider {

    public void getDates(Context context, String service, GetDatesProviderCallback callback) {
        this.callback = callback;
        getAuthenticated(context, "/times/" + service, new RequestParams(), callback);
    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        super.handleSuccessfulResponse(response);
        try {
            ArrayList<AppointmentOption> options = new ArrayList<AppointmentOption>();
            JSONArray optionsArr = response.getJSONObject("contents").getJSONArray("dates");
            for(int i=0; i<optionsArr.length(); i++) {
                AppointmentOption option = new AppointmentOption();
                option.date = ((JSONObject)optionsArr.get(i)).getString("date");
                JSONArray timesArr = ((JSONObject)optionsArr.get(i)).getJSONArray("times");
                ArrayList<String> times = new ArrayList<String>();
                for(int j=0; j<timesArr.length(); j++) {
                    times.add((String)timesArr.get(j));
                }
                option.times = times;
                options.add(option);
            }
            ((GetDatesProviderCallback)this.callback).onGetDatesSuccess(options);
        } catch(Exception e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }

    @Override
    void handleFailedResponse(JSONObject response, int statusCode) {
        super.handleFailedResponse(response, statusCode);
        try {
            if (response.getJSONObject("content").getString("error").equals("AUTH_FAILED")) {
                ((GetDatesProviderCallback)callback).onGetDatesAuthFailed();
            } else {
                ((GetDatesProviderCallback)callback).onGetDatesFailure();
            }
        } catch (Exception e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }
}

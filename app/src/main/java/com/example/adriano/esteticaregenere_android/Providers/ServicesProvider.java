package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import com.example.adriano.esteticaregenere_android.Models.Service;
import com.loopj.android.http.RequestParams;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by Adriano on 2/7/16.
 */
public class ServicesProvider extends BaseProvider {

    public void getServices(Context context, String area, ServicesProviderCallback callback) {
        this.callback = callback;
        getAuthenticated(context, "/services/" + area, new RequestParams(), callback);
    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        super.handleSuccessfulResponse(response);
        try {
            JSONArray services = response.getJSONObject("content").getJSONArray("services");
            ArrayList<Service> servicesArray = new ArrayList<Service>();
            for(int i=0; i<services.length(); i++) {
                Service service = new Service();
                service.name = ((JSONObject)services.get(i)).getString("name");
                service.id = ((JSONObject)services.get(i)).getString("id");
                servicesArray.add(service);
            }
            ((ServicesProviderCallback)this.callback).onGetServicesSuccess(servicesArray);
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
                ((ServicesProviderCallback)callback).onGetServicesAuthFailed();
            } else {
                ((ServicesProviderCallback)callback).onGetServicesFailure();
            }
        } catch (Exception e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }
}

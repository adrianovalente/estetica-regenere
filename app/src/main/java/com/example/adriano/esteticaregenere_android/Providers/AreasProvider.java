package com.example.adriano.esteticaregenere_android.Providers;

import android.content.Context;

import com.example.adriano.esteticaregenere_android.Models.Area;
import com.loopj.android.http.RequestParams;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by Adriano on 2/6/16.
 */
public class AreasProvider extends BaseProvider{
    public AreasProvider() {}

    public void getAreas(Context context, AreasProviderCallback callback) {
        this.callback = callback;
        getAuthenticated(context, "/areas", new RequestParams(), callback);
    }

    @Override
    void handleSuccessfulResponse(JSONObject response) {
        super.handleSuccessfulResponse(response);
        try {
            JSONObject content = response.getJSONObject("content");
            JSONArray areas = content.getJSONArray("areas");
            ArrayList<Area> areasArray = new ArrayList<Area>();
            for(int i=0; i<areas.length(); i++) {
                Area area = new Area();
                area.id = ((JSONObject)areas.get(i)).getString("id");
                area.name = ((JSONObject)areas.get(i)).getString("name");
                areasArray.add(area);
            }
            ((AreasProviderCallback)this.callback).onGetAreasSuccess(areasArray);
        } catch(Exception e) {
            callback.onResponseFailure();
        }
    }

    @Override
    void handleFailedResponse(JSONObject response, int statusCode) {
        super.handleFailedResponse(response, statusCode);
        try {
            if (response.getJSONObject("content").getString("error").equals("AUTH_FAILED")) {
                ((AreasProviderCallback)callback).onGetAreasAuthFailure();
            } else {
                ((AreasProviderCallback)callback).onGetAreasFailure();
            }
        } catch (Exception e) {
            e.printStackTrace();
            callback.onResponseFailure();
        }
    }
}

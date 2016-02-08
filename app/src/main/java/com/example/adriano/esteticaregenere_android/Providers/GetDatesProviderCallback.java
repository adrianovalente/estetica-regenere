package com.example.adriano.esteticaregenere_android.Providers;

import com.example.adriano.esteticaregenere_android.Models.AppointmentOption;

import java.util.ArrayList;

/**
 * Created by Adriano on 2/7/16.
 */
public interface GetDatesProviderCallback extends AuthenticatedProviderCallback {

    void onGetDatesSuccess(ArrayList<AppointmentOption> options);
    void onGetDatesFailure();
    void onGetDatesAuthFailed();

}

package com.example.adriano.esteticaregenere_android.Providers;

import com.example.adriano.esteticaregenere_android.Models.Service;

import java.util.ArrayList;

/**
 * Created by Adriano on 2/7/16.
 */
public interface ServicesProviderCallback extends AuthenticatedProviderCallback {

    void onGetServicesSuccess(ArrayList<Service>services);
    void onGetServicesFailure();
    void onGetServicesAuthFailed();

}

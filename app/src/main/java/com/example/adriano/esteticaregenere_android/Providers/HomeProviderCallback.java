package com.example.adriano.esteticaregenere_android.Providers;

import com.example.adriano.esteticaregenere_android.Models.Appointment;

import java.util.ArrayList;

public interface HomeProviderCallback extends AuthenticatedProviderCallback {

    void onSuccess(ArrayList<Appointment>appointments, String name);
    void onAuthFailure();
    void onFailure();


}
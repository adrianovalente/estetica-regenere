package com.example.adriano.esteticaregenere_android.Providers;

public interface DeleteAppointmentProviderCallback extends AuthenticatedProviderCallback {
    void onDeleteAppointmentSuccess();
    void onDeleteAppointmentFailure();
    void onAuthFailed();
}
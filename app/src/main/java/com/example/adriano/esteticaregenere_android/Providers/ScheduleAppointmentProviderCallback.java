package com.example.adriano.esteticaregenere_android.Providers;

/**
 * Created by Adriano on 2/7/16.
 */
public interface ScheduleAppointmentProviderCallback extends AuthenticatedProviderCallback {
    void onScheduleAppointmentSuccess();
    void onScheduleAppointmentFailure();
    void onScheduleAppointmentAuthFailed();
}

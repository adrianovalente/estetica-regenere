package com.example.adriano.esteticaregenere_android.Providers;

public interface LoginProviderCallback extends BaseProviderCallback {

    void onLoginSuccess(String token);
    void onLoginFailure();

}
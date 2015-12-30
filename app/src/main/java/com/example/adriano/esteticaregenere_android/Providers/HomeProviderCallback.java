package com.example.adriano.esteticaregenere_android.Providers;

import java.util.ArrayList;

public interface HomeProviderCallback {

    void onGetAreasSuccess(ArrayList<String>options);
    void onGetAreasFailure();

}
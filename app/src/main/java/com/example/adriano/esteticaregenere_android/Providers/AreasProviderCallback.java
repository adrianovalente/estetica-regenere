package com.example.adriano.esteticaregenere_android.Providers;

import com.example.adriano.esteticaregenere_android.Models.Area;

import java.util.List;

/**
 * Created by Adriano on 2/6/16.
 */
public interface AreasProviderCallback extends AuthenticatedProviderCallback {
    void onGetAreasSuccess(List<Area> areas);
    void onGetAreasFailure();
    void onGetAreasAuthFailure();

}

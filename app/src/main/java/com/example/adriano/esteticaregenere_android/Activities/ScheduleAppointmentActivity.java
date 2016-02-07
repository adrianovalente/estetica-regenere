package com.example.adriano.esteticaregenere_android.Activities;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.Components.HomeHeaderType;
import com.example.adriano.esteticaregenere_android.Components.HomeHeaderView;
import com.example.adriano.esteticaregenere_android.Models.Area;
import com.example.adriano.esteticaregenere_android.Models.Service;
import com.example.adriano.esteticaregenere_android.Providers.AreasProvider;
import com.example.adriano.esteticaregenere_android.Providers.AreasProviderCallback;
import com.example.adriano.esteticaregenere_android.Providers.ServicesProvider;
import com.example.adriano.esteticaregenere_android.Providers.ServicesProviderCallback;
import com.example.adriano.esteticaregenere_android.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Adriano on 1/30/16.
 */
public class ScheduleAppointmentActivity
        extends BaseMenuActivity
        implements AreasProviderCallback, ServicesProviderCallback {

    public final ScheduleAppointmentActivity thisScheduleActivity = this;
    @Override
    int getRightMenuIndex() {
        return 1;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.schedule_view);
        setup();
    }

    void setup() {
        setupHeaderView();
        showLoadingView();
        (new AreasProvider()).getAreas(this, this);
    }

    void setupHeaderView() {
        HomeHeaderView header = ((HomeHeaderView)findViewById(R.id.homeHeaderView));
        header.updateWithData("Adriano", "Vamos marcar uma consulta");
        header.setHeaderType(HomeHeaderType.HomeHeaderTypeSimple);
    }

    // Get Areas Callback
    @Override
    public void onGetAreasFailure() {
        showAlert("GET AREAS FAILURE");
    }

    @Override
    public void onGetAreasAuthFailure() {
        showAlert("Auth failure, please log in again");
    }

    @Override
    public void onGetAreasSuccess(final List<Area> areas) {
        Spinner areasSpinner = (Spinner)findViewById(R.id.areasSpinner);
        areasSpinner.setAdapter(new ArrayAdapter<Area>(this, android.R.layout.simple_spinner_dropdown_item, areas));
        areasSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                System.out.println(areas.get(position));
                (new ServicesProvider()).getServices(thisScheduleActivity, areas.get(position).id, thisScheduleActivity);
                showLoadingView();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                System.out.println("UPS!");
            }
        });
        hideLoadingView();

    }

    // Get Services Callback

    @Override
    public void onGetServicesAuthFailed() {
        showAlert("Auth failure, please log in again");
        hideLoadingView();
    }

    @Override
    public void onGetServicesFailure() {
        showAlert("GET SERVICES FAILURE");
        hideLoadingView();
    }

    @Override
    public void onGetServicesSuccess(final ArrayList<Service> services) {
        Spinner servicesSpinner = (Spinner)findViewById(R.id.servicesSpinner);
        servicesSpinner.setAdapter(new ArrayAdapter<Service>(this, android.R.layout.simple_spinner_dropdown_item, services));
        servicesSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                Service service = services.get(position);
                System.out.println("Selected " + service.name + ", id: " + service.id);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                System.out.println("UPS!");
            }
        });
        hideLoadingView();
    }
}

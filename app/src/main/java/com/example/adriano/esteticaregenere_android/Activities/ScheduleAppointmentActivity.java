package com.example.adriano.esteticaregenere_android.Activities;

import android.os.Bundle;

import com.example.adriano.esteticaregenere_android.Components.HomeHeaderType;
import com.example.adriano.esteticaregenere_android.Components.HomeHeaderView;
import com.example.adriano.esteticaregenere_android.R;

/**
 * Created by Adriano on 1/30/16.
 */
public class ScheduleAppointmentActivity extends BaseMenuActivity {

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
    }

    void setupHeaderView() {
        HomeHeaderView header = ((HomeHeaderView)findViewById(R.id.homeHeaderView));
        header.updateWithData("Adriano", "Vamos marcar uma consulta");
        header.setHeaderType(HomeHeaderType.HomeHeaderTypeSimple);
    }
}

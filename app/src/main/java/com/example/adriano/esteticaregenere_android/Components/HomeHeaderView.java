package com.example.adriano.esteticaregenere_android.Components;

import android.content.Context;
import android.util.AttributeSet;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.R;

/**
 * Created by Adriano on 10/28/15.
 */

public class HomeHeaderView extends LinearLayout {

    public HomeHeaderView(Context context) {
        super(context);
    }

    public HomeHeaderView(Context context, AttributeSet attrs) {
        super(context, attrs);
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        inflater.inflate(R.layout.home_header_view, this, true);
    }


    public void updateWithData(String name, int appointments) {
        ((TextView) findViewById(R.id.headerView_name)).setText("Olá, " + name);
        ((TextView) findViewById((R.id.headerView_appointments))).setText("Essa semana você tem " + appointments + " consultas");
    }
}

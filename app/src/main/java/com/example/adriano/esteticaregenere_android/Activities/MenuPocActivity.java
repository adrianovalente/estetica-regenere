package com.example.adriano.esteticaregenere_android.Activities;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.Components.HomeHeaderView;
import com.example.adriano.esteticaregenere_android.Components.MenuContainer;
import com.example.adriano.esteticaregenere_android.Models.Appointment;
import com.example.adriano.esteticaregenere_android.Models.AppointmentDate;
import com.example.adriano.esteticaregenere_android.Providers.HomeProvider;
import com.example.adriano.esteticaregenere_android.Providers.HomeProviderCallback;
import com.example.adriano.esteticaregenere_android.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Adriano on 1/23/16.
 */
public class MenuPocActivity
        extends Activity
        implements HomeProviderCallback
{
    MenuContainer container;
    private ArrayList<Appointment> list = new ArrayList<Appointment>();

    public void hideLoadingView() {
        findViewById(R.id.loadingHome).setVisibility(View.GONE);
    }

    @Override
    public void onSuccess(ArrayList<Appointment> appointments, String name) {
        HomeHeaderView header = (HomeHeaderView) findViewById(R.id.homeHeaderView);
        header.updateWithData(name, appointments.size());
        this.list = appointments;
        setupListView(appointments);
        hideLoadingView();

        //MenuPocActivity.this.startActivity(new Intent(MenuPocActivity.this, MenuPocActivity.class));
    }

    void setup() {
        (new HomeProvider()).getHomeInfo(this, this);
    }

    void setupListView(List<Appointment> list) {

        final ListView listView = (ListView) findViewById(R.id.listview);
        final MyArrayAdapter adapter = new MyArrayAdapter(this, android.R.layout.simple_list_item_1, list);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                System.out.println("Opa, clicou brothre!");
            }
        });


    }

    public void onScheduleAppointmentPressed(View view) {
        toggleMenu(view);
    }

    @Override
    public void onAuthFailure() {
        System.out.println("AUTH FAILURE");
        hideLoadingView();
    }

    @Override
    public void onTokenMissing() {
        System.out.println("TOKEN MISSING");
        hideLoadingView();
    }

    @Override
    public void onFailure() {
        System.out.println("HOME FALIIURE");
        hideLoadingView();
    }

    @Override
    public void onNetworkFailure() {
        System.out.println("NET FAILURE");
        hideLoadingView();
    }

    @Override
    public void onResponseFailure() {
        System.out.println("RESPONSE FAILURE");
        hideLoadingView();
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        container = (MenuContainer) this.getLayoutInflater().inflate(R.layout.menu_poc, null);
        setContentView(container);
        setup();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        return super.onCreateOptionsMenu(menu);
    }

    public void toggleMenu(View v){
        container.toggleMenu();
        System.out.println("Menu");
    }
}


class MyArrayAdapter extends ArrayAdapter<Appointment>
{
    private List<Appointment> list;
    public MyArrayAdapter(Context context, int textViewResourceId, List<Appointment> objects) {
        super(context, textViewResourceId, objects);
        this.list = objects;
    }

    public void updateWithData(ArrayList<Appointment> data) {
        this.list = data;
        notifyDataSetChanged();
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public boolean hasStableIds() {
        return true;
    }

    @Override
    public int getCount() {
        return this.list.size();
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.custom_table_view_cell, parent, false);
        TextView primaryTxtView = (TextView) rowView.findViewById(R.id.firstLine);
        primaryTxtView.setText(this.list.get(position).service);
        TextView secondaryTxtView = (TextView) rowView.findViewById(R.id.secondLine);
        secondaryTxtView.setText(this.list.get(position).esteticista);
        TextView dateTxtView = (TextView) rowView.findViewById(R.id.scheduleTime);
        AppointmentDate date = this.list.get(position).date;
        dateTxtView.setText(Integer.toString(date.day) + " de " + Integer.toString(date.month) + " de " + Integer.toString(date.year) + " às " + Integer.toString(date.hour) + ":" + Integer.toString(date.minute));
        return rowView;

    }
}
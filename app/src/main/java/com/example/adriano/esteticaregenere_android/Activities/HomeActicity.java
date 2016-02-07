package com.example.adriano.esteticaregenere_android.Activities;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.Components.HomeHeaderView;
import com.example.adriano.esteticaregenere_android.Models.Appointment;
import com.example.adriano.esteticaregenere_android.Models.AppointmentDate;
import com.example.adriano.esteticaregenere_android.Providers.DeleteAppointmentProvider;
import com.example.adriano.esteticaregenere_android.Providers.DeleteAppointmentProviderCallback;
import com.example.adriano.esteticaregenere_android.Providers.HomeProvider;
import com.example.adriano.esteticaregenere_android.Providers.HomeProviderCallback;
import com.example.adriano.esteticaregenere_android.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Adriano on 1/30/16.
 */

interface HomeListViewAdapterDelegate {
    void onDeleteButtonPressed(int id);
}
public class HomeActicity extends BaseMenuActivity implements HomeProviderCallback, HomeListViewAdapterDelegate, DeleteAppointmentProviderCallback {

    private ArrayList<Appointment> list = new ArrayList<Appointment>();
    final HomeActicity thisActivity = this;

    @Override
    int getRightMenuIndex() {
        return 0;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        System.out.println("Hello Home!");
        setContentView(R.layout.home_view);
        updateListView();
    }

    public void onDeleteButtonPressed(final int id) {
        AlertDialog.Builder alertDialog = new AlertDialog.Builder(HomeActicity.this);
        alertDialog.setPositiveButton("Sim", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                showLoadingView();
                (new DeleteAppointmentProvider()).deleteAppointment(thisActivity, id, thisActivity);

            }
        });
        alertDialog.setNegativeButton("Não", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        alertDialog.setTitle("Excluir consulta");
        alertDialog.setMessage("Tem certeza que deseja excluir essa consulta?");

        alertDialog.create().show();


    }

    public void hideLoadingView() {
        findViewById(R.id.loadingHome).setVisibility(View.GONE);
    }

    public void showLoadingView() {
        findViewById(R.id.loadingHome).setVisibility(View.VISIBLE);
    }

    @Override
    public void onSuccess(ArrayList<Appointment> appointments, String name) {
        HomeHeaderView header = (HomeHeaderView) findViewById(R.id.homeHeaderView);
        header.updateWithData(name, appointments.size());
        this.list = appointments;
        setupListView(appointments);
        hideLoadingView();

    }

    void updateListView() {
        showLoadingView();
        (new HomeProvider()).getHomeInfo(this, this);
    }

    void setupListView(List<Appointment> list) {

        final ListView listView = (ListView) findViewById(R.id.listview);
        final HomeListViewAdapter adapter = new HomeListViewAdapter(this, android.R.layout.simple_list_item_1, list, this);
        listView.setAdapter(adapter);

    }

    public void onScheduleAppointmentPressed(View view) {
        toggleMenu(view);
    }

    // Delete Appointment Delegate
    @Override
    public void onDeleteAppointmentFailure() {
        showAlert("Tivemos uma falha ao excluir a consulta. Por favor tente novamente mais tarde");
        hideLoadingView();
    }

    @Override
    public void onDeleteAppointmentSuccess() {
        showAlert("Sucesso!", "Consulta excluída com sucesso!");
        updateListView();
    }

    @Override
    public void onAuthFailed() {
        onAuthFailure();
    }


    // Home Provider Delegate
    @Override
    public void onAuthFailure() {
        showAlert("AUTH FAILURE");
        hideLoadingView();
    }

    @Override
    public void onTokenMissing() {
        showAlert("TOKEN MISSING");
        hideLoadingView();
    }

    @Override
    public void onFailure() {
        showAlert("HOME FALIIURE");
        hideLoadingView();
    }

    @Override
    public void onNetworkFailure() {
        showAlert("NET FAILURE");
        hideLoadingView();
    }

    @Override
    public void onResponseFailure() {
        showAlert("RESPONSE FAILURE");
        hideLoadingView();
    }

}

class HomeListViewAdapter extends ArrayAdapter<Appointment>
{
    private List<Appointment> list;
    private HomeListViewAdapterDelegate delegate;
    public HomeListViewAdapter(Context context, int textViewResourceId, List<Appointment> objects, HomeListViewAdapterDelegate delegate) {
        super(context, textViewResourceId, objects);
        this.list = objects;
        this.delegate = delegate;
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
    public boolean isEnabled(int position) {
        return false;
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
        final int appointmentId = this.list.get(position).id;
        rowView.findViewById(R.id.deleteButton).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                delegate.onDeleteButtonPressed(appointmentId);

            }
        });
        return rowView;

    }
}

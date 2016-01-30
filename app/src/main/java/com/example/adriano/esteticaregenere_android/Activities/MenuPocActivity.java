package com.example.adriano.esteticaregenere_android.Activities;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.media.Image;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.Components.HomeHeaderView;
import com.example.adriano.esteticaregenere_android.Components.MenuContainer;
import com.example.adriano.esteticaregenere_android.Models.Appointment;
import com.example.adriano.esteticaregenere_android.Models.AppointmentDate;
import com.example.adriano.esteticaregenere_android.Providers.DeleteAppointmentProvider;
import com.example.adriano.esteticaregenere_android.Providers.DeleteAppointmentProviderCallback;
import com.example.adriano.esteticaregenere_android.Providers.HomeProvider;
import com.example.adriano.esteticaregenere_android.Providers.HomeProviderCallback;
import com.example.adriano.esteticaregenere_android.Providers.MenuProvider;
import com.example.adriano.esteticaregenere_android.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Adriano on 1/23/16.
 */

interface HomeMenuAdapterDelegate {
    void onDeleteButtonPressed(int id);
}

public class MenuPocActivity
        extends Activity
        implements HomeProviderCallback, HomeMenuAdapterDelegate, DeleteAppointmentProviderCallback
{
    MenuContainer container;
    private ArrayList<Appointment> list = new ArrayList<Appointment>();
    final MenuPocActivity thisActivity = this;



    public void onDeleteButtonPressed(final int id) {
        System.out.println("Ok guy! Number" + Integer.toString(id));

        AlertDialog.Builder alertDialog = new AlertDialog.Builder(MenuPocActivity.this);
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

        //MenuPocActivity.this.startActivity(new Intent(MenuPocActivity.this, MenuPocActivity.class));
    }

    void setup() {
        setupMenuListView();
        updateListView();
        System.out.println("Hey, I'm alife!");
    }

    void updateListView() {
        showLoadingView();
        (new HomeProvider()).getHomeInfo(this, this);
    }

    void setupListView(List<Appointment> list) {

        final ListView listView = (ListView) findViewById(R.id.listview);
        final HomeMenuAdapter adapter = new HomeMenuAdapter(this, android.R.layout.simple_list_item_1, list, this);
        listView.setAdapter(adapter);

    }

    public void onScheduleAppointmentPressed(View view) {
        toggleMenu(view);
    }

    public void onAboutButtonClicked(View view) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://obscure-temple-3846.herokuapp.com/about_me"));
        startActivity(browserIntent);
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

    void showAlert(String title, String message) {
        AlertDialog alertDialog = new AlertDialog.Builder(MenuPocActivity.this).create();
        alertDialog.setTitle(title);
        alertDialog.setMessage(message);
        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "Ok", new AlertDialog.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        alertDialog.show();
    }

    void showAlert(String message) {
        showAlert("Atenção", message);
    }

    void setupMenuListView() {
        final ListView listView = (ListView) findViewById(R.id.menuListView);
        final MenuAdapter menuAdapter = new MenuAdapter(this, android.R.layout.simple_list_item_1, MenuProvider.menuOptions(), 0);
        listView.setAdapter(menuAdapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                System.out.println(MenuProvider.menuOptions().get(position).getMenuName() );
                menuAdapter.select(position);
            }
        });
    }
}


class MenuAdapter extends ArrayAdapter<MenuProvider>
{
    private List<MenuProvider> list;
    int selected;
    public MenuAdapter(Context context, int textViewResourceId, List<MenuProvider> objects, int selected) {
        super(context, textViewResourceId, objects);
        this.list = objects;
        this.selected = selected;
    }

    public void select(int index) {
        this.selected = index;
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
        return list.size();
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        boolean isSelected = this.selected == position;
        LayoutInflater inflater = (LayoutInflater) getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.menu_table_view_cell, parent, false);
        rowView.findViewById(R.id.menuBck).setBackgroundColor(Color.parseColor(isSelected ? "#51A583" : "#F5F5F5"));
        ((TextView)rowView.findViewById(R.id.menuTextView)).setTextColor(Color.parseColor(isSelected ? "#F5F5F5" : "#51A583"));
        ((TextView)rowView.findViewById(R.id.menuTextView)).setText(list.get(position).getMenuName());
        ((ImageView)rowView.findViewById(R.id.menuImage)).setImageResource(isSelected ? list.get(position).getSelectedImgResource() : list.get(position).getImgResource());
        return rowView;
    }
}

class HomeMenuAdapter extends ArrayAdapter<Appointment>
{
    private List<Appointment> list;
    private HomeMenuAdapterDelegate delegate;
    public HomeMenuAdapter(Context context, int textViewResourceId, List<Appointment> objects, HomeMenuAdapterDelegate delegate) {
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
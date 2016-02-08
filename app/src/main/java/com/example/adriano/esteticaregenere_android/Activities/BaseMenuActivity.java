package com.example.adriano.esteticaregenere_android.Activities;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import com.example.adriano.esteticaregenere_android.Providers.AuthenticatedProviderCallback;

import com.example.adriano.esteticaregenere_android.Components.MenuContainer;
import com.example.adriano.esteticaregenere_android.Providers.MenuProvider;
import com.example.adriano.esteticaregenere_android.R;

import java.util.HashMap;
import java.util.List;

/**
 * Created by Adriano on 1/23/16.
 */

interface MenuAdapterDelegate {
    void onMenuItemSelected(int ancient, int current);
}

interface AlertDelegate {
    void onOkButtonPressed();
}

public class BaseMenuActivity extends Activity implements MenuAdapterDelegate, AuthenticatedProviderCallback

{
    MenuContainer container;
    MenuAdapter adapter;
    public final BaseMenuActivity thisActivity = this;

    @Override
    protected void onRestart() {
        super.onRestart();
        if (getRightMenuIndex() != this.adapter.getSelectedMenuOption()) restartThisActivity();

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        container = (MenuContainer) this.getLayoutInflater().inflate(R.layout.menu_poc, null);
        setContentView(container);
        setupMenuListView();
    }

    @Override
    public void onMenuItemSelected(int ancient, int current) {
        System.out.println("Hey! Changing from " + Integer.toString(ancient) + " to " + Integer.toString(current));
        this.container.toggleMenu();
        if (ancient == current) return;
        Intent i;
        switch(current) {
            case 0:  i = new Intent(this, HomeActicity.class); break;
            case 1:  i = new Intent(this, ScheduleAppointmentActivity.class); break;
            default: i = new Intent(this, BaseMenuActivity.class); break;

        }

        /*
        / TODO: Validar com usuários android esse comportamento.
        / For me it makes perfect sense.
        */
        //if (ancient != 0) i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        startActivity(i);
        if (ancient != 0) finish();
    }

    int getRightMenuIndex() {
        return 0;
    }

    public void onAboutButtonClicked(View view) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://obscure-temple-3846.herokuapp.com/about_me"));
        startActivity(browserIntent);
    }

    public void setContentView(int viewId) {
        LayoutInflater inflater = LayoutInflater.from(this);
        View inflatedLayout= inflater.inflate(viewId, null, false);
        ((ViewGroup)findViewById(R.id.page_container)).addView(inflatedLayout);
        findViewById(R.id.loadingView).bringToFront();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        return super.onCreateOptionsMenu(menu);
    }

    public void toggleMenu(View v){
        container.toggleMenu();
    }

    void showAlert(String title, String message) {
        showAlert(title, message, null);
    }

    void showAlert(String title, String message, final AlertDelegate delegate) {
        AlertDialog alertDialog = new AlertDialog.Builder(BaseMenuActivity.this).create();
        alertDialog.setTitle(title);
        alertDialog.setMessage(message);
        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "Ok", new AlertDialog.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                if(delegate!=null)delegate.onOkButtonPressed();
            }
        });
        alertDialog.show();
    }

    void showAlert(String message) {
        showAlert("Atenção", message);
    }

    void setupMenuListView() {
        final ListView listView = (ListView) findViewById(R.id.menuListView);
        int option = 0;
        if (thisActivity.getClass().equals(HomeActicity.class)) option = 0;
        if (thisActivity.getClass().equals(ScheduleAppointmentActivity.class)) option = 1;


        final MenuAdapter menuAdapter = new MenuAdapter(this, android.R.layout.simple_list_item_1, MenuProvider.menuOptions(), option, this);
        this.adapter = menuAdapter;
        listView.setAdapter(menuAdapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                System.out.println(MenuProvider.menuOptions().get(position).getMenuName());
                menuAdapter.select(position);
            }
        });
    }

    void restartThisActivity() {
        Intent mIntent = getIntent();
        finish();
        startActivity(mIntent);
    }

    void hideLoadingView() {
        findViewById(R.id.loadingView).setVisibility(View.GONE);
    }

    void showLoadingView() {
        findViewById(R.id.loadingView).setVisibility(View.VISIBLE);
    }

    // Basic Provider Callbacks

    @Override
    public void onTokenMissing() {
        showAlert("TOKEN MISSING");
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

class MenuAdapter extends ArrayAdapter<MenuProvider>
{
    private List<MenuProvider> list;
    int selected;
    MenuAdapterDelegate delegate;
    public MenuAdapter(Context context, int textViewResourceId, List<MenuProvider> objects, int selected, MenuAdapterDelegate delegate) {
        super(context, textViewResourceId, objects);
        this.list = objects;
        this.selected = selected;
        this.delegate = delegate;
    }

    public int getSelectedMenuOption() { return this.selected; }

    public void select(int index) {
        int previousSelected = this.selected;
        this.selected = index;
        notifyDataSetChanged();
        this.delegate.onMenuItemSelected(previousSelected, index);

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
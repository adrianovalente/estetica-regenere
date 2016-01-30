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

import com.example.adriano.esteticaregenere_android.Components.MenuContainer;
import com.example.adriano.esteticaregenere_android.Providers.MenuProvider;
import com.example.adriano.esteticaregenere_android.R;

import java.util.List;

/**
 * Created by Adriano on 1/23/16.
 */

public class BaseMenuActivity extends Activity

{
    MenuContainer container;

    public void onAboutButtonClicked(View view) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://obscure-temple-3846.herokuapp.com/about_me"));
        startActivity(browserIntent);
    }

    public void setContentView(int viewId) {
        LayoutInflater inflater = LayoutInflater.from(this);
        View inflatedLayout= inflater.inflate(viewId, null, false);
        ((ViewGroup)findViewById(R.id.page_container)).addView(inflatedLayout);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        container = (MenuContainer) this.getLayoutInflater().inflate(R.layout.menu_poc, null);
        setContentView(container);
        setupMenuListView();

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        return super.onCreateOptionsMenu(menu);
    }

    public void toggleMenu(View v){
        container.toggleMenu();
    }

    void showAlert(String title, String message) {
        AlertDialog alertDialog = new AlertDialog.Builder(BaseMenuActivity.this).create();
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
                System.out.println(MenuProvider.menuOptions().get(position).getMenuName());
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
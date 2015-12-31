package com.example.adriano.esteticaregenere_android.Activities;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.example.adriano.esteticaregenere_android.Components.HomeHeaderView;
import com.example.adriano.esteticaregenere_android.Providers.*;
import com.example.adriano.esteticaregenere_android.R;

import java.util.ArrayList;
import java.util.List;



public class HomeActivity
        extends AppCompatActivity
        implements HomeProviderCallback
{

    private ArrayList<String> list = new ArrayList<String>();

    @Override
    public void onGetAreasFailure() {
        System.out.println("Failure @ home!");
    }

    @Override
    public void onGetAreasSuccess(ArrayList<String> options) {
        ((MyArrayAdapter) ((ListView) findViewById(R.id.listview)).getAdapter()).updateWithData(options);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        setup();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_home, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    void setup() {
        HomeHeaderView header = (HomeHeaderView) findViewById(R.id.homeHeaderView);
        header.updateWithData("Adriano", 5);
        setupListView();
        getData();
    }

    void setupListView() {

        final ListView listView = (ListView) findViewById(R.id.listview);
        String[] values = new String[] { "Android", "iPhone", "WindowsMobile",
                "Blackberry", "WebOS", "Ubuntu", "Windows7", "Max OS X",
                "Linux", "OS/2", "Ubuntu", "Windows7", "Max OS X", "Linux",
                "OS/2", "Ubuntu", "Windows7", "Max OS X", "Linux", "OS/2",
                "Android", "iPhone", "WindowsMobile" };

        for (int i = 0; i < values.length; ++i) {
            this.list.add(values[i]);
        }
        final MyArrayAdapter adapter = new MyArrayAdapter(this, android.R.layout.simple_list_item_1, this.list);

        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                System.out.println("Opa, clicou brothre!");
            }
        });


    }

    public void onScheduleAppointmentPressed(View view) {
        System.out.println("MARCAR CONSULTA");
    }

    void getData() {
        BaseProvider provider = new BaseProvider();
        provider.getPath("http://obscure-temple-3846.herokuapp.com/areas", this);
    }
}


class MyArrayAdapter extends ArrayAdapter<String>
{
    private List<String> list;
    public MyArrayAdapter(Context context, int textViewResourceId, List<String> objects) {
        super(context, textViewResourceId, objects);
        this.list = objects;
    }

    public void updateWithData(ArrayList<String> data) {
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
        //return super.getView(position, convertView, parent);
        LayoutInflater inflater = (LayoutInflater) getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.custom_table_view_cell, parent, false);
        TextView primaryTxtView = (TextView) rowView.findViewById(R.id.firstLine);
        primaryTxtView.setText(this.list.get(position));
        TextView secondaryTxtView = (TextView) rowView.findViewById(R.id.secondLine);
        secondaryTxtView.setText("Subtitulo " + Integer.toString(position));
        return rowView;

    }
}
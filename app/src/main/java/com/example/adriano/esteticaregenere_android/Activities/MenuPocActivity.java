package com.example.adriano.esteticaregenere_android.Activities;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;

import com.example.adriano.esteticaregenere_android.Components.MenuContainer;
import com.example.adriano.esteticaregenere_android.R;

/**
 * Created by Adriano on 1/23/16.
 */
public class MenuPocActivity extends Activity {
    MenuContainer container;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        container = (MenuContainer) this.getLayoutInflater().inflate(R.layout.menu_poc, null);
        setContentView(container);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        return super.onCreateOptionsMenu(menu);
    }

    public void toggleMenu(View v){
        container.toggleMenu();
    }
}

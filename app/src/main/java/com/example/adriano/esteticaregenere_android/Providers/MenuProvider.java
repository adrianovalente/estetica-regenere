package com.example.adriano.esteticaregenere_android.Providers;

import com.example.adriano.esteticaregenere_android.R;

import java.util.ArrayList;

/**
 * Created by Adriano on 1/30/16.
 */
public class MenuProvider {
    String menu;
    int imageResource, selectedImageResource;

    public MenuProvider(String menu, int imgResource, int selectedImgResource) {
        this.menu = menu;
        this.imageResource = imgResource;
        this.selectedImageResource = selectedImgResource;

    }

    public String getMenuName() { return this.menu; }
    public int getImgResource() { return this.imageResource; }
    public int getSelectedImgResource() { return this.selectedImageResource; }

    public static ArrayList<MenuProvider> menuOptions() {
        ArrayList<MenuProvider> list = new ArrayList<MenuProvider>();
        list.add(new MenuProvider("Home", R.drawable.home_green, R.drawable.home_white));
        list.add(new MenuProvider("Marcar consulta", R.drawable.schedule_selected, R.drawable.schedule));
        list.add(new MenuProvider("Política de Privacidade", R.drawable.cadeado, R.drawable.cadeado_selected));
        list.add(new MenuProvider("Fale conosco", R.drawable.contact, R.drawable.contact_selected));
        list.add(new MenuProvider("Fazer logout", R.drawable.logout, R.drawable.logout_selected));
        return list;
    }
}

package com.example.adriano.esteticaregenere_android.Models;

import java.util.ArrayList;

/**
 * Created by Adriano on 2/7/16.
 */
public class AppointmentOption {
    public String date;
    public ArrayList<String> times;

    @Override
    public String toString() {
        String [] dateArr = date.split("-");
        return String.format("%s de %s de %s", dateArr[0], getMonth(dateArr[1]), dateArr[2]);
    }

    String getMonth(String month) {
        String [] months = {
                "janeiro",
                "fevereiro",
                "março",
                "abril",
                "maio",
                "junho",
                "julho",
                "agosto",
                "setembro",
                "outubro",
                "novembro",
                "dezembro"
        };
        return months[Integer.parseInt(month)-1];
    }
}

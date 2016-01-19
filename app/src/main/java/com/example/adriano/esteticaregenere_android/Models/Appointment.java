package com.example.adriano.esteticaregenere_android.Models;

/**
 * Created by Adriano on 1/9/16.
 */
public class Appointment {

    public int id;
    public AppointmentDate date;
    public String esteticista;
    public String service;


    public Appointment(int id, AppointmentDate date, String esteticista, String service) {

        this.id = id;
        this.date = date;
        this.esteticista = esteticista;
        this.service = service;
    }
}

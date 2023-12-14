package org.example;

import java.io.IOException;
import java.text.ParseException;

public class Main {
    public static void main(String[] args) throws ParseException, IOException {
        DataContainer dataContainer = null;
        try {
            dataContainer = new DataContainer("GreenEr_data.csv");
            Difference dif = new Difference(dataContainer) ;
            dataContainer.addData("Difference_Consumption_production_kW", dif.dif() ) ;
            Autonomously per= new Autonomously(dataContainer) ;
            dataContainer.addData("Operating_Energy_autonomously_percentage ", per.per() ) ;
        } catch (IOException e) {
            e.printStackTrace();
        }
        assert dataContainer != null;
        Menu menu = new Menu(dataContainer);
    }
}
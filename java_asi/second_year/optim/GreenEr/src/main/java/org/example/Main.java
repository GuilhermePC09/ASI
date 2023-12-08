package org.example;

import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        DataContainer dataContainer = null;
        try {
            dataContainer = new DataContainer("GreenEr_data.csv");
        } catch (IOException e) {
            e.printStackTrace();
        }
        assert dataContainer != null;
        Menu menu = new Menu(dataContainer);
    }
}
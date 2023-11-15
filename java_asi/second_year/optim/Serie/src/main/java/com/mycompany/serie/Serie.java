/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.serie;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PIFFER CHRISTO Guilherme
 */
public class Serie {
    private String name;
    
    private Double valuesAverage;
    private Double timesAverage;
    private Double valuesStandardDerivation;
    private Double timesStandardDerivation;
    
    private List<Double> values;
    private List<Double> times;
    private List<Double> analitics;

    public Serie(String name) {
        this.name = name;
        this.values = new ArrayList<>();
        this.times = new ArrayList<>();
        this.analitics = new ArrayList<>();
    }

    private void populateWithValues(int numberOfValues, double min, double max){
        while (values.size() < numberOfValues) {
            double randomValue = min + Math.random() * (max - min) * 1000;
            if(randomValue>=min && randomValue<=max){
                values.add(Math.abs(randomValue));
            }
        }
    }
    
    private void populateWithTimes(int numberOfValues, double max){
        while (times.size() < numberOfValues) {
                double randomValue = Math.random() * 10;
                if(randomValue<=max){
                    times.add(Math.abs(randomValue));
                }
            }
    }
    
    public int size() {
        return values.size();
    }

    public void populate(int numberOfValues, double min, double max, boolean deleteOutliers) {
        populateWithValues(numberOfValues, min, max);
        populateWithTimes(numberOfValues, 24);
        analitics();
        if (deleteOutliers) {
            deleteOutliers(0.5);
        }
    }

    public void analitics(){
        double sumv = 0;
        for(int i = 0 ; i < values.size(); i++) {
            sumv += values.get(i);
        }
        double dv = (double) values.size();
        valuesAverage = sumv/dv;
        
        double sumt = 0;
        for(int i = 0 ; i < times.size(); i++) {
            sumt += times.get(i);
        }
        double dt = (double) times.size();
        timesAverage = sumt/dt;
        
        double standardDeviationValues = 0.0;
        for (double num : values) {
            standardDeviationValues += Math.pow(num - valuesAverage, 2);
        }
        valuesStandardDerivation = Math.sqrt(standardDeviationValues / dv);

        double standardDeviationTimes = 0.0;
        for (double num : times) {
            standardDeviationTimes += Math.pow(num - timesAverage, 2);
        }
        timesStandardDerivation = Math.sqrt(standardDeviationTimes / dt);
        
        analitics.add(valuesAverage);
        analitics.add(timesAverage);
        analitics.add(valuesStandardDerivation);
        analitics.add(timesStandardDerivation);
    }

    public String toString() {
       
        StringBuilder sb = new StringBuilder();
        sb.append("Serie name: " + name + "\n");
        sb.append("\n");
        sb.append("Size: " + size() + "\n");
        sb.append("\n");
        sb.append("Values: [");
        for (int i = 0; i < values.size(); i++) {
            sb.append(values.get(i));
            if (i < values.size() - 1) {
                sb.append(", ");
            }
        }
        sb.append("]\n");
        sb.append("Times: [");
        for (int i = 0; i < times.size(); i++) {
            sb.append(times.get(i));
            if (i < times.size() - 1) {
                sb.append(", ");
            }
        }
        sb.append("]\n");
        sb.append("\n");
        sb.append("Values average: " + analitics.get(0) + "\n");
        sb.append("\n");
        sb.append("Times average: " + analitics.get(1) + "\n");
        sb.append("\n");
        sb.append("Values Standard Derivation: " + analitics.get(2) + "\n");
        sb.append("\n");
        sb.append("Times Standard Derivation: " + analitics.get(3) + "\n");
        return sb.toString();
    }

    public void deleteOutliers(double LAMBDA) {    
        double MOYENNE = analitics.get(0);
        double DEVIATION = analitics.get(2);
    
        List<Double> newValues = new ArrayList<>();
        List<Double> newTimes = new ArrayList<>();
    
        for (int i = 0; i < values.size(); i++) {
            double currentValue = values.get(i);
            double pdiff = i == 0 ? 0 : currentValue - values.get(i - 1);
            double fdiff = i == values.size() - 1 ? 0 : values.get(i + 1) - currentValue;
    
            if (Math.abs(pdiff) <= (MOYENNE + LAMBDA * DEVIATION)){
                if(Math.abs(fdiff) <= (MOYENNE + LAMBDA * DEVIATION)){
                    if (pdiff * fdiff >= 0) {
                        newValues.add(currentValue);
                        newTimes.add(times.get(i));
                    }
                }
            }
        }
    
        values = newValues;
        times = newTimes;
        analitics();
    }
    
        
        public static void main(String[] args) {
        Serie mySerie = new Serie("ExampleSeries");
        mySerie.populate(10, 400, 2500, true);
        System.out.println(mySerie.toString());
    }

}

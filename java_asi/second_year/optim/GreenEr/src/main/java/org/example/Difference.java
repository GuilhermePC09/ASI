package org.example;

public class Difference {
    DataContainer dataContainer;
    public Difference(DataContainer dataContainer) {
        this.dataContainer = dataContainer;
    }
    public double[] dif(){
        double[] diffe = new double[dataContainer.getNumberOfSamples()];
        Double[] conso= dataContainer.getData(dataContainer.getAvailableVariables()[0]);
        Double [] prod= dataContainer.getData(dataContainer.getAvailableVariables()[1]);
        for (int i =0; i< conso.length; i++){
            diffe[i]=conso[i]-prod[i];
        }
        return diffe;
    }
}

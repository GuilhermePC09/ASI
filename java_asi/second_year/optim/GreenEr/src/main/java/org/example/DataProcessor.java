package org.example;

public class DataProcessor {
    DataContainer dataContainer;
    public DataProcessor(DataContainer dataContainer) {
        this.dataContainer = dataContainer;
    }

    public double[] per(){
        double[] perce = new double[dataContainer.getNumberOfSamples()];
        Double[] conso= dataContainer.getData(dataContainer.getAvailableVariables()[0]);
        Double [] prod= dataContainer.getData(dataContainer.getAvailableVariables()[1]);
        for (int i =0; i< conso.length; i++){
            perce[i]=prod[i]*100/conso[i];
        }
        return perce;
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

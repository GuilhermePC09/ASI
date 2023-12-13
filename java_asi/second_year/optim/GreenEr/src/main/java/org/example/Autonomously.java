package org.example;

public class Autonomously {
    DataContainer dataContainer;

    public Autonomously (DataContainer dataContainer) {

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
}

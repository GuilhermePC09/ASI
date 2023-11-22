package com.mycompany.be2_matrices;

import java.util.TreeMap;

public class SparseMatrix{
    TreeMap<MatrixCoordinate, Double> map = new TreeMap<MatrixCoordinate, Double>();
    public int numberOfLines, numberOfColumns;
    public int[] size;
    public double[][] matrix;
    public boolean testDia = false; 
    
    public SparseMatrix(int numberOfLines, int numberOfColumns) {
        this.numberOfLines = numberOfLines;
        this.numberOfColumns = numberOfColumns;
    }
    
    public void setValue(int i, int j, double value) {
        if (i >= 0 && i < numberOfLines && j >= 0 && j < numberOfColumns) {
            map.put(new MatrixCoordinate(i, j), value);
        } else {
            throw new IllegalArgumentException("Invalid index in values: " + i + " " + j + " ");
        }
    }

    public double getValue(int i, int j) {
        if (i >= 0 && i < numberOfLines && j >= 0 && j < numberOfColumns) {
            return map.get(new MatrixCoordinate(i, j));
        } else {
            throw new IllegalArgumentException("Invalid index in values: " + i + " " + j + " ");
        }
    }

    public int[] getSize() {
        size = new int[2];
        size[0] = this.numberOfLines;
        size[1] = this.numberOfColumns;

        return size;
    }

    public SparseMatrix transpose() {
        SparseMatrix s = new SparseMatrix(this.numberOfColumns, this.numberOfLines);
        if (this.testDia){
            s.map = this.map;
        }
        else {
            for (int i = 0; i < this.numberOfLines; i++) {
                for (int j = 0; j < this.numberOfColumns; j++) {
                    double value = this.map.get(new MatrixCoordinate(i, j));
                    s.setValue(j, i, value);
                }
            }
        }
        
        return s;
    }

    
    public String toString() {
        
        if(this.map.isEmpty()) {
            return "null";
        }
        else{
            String s;
            s = this.map.toString();
            
            return s;
        }     
    }
}

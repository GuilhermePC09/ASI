package com.mycompany.be2_matrices;

public class DiagonalMatrix extends SparseMatrix{
    int size;
     
    public DiagonalMatrix(int s) {
        super(s,s);
        this.size = s;
        this.testDia = true;
    }
    
    public void setValue(int i, int j, double value) {
        if (i == j) {
            super.setValue(i, j, value);
        } else {
            throw new IllegalArgumentException("Invalid indices for a diagonal matrix.");
        }
    }  
}

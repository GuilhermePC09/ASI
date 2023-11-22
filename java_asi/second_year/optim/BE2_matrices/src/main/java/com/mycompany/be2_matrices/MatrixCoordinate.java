package com.mycompany.be2_matrices;

public class MatrixCoordinate implements Comparable<MatrixCoordinate>{
    int i, j;
    
    public MatrixCoordinate(int i,int j){
        this.i = i;
        this.j = j;
    }
    
    public int getI(){
        return i;
    }
    
    public int getJ(){
        return j;
    }
    
    public String toString(){
        return "[ "+this.i+"; "+this.j+"]";
    }
    
    public int compareTo(MatrixCoordinate a) {
        int r = -1;
        
        if((this.i == a.getI()) && (this.j == a.getJ())) {
            r = 0;
            return r;
        }
        
        if((this.i > a.getI())) {
            r = 1;
            return r;
        }
        
        if((this.i == a.getI()) && (this.j > a.getJ())) {
            r = 1;
            return r;
        }
        
        return r;
    }
    
    
}

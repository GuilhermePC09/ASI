/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.be2_matrices;

public class Point {

    double x;
    double y;

    public Point(double Abscisse, double Ordonne) {
        this.x = Abscisse;
        this.y = Ordonne;
    }

    public double abscisse() {
        return x;
    }

    public double ordonne() {
        return y;
    }

    public String toString() {
        return "[ " + x + "; " + y + "]";
    }
}

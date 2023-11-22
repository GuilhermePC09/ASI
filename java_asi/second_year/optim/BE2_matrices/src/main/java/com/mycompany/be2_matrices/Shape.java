package com.mycompany.be2_matrices;

import java.awt.*;

public abstract class Shape extends Component {
    boolean fill;
    static Integer counter = 0;
    Integer ID;

    public Shape() {
        counter++;
        ID = counter;
    }

    public int getId() {
        return ID;
    }

    public void setFilling(boolean Fill) {
        this.fill = Fill;
    }

    public boolean getFilling() {
        return fill;
    }

    public abstract double surface();

    public abstract double perimeter();

    public abstract void plot(Graphics g);

    public abstract boolean Inside(Point p);

    public abstract String toString();
}

package com.mycompany.be2_matrices;

import java.awt.Graphics;

public class Rectangle extends Shape {

    Point point1;
    Point point2;
    Point point;
    double width = 0;
    double height;

    public Rectangle(Point p1, Point p2) {
        super();
        this.point1 = p1;
        this.point2 = p2;
    }

    public Rectangle(Point p, double w, double h) {
        super();
        this.point = p;
        this.width = w;
        this.height = h;
    }

    public double surface() {
        double res = 0;
        if (this.width == 0) {
            res = Math.abs(point1.abscisse() - point2.abscisse()) * Math.abs(point1.ordonne() - point2.ordonne());
        } else {
            res = width * height;
        }
        return res;
    }

    public double perimeter() {
        if (this.width == 0) {
            return 2 * (Math.abs(point1.abscisse() - point2.abscisse()) + Math.abs(point1.ordonne() - point2.ordonne()));
        } else {
            return 2 * (width + height);
        }
    }

    public void plot(Graphics g) {
        if (fill) {
            if (this.width == 0) {
                g.fillRect((int) point1.abscisse(), (int) point1.ordonne(),
                           (int) Math.abs(point2.abscisse() - point1.abscisse()),
                           (int) Math.abs(point2.ordonne() - point1.ordonne()));
            } else {
                g.fillRect((int) point.abscisse(), (int) point.ordonne(), (int) width, (int) height);
            }
        } else {
            if (this.width == 0) {
                g.drawRect((int) point1.abscisse(), (int) point1.ordonne(),
                           (int) Math.abs(point2.abscisse() - point1.abscisse()),
                           (int) Math.abs(point2.ordonne() - point1.ordonne()));
            } else {
                g.drawRect((int) point.abscisse(), (int) point.ordonne(), (int) width, (int) height);
            }
        }
    }

    public boolean Inside(Point p) {
        boolean res = false;
        if (this.width == 0) {
            point = point1;
            this.width = Math.abs(point2.abscisse() - point1.abscisse());
            this.height = Math.abs(point2.ordonne() - point1.ordonne());
        }
        if ((p.abscisse() - point.abscisse() <= width) && (p.ordonne() - point.ordonne() <= height)) {
            res = true;
        }
        return res;
    }

    public String toString() {
        String s = "Rectangle ";
        if (this.width == 0) {
            s = s + "point 1 = " + point1 + " point 2 = " + point2;
        } else {
            s = s + "point = " + point + " width = " + width + " height = " + height;
        }
        return s;
    }

}

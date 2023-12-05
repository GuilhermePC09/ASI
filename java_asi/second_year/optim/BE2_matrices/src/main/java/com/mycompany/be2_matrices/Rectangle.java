package com.mycompany.be2_matrices;

import java.awt.Color;
import java.awt.Graphics;

public class Rectangle extends Shape {

    private Point point1;
    private Point point2;
    private Point point;
    private double width = 0;
    private double height;
    private Color color;

    public Rectangle(Point p1, Point p2, Color c) {
        super();
        this.point1 = p1;
        this.point2 = p2;
        this.color = c;
    }

    public Rectangle(Point p, double w, double h, Color c) {
        super();
        this.point = p;
        this.width = w;
        this.height = h;
        this.color = c;
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
                g.setColor(color);
                g.fillRect((int) point1.abscisse(), (int) point1.ordonne(),
                           (int) Math.abs(point2.abscisse() - point1.abscisse()),
                           (int) Math.abs(point2.ordonne() - point1.ordonne()));
            } else {
                g.setColor(color);
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

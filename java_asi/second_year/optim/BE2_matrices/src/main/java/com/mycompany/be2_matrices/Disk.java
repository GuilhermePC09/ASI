package com.mycompany.be2_matrices;

import java.awt.Graphics;

public class Disk extends Shape {

    Point center;
    double radius = 0;
    Point point1;
    Point point2;

    public Disk(Point cen, double r) {
        super();
        this.center = cen;
        this.radius = r;
    }

    public Disk(Point p1, Point p2) {
        super();
        this.point1 = p1;
        this.point2 = p2;
    }

    @Override
    public double surface() {
        if (radius == 0) {
            radius = Math.sqrt((point1.ordonne() - point2.ordonne()) * (point1.ordonne() - point2.ordonne())
                    + (point1.abscisse() - point2.abscisse()) * (point1.abscisse() - point2.abscisse()));
        }
        return Math.PI * radius * radius;
    }

    public double perimeter() {
        if (radius == 0) {
            radius = Math.sqrt((point1.ordonne() - point2.ordonne()) * (point1.ordonne() - point2.ordonne())
                    + (point1.abscisse() - point2.abscisse()) * (point1.abscisse() - point2.abscisse()));
            center = new Point((point1.abscisse() + point2.abscisse()) / 2,
                    (point1.ordonne() + point2.ordonne()) / 2);
        }
        return 2 * Math.PI * radius;
    }

    public void plot(Graphics g) {
        if (fill) {
            g.fillOval((int) (center.abscisse() - radius), (int) (center.ordonne() - radius), (int) (2 * radius),
                    (int) (2 * radius));
        } else {
            g.drawOval((int) (center.abscisse() - radius), (int) (center.ordonne() - radius), (int) (2 * radius),
                    (int) (2 * radius));
        }
    }

    public boolean Inside(Point p) {
        boolean res = false;
        if (radius == 0) {
            radius = Math.sqrt((point1.ordonne() - point2.ordonne()) * (point1.ordonne() - point2.ordonne())
                    + (point1.abscisse() - point2.abscisse()) * (point1.abscisse() - point2.abscisse()));
            center = new Point((point1.abscisse() + point2.abscisse()) / 2,
                    (point1.ordonne() + point2.ordonne()) / 2);
        }
        if (Math.sqrt((p.ordonne() - center.ordonne()) * (p.ordonne() - center.ordonne())
                + (p.abscisse() - center.abscisse()) * (p.abscisse() - center.abscisse())) <= radius) {
            res = true;
        }
        return res;
    }

    @Override
    public String toString() {
        String s = "Disk ";
        if (this.radius == 0) {
            s = s + "point 1 = " + point1 + " point 2 = " + point2;
        } else {
            s = s + "center = " + center + " radius = " + radius;
        }
        return s;
    }
}

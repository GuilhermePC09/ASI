package com.mycompany.be2_matrices;

import java.awt.Graphics;

public class Polygon extends Shape {
    private Point center;
    private int sides;
    private double sideLength;

    public Polygon(Point center, int sides, double sideLength) {
        super();
        this.center = center;
        this.sides = sides;
        this.sideLength = sideLength;
    }

    public double surface() {
        return (sides * Math.pow(sideLength, 2)) / (4 * Math.tan(Math.PI / sides));
    }

    public double perimeter() {
        return sides * sideLength;
    }

    public void plot(Graphics g) {
        int[] xPoints = new int[sides];
        int[] yPoints = new int[sides];

        for (int i = 0; i < sides; i++) {
            double angle = 2 * Math.PI * i / sides;
            xPoints[i] = (int) (center.abscisse() + sideLength * Math.cos(angle));
            yPoints[i] = (int) (center.ordonne() + sideLength * Math.sin(angle));
        }

        if (fill) {
            g.fillPolygon(xPoints, yPoints, sides);
        } else {
            g.drawPolygon(xPoints, yPoints, sides);
        }
    }

    public boolean Inside(Point p) {
        double angle = 2 * Math.PI / sides;
        int[] xPoints = new int[sides];
        int[] yPoints = new int[sides];

        for (int i = 0; i < sides; i++) {
            xPoints[i] = (int) (center.abscisse() + sideLength * Math.cos(angle * i));
            yPoints[i] = (int) (center.ordonne() + sideLength * Math.sin(angle * i));
        }

        Polygon testPolygon = new Polygon(new Point(p.abscisse(), p.ordonne()), sides, sideLength);

        int[] testXPoints = new int[sides];
        int[] testYPoints = new int[sides];

        for (int i = 0; i < sides; i++) {
            testXPoints[i] = (int) (p.abscisse() + sideLength * Math.cos(angle * i));
            testYPoints[i] = (int) (p.ordonne() + sideLength * Math.sin(angle * i));
        }

        Polygon testPointPolygon = new Polygon(new Point(p.abscisse(), p.ordonne()), sides, sideLength);

        return isPointInPolygon(testPointPolygon, testXPoints, testYPoints);
    }

    private boolean isPointInPolygon(Polygon polygon, int[] xPoints, int[] yPoints) {
        int intersections = 0;

        for (int i = 0; i < sides; i++) {
            int x1 = xPoints[i];
            int y1 = yPoints[i];
            int x2 = xPoints[(i + 1) % sides];
            int y2 = yPoints[(i + 1) % sides];

            if (intersects(polygon.abscisse(), polygon.ordonne(), x1, y1, x2, y2)) {
                intersections++;
            }
        }

        return intersections % 2 == 1;
    }

    private boolean intersects(double x, double y, double x1, double y1, double x2, double y2) {
        return (y > Math.min(y1, y2) && y <= Math.max(y1, y2) &&
                x <= Math.max(x1, x2) && y1 != y2 &&
                y1 != y && (x1 == x2 || x <= (y - y1) * (x2 - x1) / (y2 - y1) + x1));
    }
    
    public String toString() {
        return "Polygon center = " + center + ", sides = " + sides + ", side length = " + sideLength;
    }

    public double abscisse() {
        return center.abscisse();
    }


    public double ordonne() {
        return center.ordonne();
    }
}


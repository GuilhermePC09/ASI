package com.mycompany.be2_matrices;

import javax.swing.*;

public class main_shapes {
    public static void main(String[] args) {
        Canvas canvas = new Canvas();

        int rectangle1Id = canvas.addShape(new Rectangle(new Point(500, 500), 30, 20));
        int rectangle2Id = canvas.addShape(new Rectangle(new Point(10, 10), new Point(-4, -3)));
        int disk1Id = canvas.addShape(new Disk(new Point(100, 100), 30));
        int disk2Id = canvas.addShape(new Disk(new Point(1, 3), new Point(2, -2)));
        int squareId = canvas.addShape(new Square(new Point(3, 3), 4));
        int polygon = canvas.addShape(new Polygon(new Point(800, 600), 6, 50));

        canvas.getShapeWithID(rectangle1Id).setFilling(true);
        canvas.getShapeWithID(rectangle2Id).setFilling(true);
        canvas.getShapeWithID(disk1Id).setFilling(true);
        canvas.getShapeWithID(disk2Id).setFilling(true);
        canvas.getShapeWithID(squareId).setFilling(true);
        canvas.getShapeWithID(polygon).setFilling(true);

        canvas.deleteShape(disk2Id);

        JFrame frame = new JFrame();
        frame.setSize(1000, 1000);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(new CanvasComponent(canvas));
        frame.setVisible(true);

        for (Object obj : canvas.getShape()) {
            Shape shape = (Shape) obj;
            System.out.println("Shape ID: " + shape.getId());
            System.out.println("Perimeter: " + shape.perimeter());
            System.out.println("Area: " + shape.surface());
            System.out.println("---------");
        }

        System.out.println("Is inside: " + canvas.isInsideAShape(new Point(900, 900)));
        System.out.println("Is inside: " + canvas.isInsideAShape(new Point(1.5, 2.5)));
    }
}

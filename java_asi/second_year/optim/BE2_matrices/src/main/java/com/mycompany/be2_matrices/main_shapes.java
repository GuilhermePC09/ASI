package com.mycompany.be2_matrices;

public class main_shapes {

    public static void main(String[] args) {
        Rectangle r = new Rectangle(new Point(1, 1), 3, 2);
        Disk d = new Disk(new Point(-1, 1), 3);
        Canvas canvas = new Canvas();
        
        int rectangle1Id = canvas.addShape(new Rectangle(new Point(1, 1), 3, 2));
        int rectangle2Id = canvas.addShape(new Rectangle(new Point(-1, -1), new Point(-4, -3)));
        int disk1Id = canvas.addShape(new Disk(new Point(-1, 1), 3));
        int disk2Id = canvas.addShape(new Disk(new Point(1, -3), new Point(2, -2)));
        
        canvas.getShapeWithID(rectangle1Id).setFilling(true);
        canvas.getShapeWithID(rectangle2Id).setFilling(true);
        canvas.getShapeWithID(disk1Id).setFilling(true);
        canvas.getShapeWithID(disk2Id).setFilling(true);
        
        canvas.deleteShape(disk2Id);
        
        System.out.println(canvas);
        System.out.println(canvas.getAllFilledShapesArea());
        System.out.println(canvas.isInsideAShape(new Point(-2, 2)));
        System.out.println(canvas.isInsideAShape(new Point(1.5, -2.5)));
    }
}

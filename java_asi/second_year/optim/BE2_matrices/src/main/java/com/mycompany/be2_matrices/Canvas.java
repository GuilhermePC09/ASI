package com.mycompany.be2_matrices;

import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Collection;
import java.util.TreeMap;


public class Canvas{
    TreeMap<Integer, Shape> map = new TreeMap<Integer, Shape>();
    ArrayList<Integer> IDS = new ArrayList<Integer>();

    public Canvas() {
    }

    public int addShape(Shape s) {
        int id = s.getId();
        IDS.add(id);
        map.put(id, s);
        return id;
    }

    public Shape getShapeWithID(int id) {
        return map.get(id);
    }

    public Collection getShape() {
        return map.values();
    }

    public void deleteShape(int id) {
        map.remove(id);
        int index = this.IDS.indexOf(id);
        this.IDS.remove(index);
    }

    public void plot(Graphics g) {
        for (Shape shape : map.values()) {
            shape.plot(g);
        }
    }

    public String toString() {
        return "Canvas :\n" + this.map;
    }

    public String isInsideAShape(Point p) {
        boolean test = false;

        for (int i : IDS) {
            if (map.get(i).Inside(p)) {
                test = true;
                return "Is inside =  " + test;
            }
        }

        return "Is inside =  " + test;
    }

    public String getAllFilledShapesArea() {
        double s = 0;
        for (int i : IDS) {
            if (map.get(i).fill) {
                s += map.get(i).surface();
            }
        }
        return "Area =  " + s;
    }
}

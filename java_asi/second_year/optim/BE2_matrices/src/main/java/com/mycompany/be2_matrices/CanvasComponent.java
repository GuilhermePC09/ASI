package com.mycompany.be2_matrices;

import java.awt.Graphics;

import javax.swing.JComponent;

class CanvasComponent extends JComponent {
    private Canvas canvas;

    public CanvasComponent(Canvas canvas) {
        this.canvas = canvas;
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        canvas.plot(g);
    }
}

package org.example;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

import javax.swing.*;
import java.util.Date;
import java.util.Map;

public class Plotter {
    private XYSeriesCollection dataset;
    private JFreeChart chart;
    private JFrame frame;

    public Plotter() {
        XYSeries series = new XYSeries("Empty Series");
        dataset = new XYSeriesCollection(series);
        chart = ChartFactory.createXYLineChart(
                "Energy Consumption",
                "",
                "",
                dataset,
                PlotOrientation.VERTICAL,
                true,
                true,
                false
        );
        ChartPanel chartPanel = new ChartPanel(chart);

        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
        panel.add(chartPanel);

        frame = new JFrame("Chart Frame");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(panel);

        frame.pack();
        frame.setVisible(true);
    }

    public void updateSeries(Map<String, Double[]> plotData, Map<String, Date[]> plotDates) {
        dataset.removeAllSeries();

        for (Map.Entry<String, Double[]> entry : plotData.entrySet()) {
            XYSeries series = new XYSeries(entry.getKey());
            Double[] yData = entry.getValue();
            Date[] xData = plotDates.get(entry.getKey());
            System.out.println(xData);
            for (int i = 0; i < yData.length; i++) {
                series.add(xData[i].getTime(), yData[i]);
            }

            dataset.addSeries(series);
        }
    }

    public boolean isVisible() {
        return frame.isVisible();
    }
}
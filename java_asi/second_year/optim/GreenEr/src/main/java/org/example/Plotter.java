package org.example;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.data.time.*;

import javax.swing.*;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.TreeMap;

public class Plotter {
    TreeMap<String, TimeSeries> timeSeriesContainer;
    DataContainer dataContainer;

    public Plotter(DataContainer csvDataReader) throws ParseException {
        this.dataContainer = csvDataReader;
        this.timeSeriesContainer = new TreeMap<>();

        Date[] dates = dataContainer.getDates();
        for (String availableVariable : dataContainer.getAvailableVariables()) {
            TimeSeries timeserie = new TimeSeries(availableVariable);
            for (int l = 0; l < dataContainer.getTimeStrings().length; l++) {
                timeserie.add(new Hour(dates[l]), dataContainer.getData(availableVariable)[l]);
            }
            timeSeriesContainer.put(availableVariable, timeserie);
        }
    }

    public void updateSeries(String[] variableNames, Date date1, Date date2, String option) throws ParseException {
        TimeSeriesCollection seriesToPlot = new TimeSeriesCollection();
        for (String variableName : variableNames) {
            TimeSeries originalSeries = timeSeriesContainer.get(variableName);
            TimeSeries filteredSeries = new TimeSeries(originalSeries.getKey());

            switch (option) {
                case "Month":
                {   while (date1.before(date2)) {
                    double monthlyAverage = calculateMonthlyAverage(originalSeries, date1);
                    filteredSeries.add(new Month(date1), monthlyAverage);
                    date1 = getNextMonth(date1);
                }break;
                }
                case "Day":
                {   while (date1.before(date2)) {
                    double dailyAverage = calculateDailyAverage(originalSeries, date1);
                    filteredSeries.add(new Day(date1), dailyAverage);
                    date1 = getNextDay(date1);
                }break;
                }
                default:
                    for (int j = 0; j < originalSeries.getItemCount(); j++) {
                        Hour hour = (Hour) originalSeries.getTimePeriod(j);

                        if (hour.getStart().after(date1) && hour.getEnd().before(date2)) {
                            filteredSeries.add(hour, originalSeries.getValue(j));
                        }
                    }break;
            }
            seriesToPlot.addSeries(filteredSeries);
        }
        JPanel panel = new ChartPanel(ChartFactory.createTimeSeriesChart("Energy consommation", "xlabel", "ylabel", seriesToPlot, true, true, false));
        JFrame frame = new JFrame("plot");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(panel);
        frame.pack();
        frame.setVisible(true);
    }
    private double calculateDailyAverage(TimeSeries originalSeries, Date date) {
        double total = 0;
        int count = 0;

        for (int j = 0; j < originalSeries.getItemCount(); j++) {
            Hour hour = (Hour) originalSeries.getTimePeriod(j);
            System.out.println(hour);
            if (hour.getStart().getMonth() == date.getMonth() && hour.getStart().getYear() == date.getYear() && hour.getStart().getDay()==date.getDay()) {
                total += originalSeries.getValue(j).doubleValue();
                count++;
            }
        }
        return (count > 0) ? total / count : 0;
    }
    private double calculateMonthlyAverage(TimeSeries originalSeries, Date date) {
        double total = 0;
        int count = 0;
        for (int j = 0; j < originalSeries.getItemCount(); j++) {
            Hour hour = (Hour) originalSeries.getTimePeriod(j);
            if (hour.getStart().getMonth() == date.getMonth() && hour.getStart().getYear() == date.getYear()) {
                total += originalSeries.getValue(j).doubleValue();
                count++;
            }
        }
        return (count > 0) ? total / count : 0.0;
    }

    private Date getNextMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, 1);
        return calendar.getTime();
    }
    private Date getNextDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        return calendar.getTime();
    }
}

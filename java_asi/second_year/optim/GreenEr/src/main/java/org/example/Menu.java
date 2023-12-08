package org.example;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;

public class Menu extends JFrame {
    private Plotter plotter;
    private String[] checkboxItems;
    private Hashtable<String, Double[]> plotData;
    private Hashtable<String, Date[]> plotDates;
    private JTextField dateTextFieldInitialDate;
    private JTextField dateTextFieldFinalDate;

    public Menu(DataContainer dataContainer) {
        checkboxItems = dataContainer.getAvailableVariables();
        plotData = new Hashtable<>();
        plotDates = new Hashtable<>();

        createUI(dataContainer);
        setSize(700, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
    }

    private void createUI(DataContainer dataContainer) {
        JPanel panelMain = new JPanel();
        JPanel panelSup = new JPanel();
        JPanel panelInf = new JPanel();
        JPanel panelTex1 = new JPanel(new GridLayout(4, 1));
        JPanel panelTex2 = new JPanel(new GridLayout(4, 1));
        JPanel panelCheck = new JPanel(new GridLayout(4, 1));

        panelMain.setLayout(new GridLayout(2, 1));

        panelSup.setLayout(new BorderLayout());

        panelMain.add(panelSup);
        panelMain.add(panelInf);

        for (String item : checkboxItems) {
            JCheckBox checkBox = new JCheckBox(item);
            checkBox.addItemListener(new ItemListener() {
                @Override
                public void itemStateChanged(ItemEvent e) {
                    if (e.getStateChange() == ItemEvent.SELECTED) {
                        System.out.println(item + " is checked");
                        plotData.put(item, dataContainer.getData(item));
                        try {
                            plotDates.put(item, dataContainer.getDates());
                        } catch (ParseException ex) {
                            throw new RuntimeException(ex);
                        }
                    } else {
                        System.out.println(item + " is unchecked");
                        plotData.remove(item);
                        plotDates.remove(item);
                    }
                }
            });
            panelCheck.add(checkBox);
        }
        panelSup.add(panelCheck, BorderLayout.WEST);

        panelTex1.add(new JLabel("Please indicate the dates you wish to view:"));
        panelTex1.add(new JLabel("Please indicate the dates you wish to view:"));
        panelTex1.add(new JLabel("2022-09-01 00:00 and 2023-08-31 23:00"));

        panelTex1.add(new JLabel("Initial date (format : mm-dd-yyyy HH:mm)"));
        dateTextFieldInitialDate = new JTextField(20);
        panelTex1.add(dateTextFieldInitialDate);

        panelSup.add(panelTex1, BorderLayout.CENTER);

        panelTex1.add(new JLabel(""));
        panelTex1.add(new JLabel(""));
        panelTex2.add(new JLabel("Final date (format : mm-dd-yyyy HH:mm)"));
        dateTextFieldFinalDate = new JTextField(20);
        panelTex2.add(dateTextFieldFinalDate);

        panelSup.add(panelTex2, BorderLayout.EAST);

        JButton plotButton = new JButton("Plot");
        plotButton.addActionListener(e -> {
            if (plotter == null || !plotter.isVisible()) {
                plotter = new Plotter();
            }

            String initialDate = dateTextFieldInitialDate.getText();
            String finalDate = dateTextFieldFinalDate.getText();

            SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy HH:mm");

            try {
                Date startDate = dateFormat.parse(initialDate);
                Date endDate = dateFormat.parse(finalDate);

                plotDates.put("UserSelectedStartDate", new Date[]{startDate});
                plotDates.put("UserSelectedEndDate", new Date[]{endDate});
            } catch (ParseException ex) {
                JOptionPane.showMessageDialog(Menu.this, "Invalid date format. Please use MM-dd-yyyy HH:mm");
            }

            plotter.updateSeries(plotData, plotDates);
        });

        panelInf.add(plotButton);

        add(panelMain);
    }
}



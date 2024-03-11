package org.example;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.io.IOException;
import java.text.ParseException;
import javax.swing.*;

public class Menu extends JFrame{
    public DataContainer dataContainer;
    private JCheckBox[] variableCheckBoxes;
    private JRadioButton[] optionCheckBoxes;
    private JTextField date;
    private JTextField date2;

    public Menu(DataContainer dataContainer) throws ParseException, IOException {
        this.dataContainer = dataContainer;
        initComponents();
    }

    private void initComponents() throws IOException, ParseException {
        String minDate = (dataContainer.getTimeStrings())[0];
        String maxDate = (dataContainer.getTimeStrings())[dataContainer.getTimeStrings().length - 1];

        setTitle("Projet Green");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        setLocation(100, 100);
        setSize(new Dimension(1300, 400));

        Container contentPane = getContentPane();
        GridBagLayout bagGrid = new GridBagLayout();
        contentPane.setLayout(bagGrid);

        GridBagConstraints c = new GridBagConstraints();

        c.insets = new Insets(10, 10, 10, 10);
        JLabel label2 = new JLabel(" Date range " + minDate + " to " + maxDate + ";");
        JLabel label3 = new JLabel(" Initial date (format: yyyy-mm-dd HH:mm)");
        JLabel label4 = new JLabel("Final date (format: yyyy-mm-dd HH:mm)");
        c.gridx = 1;

        contentPane.add(label2, c);
        c.gridx = 1;
        c.gridy = 1;

        contentPane.add(label3, c);
        c.gridx = 2;
        c.gridy = 1;

        contentPane.add(label4, c);
        date = new JTextField();
        c.gridx = 1;
        c.gridy = 2;
        c.ipadx = 150;

        contentPane.add(date, c);
        date2 = new JTextField();
        c.gridx = 2;
        c.gridy = 2;
        c.ipadx = 150;

        contentPane.add(date2, c);
        JButton button = new JButton("Plot");
        c.gridx = 1;
        c.gridy = 3;

        contentPane.add(button, c);
        JPanel pbox = new JPanel();
        pbox.setLayout(new BoxLayout(pbox, BoxLayout.Y_AXIS));

        this.variableCheckBoxes = new JCheckBox[dataContainer.getNumberOfVariables()];

        for (int i = 0; i < dataContainer.getNumberOfVariables(); i++) {
            this.variableCheckBoxes[i] = new JCheckBox(dataContainer.getAvailableVariables()[i]);
            pbox.add(this.variableCheckBoxes[i]);
        }

        c.gridx = 0;
        c.gridy = 1;
        contentPane.add(pbox, c);

        String[] timeIntervals = {"Day", "Hour", "Month"};
        JPanel DHM = new JPanel();
        DHM.setLayout(new BoxLayout(DHM, BoxLayout.Y_AXIS));
        ButtonGroup optionButtonGroup = new ButtonGroup();

        this.optionCheckBoxes = new JRadioButton[timeIntervals.length];

        for (int i = 0; i < timeIntervals.length; i++) {
            this.optionCheckBoxes[i] = new JRadioButton(timeIntervals[i]);
            optionButtonGroup.add(this.optionCheckBoxes[i]);
            DHM.add(this.optionCheckBoxes[i]);
        }

        this.optionCheckBoxes[1].setSelected(true);

        c.gridx = 3;
        c.gridy = 1;

        contentPane.add(DHM, c);
        button.addActionListener(new PlotProcessor(this.dataContainer,minDate, maxDate, date,date2,optionCheckBoxes,variableCheckBoxes));

        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
    }
}
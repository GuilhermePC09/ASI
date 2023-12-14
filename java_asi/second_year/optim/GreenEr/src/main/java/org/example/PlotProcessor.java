/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.example;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.swing.JCheckBox;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

public class PlotProcessor implements ActionListener{
    String minDate;
    String maxDate;
    JTextField dateinit;
    JTextField dateend;
    JRadioButton[] optionCheckBoxes;
    JCheckBox[] variableCheckBoxes;
    Plotter plotFactory;
    DataContainer dataContainer;

    public PlotProcessor(DataContainer dataContainer,String minDate, String maxDate,JTextField dateinit,JTextField dateend,JRadioButton[]  optionCheckBoxes,JCheckBox[] variableCheckBoxes) throws IOException, ParseException{
        this.dataContainer = dataContainer;
        this.plotFactory= new Plotter(dataContainer);
        this.optionCheckBoxes=optionCheckBoxes;
        this.variableCheckBoxes=variableCheckBoxes;
        this.minDate=minDate;
        this.maxDate=maxDate;
        this.dateinit=dateinit;
        this.dateend=dateend;
    }
    @Override
    public void actionPerformed(ActionEvent e) {
        try {
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date min = format.parse(this.minDate);
            Date max = format.parse(this.maxDate);
            Date dateinit = format.parse(this.dateinit.getText());
            Date dateend = format.parse(this.dateend.getText());
            if ((dateinit.after(min) || dateinit.equals(min)) && (dateend.before(max)|| dateend.equals(max))) {
                System.out.println( " YES!! the indicated date is included between the two dates");
                ArrayList<String> variableToKeep = new ArrayList();
                String option=null;
                for (JRadioButton optionCheckBoxe : optionCheckBoxes) {
                    if (optionCheckBoxe.isSelected()) {
                        option = optionCheckBoxe.getText();
                    }
                }

                for(JCheckBox variableCheckBoxe : variableCheckBoxes){
                    if (variableCheckBoxe.isSelected()){
                        variableToKeep.add(variableCheckBoxe.getText());
                    }
                }
                plotFactory.updateSeries(variableToKeep.toArray(new String[0]),dateinit,dateend,option);
            } else{
                System.err.println( " NO!! the indicated date is not included between the two dates");
            }

        } catch (ParseException ex) {
            System.err.println(" Date format ERROR!! Could you re-enter the date in the correct format? ");
        }

    }


}



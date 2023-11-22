package com.mycompany.serie;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class SerieTest {
    private Serie serie;

    @BeforeEach
    public void setUp() {
        serie = new Serie("TestSeries");
    }

    @Test
    public void testPopulate() {
        serie.populate(10, 400, 2500, false);
        assertEquals(10, serie.size());
    }

    @Test
    public void testSize() {
        assertEquals(0, serie.size());
        serie.populate(5, 400, 2500, false);
        assertEquals(5, serie.size());
    }

    @Test
    void testDeleteOutliers() {
        Serie mySerie = new Serie("TestSeries");
        mySerie.populate(100, 10, 500, true);
        int sizeBefore = mySerie.size();
        mySerie.deleteOutliers(0.5);
        int sizeAfter = mySerie.size();
    
        // Check that some outliers were removed
        assertTrue(sizeAfter < sizeBefore);
    }
}
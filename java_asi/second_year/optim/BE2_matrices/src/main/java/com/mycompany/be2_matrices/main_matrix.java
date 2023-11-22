package com.mycompany.be2_matrices;

public class main_matrix {

    public static void main(String[] args) {
        SparseMatrix sparseMatrix = new SparseMatrix(3, 4);
        DiagonalMatrix diag = new DiagonalMatrix(3);

        try {
            sparseMatrix.setValue(1, 3, -1);
            sparseMatrix.setValue(0, 1, 2);
            sparseMatrix.setValue(2, 1, 1);
            sparseMatrix.setValue(0, 0, 0);
            sparseMatrix.setValue(2, 1, 0);
            sparseMatrix.setValue(2, 4, -2);
        } catch (IllegalArgumentException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Other exceptions");
        } finally {
            try {
                diag.setValue(2, 2, 5);
                diag.setValue(1, 1, -9);
                diag.setValue(1, 2, 5);
            } catch (IllegalArgumentException e) {
                System.out.println("Error: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("Other exceptions");
            } finally {
                System.out.println(diag);
                SparseMatrix transposedMatrix = diag.transpose();
                System.out.println(transposedMatrix);
            }
        }
    }
}

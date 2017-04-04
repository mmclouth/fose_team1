/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

/**
 *
 * @author Kyle Anderson
 */
public class Payment {
    long cardNumber = -1;
    int cvv = -1;
    
    public Payment(String cardNumber, String cvv) {
        this.cardNumber = validateCardNumber(cardNumber);
        this.cvv = validateCVV(cvv);
    }
    
    private static long validateCardNumber(String cardNumber) {
        long validCard = -1;
        if(cardNumber.length() != 10) {
            return validCard;
        }
        try {
            validCard = Long.parseLong(cardNumber);
        } catch(NumberFormatException nfe) {
            validCard = -1;
            return validCard;
        }
        return validCard;
    }
    
    private static int validateCVV(String cvv) {
        int validCVV = -1;
        if(cvv.length() != 3)
        try {
            validCVV = Integer.parseInt(cvv);
        } catch(NumberFormatException nfe) {
            validCVV = -1;
            return validCVV;
        }
        return validCVV;
    }
    
}

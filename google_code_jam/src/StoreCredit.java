import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * Challenge: https://code.google.com/codejam/contest/351101/dashboard#s=p0
 * Small: Pass
 * Large: Pass
 */
public class StoreCredit {

	/**
	 * Run challenge
	 * @throws IOException
	 */
	public static void main() throws IOException {

		BufferedReader br = new BufferedReader(new FileReader("../A-large-practice.in"));
 
		int credit, numItems;
		String[] items;
		
		// Get number of testcases
		int tcases = Integer.parseInt(br.readLine());
		
		for(int i=0; i<tcases; i++) {
			
			// Get credit; number of items in shop; array of item prices
			credit = Integer.parseInt(br.readLine());
			numItems = Integer.parseInt(br.readLine());
			items = br.readLine().split(" ");
			
			/*
			 * For each item, loop through all the following items and calculate total price
			 * If original item price + looped item price total the credit, then print and break.
			 */
			ITEMS:
			for(int j=0; j<numItems-1; j++) {
				for(int k=j+1; k<numItems; k++) {
					if(Integer.parseInt(items[j]) + Integer.parseInt(items[k]) == credit) {
						System.out.println("Case #" + (i+1) + ": " + (j+1) + " " + (k+1));
						break ITEMS;
					}
				}
			}
		}
		
		br.close();
	}

}

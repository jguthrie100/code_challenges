import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Challenge: https://www.spotify.com/se/jobs/tech/reversed-binary/
 */
public class ReverseBinary {

	/**
	 * Run challenge
	 * @throws IOException
	 * @throws IndexOutOfBoundsException
	 */
	public static void main() throws IOException, IndexOutOfBoundsException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
 
		// Get reversed number
		int reverseNum = reverseNum(Integer.parseInt(br.readLine()));
		
		System.out.println(reverseNum);
		
		br.close();
	}
	
	/**
	 * Get the number that is a result of reversing the binary representation
	 * @param num Number to reverse
	 * @return Reversed number
	 * @throws IndexOutOfBoundsException
	 */
	public static int reverseNum(int num) throws IndexOutOfBoundsException {
		
		// Make sure input is within boundaries
		if(num < 1 || num > 1000000000) {
			throw new IndexOutOfBoundsException("Num must be between 1 - 1000000000");
		}
		
		int quotient = num;
		int remainder;
		String binary = "";
		int reverseNum = 0;
		
		// Keep dividing quotient by 2 until we get to 0
		// (based on http://answers.yahoo.com/question/index?qid=20121011022724AAeY2Lz )
		while(quotient > 0) {
			
			// Get remainder of dividing quotient by 2
			remainder = quotient % 2;
			
			// Get new quotient by dividing existing quotient by 2 (and chopping/flooring off decimal places)
			quotient = (int) Math.floor(quotient/2);
			
			// Add the remainder to the front of the binary string
			binary = remainder + binary;
		}
		
		/*
		 * Convert back into binary
		 * Based on http://answers.yahoo.com/question/index?qid=20121011022724AAeY2Lz
		 * Don't bother reversing string - just start conversion from the start (i.e. reverse the conversion process compared to whats in the link)
		 */
		for(int i = 0; i < binary.length(); i++) {
			reverseNum += Math.pow(2, i) *  Integer.parseInt(binary.charAt(i) + "");
		}

		return reverseNum;
	}

}

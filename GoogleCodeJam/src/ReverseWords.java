import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * Challenge: https://code.google.com/codejam/contest/351101/dashboard#s=p1
 * Small: Pass
 * Large: Pass
 */
public class ReverseWords {

	/**
	 * Run challenge
	 * @throws IOException
	 */
	public static void main() throws IOException{
		
		BufferedReader br = new BufferedReader(new FileReader("../B-large-practice.in"));
		
		// Get number of testcases
		int tcases = Integer.parseInt(br.readLine());
		String[] words;
		
		for(int i=0; i<tcases; i++) {
			
			// Get array of input words
			words = br.readLine().split(" ");
			
			System.out.print("Case #" + (i+1) + ":");
			
			// Loop backwards through array printing off each word
			for(int j=(words.length-1); j>=0; j--) {
				System.out.print(" " + words[j]);
			}
			
			System.out.println("");
		}
		
		br.close();

	}

}

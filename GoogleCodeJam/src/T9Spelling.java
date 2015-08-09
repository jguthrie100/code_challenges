import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;

/**
 * Challenge: https://code.google.com/codejam/contest/351101/dashboard#s=p2
 * Small: Pass
 * Large: Pass
 */
public class T9Spelling {

	/**
	 * Run challenge
	 * @throws IOException
	 */
	public static void main() throws IOException {
		
		// HashMap with each letter and corresponding keypad entry
		HashMap<String, String> keys = new HashMap<String, String>();
		
		keys.put("A", "2");
		keys.put("B", "22");
		keys.put("C", "222");
		keys.put("D", "3");
		keys.put("E", "33");
		keys.put("F", "333");
		keys.put("G", "4");
		keys.put("H", "44");
		keys.put("I", "444");
		keys.put("J", "5");
		keys.put("K", "55");
		keys.put("L", "555");
		keys.put("M", "6");
		keys.put("N", "66");
		keys.put("O", "666");
		keys.put("P", "7");
		keys.put("Q", "77");
		keys.put("R", "777");
		keys.put("S", "7777");
		keys.put("T", "8");
		keys.put("U", "88");
		keys.put("V", "888");
		keys.put("W", "9");
		keys.put("X", "99");
		keys.put("Y", "999");
		keys.put("Z", "9999");
		keys.put(" ", "0");
		
		BufferedReader br = new BufferedReader(new FileReader("../C-large-practice.in"));
		//BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		// Get number of testcases
		int tcases = Integer.parseInt(br.readLine());
		
		char[] chars;
		String key;
		String output = "";
		
		for(int i=0; i<tcases; i++) {
			
			// Split input into individual characters
			chars = br.readLine().toUpperCase().toCharArray();
			
			// Start of output
			output = "Case #" + (i+1) + ": ";
			
			// Loop through all characters and get the keypad entry for each one
			for(int j=0; j<chars.length; j++) {
				key = keys.get(chars[j] + "");
				
				// If current keypad num is the same as the previous keypad num then put a space in
				if(output.substring(output.length()-1).equals(key.substring(0,1))) {
					output += " ";
				}
				
				output += key;
			}
			
			System.out.println(output);
		}
		
		br.close();
	}

}

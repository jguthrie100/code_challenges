import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;

/**
 * Challenge: https://code.google.com/codejam/contest/32016/dashboard#s=p0
 * Small: Pass
 * Large: Fail
 */
public class MinimumScalarProduct {

	/**
	 * Run challenge
	 * @throws IOException
	 */
	public static void main() throws IOException {
		
		BufferedReader br = new BufferedReader(new FileReader("../A2-large-practice.in"));
	//	BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		// Get number of testcases
		int tcases = Integer.parseInt(br.readLine());
		int numScalars;
		long minScalar;
		
		// 2 new vector lists
		ArrayList<Integer> vector1 = new ArrayList<Integer>();
		ArrayList<Integer> vector2 = new ArrayList<Integer>();
		
		String[] readLine1, readLine2;
		
		for(int i=0; i<tcases; i++) {
			
			vector1.clear();
			vector2.clear();
			minScalar = 0;
			
			// Get number of scalars in each vector
			numScalars = Integer.parseInt(br.readLine());
			
			// Read both vectors
			readLine1 = br.readLine().split(" ");
			readLine2 = br.readLine().split(" ");
			
			// Convert String scalars into Integers and put in vector array
			for(int j=0; j<numScalars; j++) {
				vector1.add(Integer.parseInt(readLine1[j]));
				vector2.add(Integer.parseInt(readLine2[j]));
			}
			
			// Sort vectors numerically
			Collections.sort(vector1);
			Collections.sort(vector2);
			
			// Multiply highest num from vector 1 with lowest from vector2 and so on
			for(int j=0; j<numScalars; j++) {
				minScalar += (vector1.get(j)*vector2.get((numScalars-1)-j));
			}
			
			// Print output
			System.out.println("Case #" + (i+1) + ": " + minScalar);
		}
		
		br.close();

	}

}

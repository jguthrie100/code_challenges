import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Challenge: http://spc10.contest.scrool.se/problem?id=ladder
 */
public class Ladder {

	/**
	 * Run challenge
	 * @throws IOException
	 */
	public static void main() throws IOException {

		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
 
		String input[] = br.readLine().split(" ");
		
		// Get ladder length from function
		int ladderLength = calculateLadder(Integer.parseInt(input[0]), Integer.parseInt(input[1]));
		
		System.out.println(ladderLength);
		
		br.close();
	}
	
	/**
	 * Calculate length of ladder based on height of wall and the angle of the ladder to the floor
	 * @param height Height of the wall
	 * @param maxAngle Max angle of the ladder from the ground
	 * @return Minimum length that the ladder needs to be
	 */
	public static int calculateLadder(int height, int maxAngle) {
		// Get sin (of angle)
		double sin = Math.sin(Math.toRadians(maxAngle));
		
		// Ladder length = Height / Sin (of angle)
		return (int) Math.ceil(height / sin);
	}

}

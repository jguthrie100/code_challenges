import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Song class contains information for each song
 */
class Song {
	private int songNum;
	private int songPlayCount;
	private String songName;
	private double zipfQuality;
	
	/**
	 * Initialize Song
	 * @param songNum Number/Position of song in album
	 * @param songPlayCount How many times the song has been played
	 * @param songName Name of the song
	 */
	public Song(int songNum, int songPlayCount, String songName) {
		this.songNum = songNum;
		this.songPlayCount = songPlayCount;
		this.songName = songName;
	}
	
	public int getSongNum() {
		return songNum;
	}
	public int getSongPlayCount() {
		return songPlayCount;
	}
	public String getSongName() {
		return songName;
	}
	public double getZipfQuality() {
		return zipfQuality;
	}
	public void setZipfQuality(double zipfQuality) {
		this.zipfQuality = zipfQuality;
	}
}

/**
 * Comparator sorts list by ZipfQuality, then playlist order
 */
class ZipfQualityComparator implements Comparator<Song> {
	
	@Override
	public int compare(Song q1, Song q2) {
		
		// highest ZipfQuality sorted first
		if(q1.getZipfQuality() < q2.getZipfQuality()) {
			return 1;
		} else if(q1.getZipfQuality() > q2.getZipfQuality()) {
			return -1;
		} else {
			// If equal zipfQuality, then Lowest song num sorted first
			if(q1.getSongNum() > q2.getSongNum()) {
				return 1;
			} else {
				return -1;
			}
		}
	}
}

/**
 * Challenge: https://www.spotify.com/se/jobs/tech/zipfsong/
 */
public class ZipfsLaw {
	
	/**
	 * Run ZipfsLaw challenge
	 * @throws IOException
	 * @throws NumberFormatException
	 * @throws IllegalArgumentException
	 * @throws IndexOutOfBoundsException
	 */
	public static void main() throws IOException, NumberFormatException, IllegalArgumentException, IndexOutOfBoundsException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
 
		String[] stdin;
		String[] input;
		int numSongs;
		int numSongsToReturn;
		int i = 0;
		
		// Get first line and put values into relevant variables
		stdin = br.readLine().split(" ");
		numSongs = Integer.parseInt(stdin[0]);
		numSongsToReturn = Integer.parseInt(stdin[1]);
 
		// Create input array (put song playcount & song name in 2 separate cells)
		input = new String[numSongs*2];
		
		// Loop through songs and assign values into array
		while(i < input.length){
			stdin=br.readLine().split(" ");
			input[i++] = stdin[0];
			input[i++] = stdin[1];
		}
		
		// Get list of songs to print to stdout
		List<Song> songs = runZipf(input, numSongs, numSongsToReturn);

		// Print relevant number of sorted songs to stdout
		for(int j = 0; j < songs.size(); j++) {
			System.out.println(songs.get(j).getSongName());
		}
		
		br.close();
	}
	
	/**
	 * Create list of best songs based on ZipfsLaw
	 * @param input List of all all the songs, playcounts in input
	 * @param numSongs Number of songs in album
	 * @param numSongsToReturn Number of songs to return
	 * @return List of Songs ordered by the best first
	 * @throws NumberFormatException
	 */
	public static List<Song> runZipf(String[] input, int numSongs, int numSongsToReturn) throws NumberFormatException {

		// Create ArrayList of songs
		List<Song> songs = new ArrayList<Song>(numSongs);
		
		// Put 1 song (made up of 2 args) in each cell
		for(int i = 0; i < numSongs; i++) {
			songs.add(i, new Song(i, Integer.parseInt(input[i*2]), input[(i*2)+1]));
		}
		
		/*
		 * Expected play count (based on Zipfs law) = 1/i (i.e. 1/1, 1/2, 1/3, 1/4 )
		 *   in real terms (first song has 30 plays):       30/1, 30/2, 30/3, 30/4
		 * Zipfs law quality = playCount / expectedPlayCount
		 */
		double zipfLaw;
		for(int i = 0; i < numSongs; i++) {
			// Work out zipfLaw base don songs position in list
			zipfLaw = (double) songs.get(0).getSongPlayCount()/(i+1);
			
			// Update the ZipfQuality of each Song object
			songs.get(i).setZipfQuality(songs.get(i).getSongPlayCount()/zipfLaw);
		}
		
		/*
		 * Sort Songs using Comparator
		 * Sort by Zipf quality then playlist order
		 */
		Collections.sort(songs, new ZipfQualityComparator());
		
		// Return relevant number of songs from the front of the sorted list
		return songs.subList(0, numSongsToReturn);
	}

}

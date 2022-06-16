package Solution;
import java.io.*;
import java.util.HashSet;
import java.util.ArrayList;

public class Solution {
	private static int freq = 0;
	private static HashSet<Integer> freqs = new HashSet<Integer>();
	private static ArrayList<Integer> freqChanges = new ArrayList<Integer>();
	private static String line;
	public static void main(String[] args) throws FileNotFoundException, IOException {
		FileReader fr = new FileReader("./input");
		BufferedReader reader = new BufferedReader(fr);
		while((line=reader.readLine()) != null) {
			int direction = (line.charAt(0) == '+') ? 1 : -1;
			int magnitude = Integer.parseInt(line.substring(1));
			freq += magnitude * direction;
			if (freqs.contains(freq)) {
				System.out.println(freq);
				System.exit(1);
			}
			else {
				freqs.add(freq);
				freqChanges.add(magnitude * direction);
			}
		}
		// If we reach this point we have to loop over the changes repeatedly until we find the dup
		while(true) {
			for (int f : freqChanges) {
				freq += f;
				if (freqs.contains(freq)) {
					System.out.println(freq);
					System.exit(1);
				}
			}
		}
	}
}

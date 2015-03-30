import java.lang.Math;

public class Optimal100Doors {
	private static boolean isPerfectSquare(int num) {
		if (num < 0) {
			return false;
		}

		int sqrt = (int)(Math.sqrt(num) + 0.5);
		return (sqrt * sqrt == num);
	}

	private static void displayStatus(boolean[] doors) {
		System.out.println("The following doors are closed: " );
		for (int door = 0; door < doors.length; door++) {
			if (doors[door] == true) {
				System.out.print((door + 1) + " ");
			}
		}
		System.out.println();
		System.out.println("The following doors are open: " );
		for (int door = 0; door < doors.length; door++) {
			if (doors[door] == false) {
				System.out.print((door + 1) + " ");
			}
		}
		System.out.println();
	}

	public static void main(String[] args) {
		int DOOR_CNT = 100;
		int ITER_CNT = 125;
		boolean doors[] = new boolean[DOOR_CNT];

		for (int door = 0; door < doors.length; door++) {
		/*
			The following table gives the truth table for this logic:
                        ______________________________________________________________________________________________________________________
                        |                                   |                                                            |                   |
                        |* Is (door + 1) a perfect square? *|* Is (door + 1) less than or equal to Number of iterations *|* Is Door Closed? *|
                        |___________________________________|____________________________________________________________|___________________|
                        |               true                |                          true                              |       true        |
                        |               false               |                          true                              |       false       |
                        |               true                |                          false                             |       false       |
                        |               false               |                          false                             |       true        |
                        |___________________________________|____________________________________________________________|___________________|

			As can be seen, this follows XNOR logic.
		*/
			doors[door] = (isPerfectSquare(door + 1) == (door + 1 <= ITER_CNT));
		}
		displayStatus(doors);
	}
}


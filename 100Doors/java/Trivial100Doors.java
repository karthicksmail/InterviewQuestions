public class Trivial100Doors {
	public static void displayStatus(boolean[] doors) {
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
		final int DOOR_CNT = 100;
		boolean doors[] = new boolean[DOOR_CNT];

		for (int iter = 1; iter <= doors.length; iter++) {
			for (int door = 0; door < doors.length; door++) {
				int doorNum = door + 1;
				if (doorNum % iter == 0) {
					doors[door] = !(doors[door]);
				}
			}
			//displayStatus(doors);
		}
		displayStatus(doors);
	}
}


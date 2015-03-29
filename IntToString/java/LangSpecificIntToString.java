public class LangSpecificIntToString {
	public static void main(String[] args) {
		int num = 123456;
		String numAsString1 = "" + num;
		System.out.println("The string representation of " + num + " using concatenation is " + numAsString1);
		String numAsString2 = ((Integer)num).toString();
		System.out.println("The string representation of " + num + " using conversion is " + numAsString2);
	}
}


public class NonLangSpecificIntToString {
	public static String toString(int num) {
		String strNum = "";
		boolean neg = false;
		if (num < 0) {
			neg = true;
			num = -num;
		}
		while(num > 0) {
			strNum = "" + (num % 10) + strNum;
			num = num / 10;
		}
		if (neg) {
			strNum = "-" + strNum;
		}
		return strNum;
	}

	public static void main(String[] args) {
		int num = 123456;
		System.out.println("The string representation of " + num + " is " + toString(num));
	}
}

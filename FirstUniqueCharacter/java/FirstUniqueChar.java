import java.util.LinkedHashSet;
import java.util.HashSet;
import java.util.Set;
import java.util.NoSuchElementException;

public class FirstUniqueChar {
	/**
	 * 
	*/
	public static Character findFirstUniqueChar(String givenString) {
		Set<Character> uniqCharSet = new LinkedHashSet<Character>();
		Set<Character> nonUniqCharSet = new HashSet<Character>();

		try {
			if (givenString == null) {
				return null;
			}
			for (Character ch:givenString.toUpperCase().toCharArray()) {
				if (nonUniqCharSet.contains(ch)) {
					continue;
				} else if (uniqCharSet.contains(ch)) {
					uniqCharSet.remove(ch);
					nonUniqCharSet.add(ch);
				} else {
					uniqCharSet.add(ch);
				}
			}
			return uniqCharSet.iterator().next();
		} catch (NoSuchElementException ex) {
			return null;
		}
	}

	public static void main(String[] args) {
		String randomString = "ABCJDOKJLK@JLKCFJLDVKJlfdkjgdfg87qp21oke;l'lldsadkj;laskdfjlsadjfkasldkfjasldflj23lkjfads8vslkdfl;sajkdf";
		System.out.println(findFirstUniqueChar(randomString));
		randomString = "Hello World! Hello World!";
		System.out.println(findFirstUniqueChar(randomString));
		randomString = null;
		System.out.println(findFirstUniqueChar(randomString));
		randomString = "Póki Kiedy winem konno gdzie uwagi Białopiotrowiczem oboje. Mylił złoty niesą stało Rzeczpospolita rękę prapradziadów nieuszanowanie rekami biała wierne. Rostrzygnijcie inni wasz wié kity szli zaczerwienione rzeźbiarstwie francuszczyzny cię niezwyczajnéj nieuszanowanie dama Lecz. Nawet jadą skarb kopie Szmer tęgi drzew koniu.";
		System.out.println(findFirstUniqueChar(randomString));
	}
}


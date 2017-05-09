package palmos;

/**
 * This class converts from Java-style String[] arrays to 
 * C-style char*[] vectors as used by LstSetListChoices.
 * <p>
 * Usage:
 * <pre>
 * static CharPtrArray charPtrs;
 * ...
 * if (charPtrs == null) {
 *     choices = new String[3];
 *     choices[0] = "Fish";
 *     choices[1] = "Halibut";
 *     choices[2] = "Marlin";
 *
 *     charPtrs = new CharPtrArray(choices);
 *
 *     Palm.LstSetListChoices(fldMyList, charPtrs, charPtrs.size());
 * }
 * 
 * </pre>
 * <p>
 * CAVEAT: The garbage collector can't see whether an instance of 
 * this class is still in use by PalmOS, so you have to keep a reference
 * to the instance in a Java variable as long as the choices are relevant
 * for PalmOS (see field 'charPtrs' above).
 */
public final class CharPtrArray {

  /** 
   * the C-type char*[] array (represented as an int). 
   * THIS MUST BE THE FIRST INSTANCE FIELD IN THIS CLASS!
   */
  private int cArray;

  /** the dummy array whose data is re-used for cArray. */
  private int[] dummyArray;

  /** the Java array. */
  private String[] texts;

  /** constructs a new CharPtrArray instance with the given strings as its content. */
  public CharPtrArray (String[] texts) {
    this.texts = texts;
    dummyArray = new int[texts.length];
    makeCArray();
  }

  /** returns the texts. */
  public String[] getTexts() {
    return texts;
  }

  /** returns the number of elements. */
  public int size() {
    return texts.length;
  }

  /** constructs a char*[] C-array from a String[] Java array. */
  protected native void makeCArray();
}

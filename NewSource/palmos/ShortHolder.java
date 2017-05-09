package palmos;

public final class ShortHolder {

  /** the 16-bit short value. */
  public short value;

  /** constructs a new ShortHolder instance with zero value. */
  public ShortHolder () {
    this.value = (short) 0;
  }

  /** constructs a new ShortHolder instance with the given value. */
  public ShortHolder (short value) {
    this.value = value;
  }
}

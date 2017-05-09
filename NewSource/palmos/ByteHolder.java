package palmos;

public final class ByteHolder {

  /** the 8-bit byte value. */
  public byte value;

  /** constructs a new ByteHolder instance with zero value. */
  public ByteHolder () {
    this.value = (byte) 0;
  }

  /** constructs a new ByteHolder instance with the given value. */
  public ByteHolder (byte value) {
    this.value = value;
  }
}

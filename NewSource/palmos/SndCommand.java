package palmos;

/**
 * A PalmOS sound command block.
 */
public class SndCommand {
  public byte cmd;
  public int param1;
  public short param2;
  public short param3;

  /** 
   * no-args default constructor (just for compatibility reasons)
   */
  public SndCommand()
  {
  }

  /**
   * creates a blocking sound command with given parameters.
   *
   * @param freqHz      frequency in Hertz
   * @param timeMillis  duration in milli-seconds
   * @param amplPercent amplitude in percent
   */
  public SndCommand (int freqHz, int timeMillis, int amplPercent)
  {
    setParams (freqHz, timeMillis, amplPercent);
  }

  /**
   * sets the sound command to the given parameters.
   *
   * @param freqHz      frequency in Hertz
   * @param timeMillis  duration in milli-seconds
   * @param amplPercent amplitude in percent
   */
  public void setParams (int freqHz, int timeMillis, int amplPercent)
  {
    cmd = 1;
    param1 = freqHz;
    param2 = (short) timeMillis;
    param3 = (short) (1 + (amplPercent * 62) / 100);
  }
}

/**
 * A class that supports on-line-playing of Morse code.
 */

public class MorseProducer {

  /** The plain text to be produced as morse code. */
  protected String plainText;
  
  /** The position of the character that the next sound belongs to. */
  protected int textPos;

  /** 
   * The sequence of sounds for the current character. 
   * String of dots and dashes and spaces.
   */
  protected String nextSound;

  /** The index of the next sound within the current character's sounds. */
  protected int soundPos;

  /** The tick-number when the next sound has to be started. */
  protected int nextTick;

  /** 
   * Flag: the sound that the 'play pointer' points at, has already
   * been consumed.
   */
  protected boolean consumed = false;

  /** Flag: production in progress. */
  protected boolean running = false;

  /** The number of ticks for a single dit. */
  protected int ditTicks = 10;

  /**
   * The sounds for the characters.
   * Array index 0 corresponds to the Space character.
   * Besides dots and dashes, a Space means a pause, 
   * an 'x' marks a non-morse character.
   */
  String codes[] = 
  {"x", "x", "x", "x", "x", "x", "x", "x", 
   "x", "x", "x", "x", "x", "x", "x", "x", 
   "x", "x", "x", "x", "x", "x", "x", "x", 
   "x", "x", "x", "x", "x", "x", "x", "x", 
   " ", "x", ".-..-.", "x", "x", "x", "x", ".----.", 
   "-.--.-", "-.--.-", "x", "x", "--..--", "-....-", ".-.-.-", "-..-.", 
   "-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...",
   "---..", "----.", "---...", "x", "x", "x", "x", "..--..", 
   "x", ".-", "-...", "-.-.", "-..", ".", "..-.", "--.",
   "....", "..", ".---", "-.-", ".-..", "--", "-.", "---",
   ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--",
   "-..-", "-.--", "--..", "x", "x", "x", "x", "x", 
   "x", ".-", "-...", "-.-.", "-..", ".", "..-.", "--.",
   "....", "..", ".---", "-.-", ".-..", "--", "-.", "---",
   ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--",
   "-..-", "-.--", "--..", "x", "x", "x", "x", "x"};


  /** 
   * Initialize morse code production.
   * @param text      the text to be converted.
   * @param startTick the current tick-number when starting.
   */
  void startProduction(String text, int startTick)
  {
    plainText = text;
    nextTick = startTick + ditTicks;
    textPos = 0;
    nextSound = convert(text.charAt(0));
    soundPos = 0;
    consumed = false;
    running = true;
  }

  /**
   * Check for the producer being running.
   */
  public boolean isRunning()
  {
    return running;
  }

  /**
   * Return the tick-number when the next sound should be started.
   */
  int getNextTick ()
  {
    if (!running) {
      return -1;
    }
    while (consumed) {
      switch (nextSound.charAt(soundPos)) {
      case ' ': 
	nextTick +=  2*ditTicks; 
	break;
      case '.': 
	nextTick +=  2*ditTicks; 
	break;
      case '-': 
	nextTick +=  4*ditTicks; 
	break;
      case 'x': 
	nextTick += 11*ditTicks;
	break;
      }
      soundPos++;
      if (soundPos >= nextSound.length()) {
	nextTick += 2*ditTicks;
	textPos++;
	if (textPos >= plainText.length()) {
	  running = false;
	  return -1;
	}
	nextSound = convert(plainText.charAt(textPos));
	soundPos = 0;
      }
      consumed = (nextSound.charAt(soundPos) == ' ');
    }
    return nextTick;
  }

  /**
   * Ask for the next sound to be played now. 
   * Calling this method advances the 'play pointer' to the next sound.
   * With the parameter 'tickNow', the caller tells the converter
   * the current time, thus allowing it to take care of unforeseen delays.
   *
   * @param tickNow the current tick-number, now that the sound will start playing.
   * @return        the sound duration in ticks.
   */
  int playNow(int tickNow)
  {
    consumed = true;
    nextTick = tickNow;
    switch (nextSound.charAt(soundPos)) {
    case '.': return    ditTicks;
    case '-': return  3*ditTicks;
    case 'x': return 10*ditTicks;
    default:  return           0;
    }
  }

  /**
   * Convert character to string describing the sound. 
   */
  public String convert (char ch)
  {
    int unicode = (int) ch;
    
    if (unicode < codes.length) {
      return codes[unicode];
    }
    else {
      return "x";
    }
  }

}

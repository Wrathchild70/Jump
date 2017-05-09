import palmos.*;

public class Morse {
  static final int MAIN_FORM_ID       = 1000;
  static final int CONVERT_BUTTON_ID  = 1010;
  static final int TEXT_FIELD_ID      = 1011;

  protected int textField;

  /** Morse-code produce engine. */
  MorseProducer producer = new MorseProducer();

  /** PalmOS sound command block. */
  SndCommand sndCom = new SndCommand();

  /** flag: we are playing a melody */
  boolean running = false;
  
  /** the next position in the melody to be processed */
  int nextPosition = 0;

  public static int PilotMain(int cmd, int cmdBPB, int launchFlags)
  {
    if (cmd == 0) {
      new Morse().run();
    }
    return 0;
  }

  public void run()
  {
    int delay;

    running = false;

    Palm.FrmGotoForm(MAIN_FORM_ID);
    Event e = new Event();
    ShortHolder err = new ShortHolder((short)0);
    while (e.eType != Event.appStopEvent) {
      if (producer.isRunning()) {
        int next = producer.getNextTick();
        int now = Palm.TimGetTicks();
        if (now >= next) {
          playSound (producer.playNow (now));
          next = producer.getNextTick();
          now = Palm.TimGetTicks();
        }
        delay = next - now;
      }
      else {
        delay = -1;
      }
      Palm.EvtGetEvent(e, delay);
      if (!Palm.SysHandleEvent(e)) {
        if (!Palm.MenuHandleEvent(0, e, err)) {
          if (!appHandleEvent(e)) {
            Palm.FrmHandleEvent(Palm.FrmGetActiveForm(), e);
          }
        }
      }
    }
    Palm.FrmCloseAllForms();
  }

  boolean appHandleEvent(Event e)
  {
    if (e.eType == Event.frmLoadEvent) {
      int form = Palm.FrmInitForm(e.formID());
      Palm.FrmSetActiveForm(form);
      textField = Palm.FrmGetObjectPtr(form, Palm.FrmGetObjectIndex(form, TEXT_FIELD_ID));
      return true;
    }
    else if (e.eType == Event.frmOpenEvent) {
      Palm.FrmDrawForm(Palm.FrmGetActiveForm());
      return true;
    }
    else if (e.eType == Event.ctlSelectEvent) {
      if (e.controlID() == CONVERT_BUTTON_ID) {
        if (Palm.FldDirty(textField))
        {
          String text = Palm.FldGetTextPtr(textField);
          if ( text.length() > 0 )
            producer.startProduction (text, Palm.TimGetTicks());
        }
        return true;
      }
    }
    
    return false;
  }

  void playSound (int ticks)
  {
    sndCom.setParams (800, 10*ticks, 100);
    Palm.SndDoCmd (null, sndCom, false);
  }

}

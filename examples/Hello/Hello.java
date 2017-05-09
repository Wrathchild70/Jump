import palmos.*;

class Hello {
  static final int idfMain = 1000;

  public static int PilotMain(int cmd, int cmdBPB, int launchFlags)
  {
    if (cmd != 0) {
      return 0;
    }

    Palm.FrmGotoForm(idfMain);

    Event e = new Event();
    ShortHolder err = new ShortHolder((short)0);
    while (e.eType != Event.appStopEvent) {
      Palm.EvtGetEvent(e, -1);
      if (!Palm.SysHandleEvent(e)) {
        if (!Palm.MenuHandleEvent(0, e, err)) {
          if (!appHandleEvent(e)) {
            Palm.FrmHandleEvent(Palm.FrmGetActiveForm(), e);
          }
        }
      }
    }
    Palm.FrmCloseAllForms();
    return 0;
  }

  static boolean appHandleEvent(Event e)
  {
    if (e.eType == Event.frmLoadEvent) {
      int form = Palm.FrmInitForm(e.formID());
      Palm.FrmSetActiveForm(form);
      return true;
    } else if (e.eType == Event.frmOpenEvent) {
      Palm.FrmDrawForm(Palm.FrmGetActiveForm());
      return true;
    }
    return false;
  }
}

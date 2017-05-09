import palmos.*;

class DecHex {
  static final int kidfMain = 1000;
  static final int kidmMain = 1000;

  static final int kidmAbout   = 1002;
  static final int kidcConvert = 1003;
  static final int kidcDecimal = 1004;
  static final int kidcHex     = 1005;

  static final int kidrAboutAlert      = 1000;
  static final int kidrInputErrorAlert = 1001;
  static final int kidrRangeErrorAlert = 1002;

  static int fldDecimal;
  static int fldHex;

  public static int PilotMain(int cmd, int cmdBPB, int launchFlags)
  {
    if (cmd != 0) {
      return 0;
    }

    Palm.FrmGotoForm(kidfMain);
    Event e = new Event();
    ShortHolder err = new ShortHolder((short) 0);
    while (e.eType != Event.appStopEvent) {
      Palm.EvtGetEvent(e, -1);
      if (!Palm.SysHandleEvent(e)) {
        if (!Palm.MenuHandleEvent(0, e, err)) {
          if (!ApplicationHandleEvent(e)) {
            if (!MainFormHandleEvent(e)) {
              Palm.FrmHandleEvent(Palm.FrmGetActiveForm(), e);
            }
          }
        }
      }
    }
    Palm.FrmCloseAllForms();
    return 0;
  }

  static boolean ApplicationHandleEvent(Event e)
  {
    if (e.eType == Event.frmLoadEvent) {
      int form = Palm.FrmInitForm(e.formID());
      Palm.FrmSetActiveForm(form);
      fldDecimal = Palm.FrmGetObjectPtr(form, Palm.FrmGetObjectIndex(form, kidcDecimal));
      fldHex     = Palm.FrmGetObjectPtr(form, Palm.FrmGetObjectIndex(form, kidcHex));
      return true;
    }
    return false;
  }

  static boolean MainFormHandleEvent(Event e)
  {
    if (e.eType == Event.frmOpenEvent) {
      Palm.FrmDrawForm(Palm.FrmGetActiveForm());
      return true;
    } else if (e.eType == Event.menuEvent) {
      if (e.itemID() == kidmAbout) {
        Palm.FrmAlert(kidrAboutAlert);
        return true;
      }
    } else if (e.eType == Event.ctlSelectEvent) {
      if (e.controlID() == kidcConvert) {
        Convert();
        return true;
      }
    }
    return false;
  }

  static void Convert()
  {
    if (Palm.FldDirty(fldDecimal)) {
      String s = Palm.FldGetTextPtr(fldDecimal);
      if (s == null) {
        Palm.FrmAlert(kidrInputErrorAlert);
        return;
      }
      try {
        Integer i = Integer.valueOf(s);
        Palm.FldFreeMemory(fldHex);
        String t = Integer.toHexString(i.intValue());
        Palm.FldInsert(fldHex, t, t.length());
      } catch (NumberFormatException nfe) {
        Palm.FrmAlert(kidrInputErrorAlert);
      }
    } else if (Palm.FldDirty(fldHex)) {
      String s = Palm.FldGetTextPtr(fldHex);
      if (s == null) {
        Palm.FrmAlert(kidrInputErrorAlert);
        return;
      }
      try {
        Integer i = Integer.valueOf(s, 16);
        Palm.FldFreeMemory(fldDecimal);
        String t = String.valueOf(i.intValue());
        Palm.FldInsert(fldDecimal, t, t.length());
      } catch (NumberFormatException nfe) {
        Palm.FrmAlert(kidrInputErrorAlert);
      }
    }
    Palm.FldSetDirty(fldDecimal, false);
    Palm.FldSetDirty(fldHex, false);
  }
}

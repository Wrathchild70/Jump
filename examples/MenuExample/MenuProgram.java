/*
The MenuProgram.java is written by Noli Sicad and Ralf Kleberhoff
demonstrate the power of JUMP2 in implementing Palm OS Programs 
in Java without the virtual machine e.g. WabaVM, KVM etc.

Noveber 11, 2000
*/


import palmos.*;

public class MenuProgram 
{
  static final int FORM1_ID    = 1004;
  static final int FORM2_ID    = 1026;
  
  static final int BUTTON1_ID  = 1028;
  static final int BUTTON2_ID  = 1027;
  
  static final int MENU1     = 1042;
  static final int FirstMenu = 1043;
  static final int LastMenu  = 1064;
  static final int ItemMenuForm2 = 1061;
  static final int ItemAlertAbout = 1064;
  
  static final int ALERTID_ABOUT = 1063;

  static class Form1Handler extends FormEventHandler
  {
    public boolean callback(Event e)
    {
      if (e.eType == Event.frmOpenEvent) 
        Palm.FrmDrawForm(form);
      else if (e.eType == Event.menuEvent) 
        menuMainEvent(e);
      else if (e.eType == Event.ctlSelectEvent) 
      {
        if (e.controlID() == BUTTON1_ID) 
          Palm.FrmGotoForm(FORM2_ID);
        else
          return Palm.FrmHandleEvent(form, e);
      }
      else
        return Palm.FrmHandleEvent(form, e);
      return true;
    }
  
    boolean menuMainEvent(Event e )
    {
      int id = e.itemID();
      if ( id == ItemMenuForm2) 
      {
        Palm.FrmGotoForm(FORM2_ID);
        return true;
      }
      else if ( id == ItemAlertAbout) 
      {
        Palm.FrmAlert(ALERTID_ABOUT);
        return true;
      }
      return false;
    }
  }

  static class Form2Handler extends FormEventHandler
  {
    public boolean callback(Event e)
    {
      if (e.eType == Event.frmOpenEvent) 
        Palm.FrmDrawForm(Palm.FrmGetFormPtr(FORM2_ID));
      else if (e.eType == Event.ctlSelectEvent) 
      {
        if (e.controlID() == BUTTON2_ID) 
          Palm.FrmGotoForm(FORM1_ID);
        else
          return Palm.FrmHandleEvent(form, e);
      }
      return Palm.FrmHandleEvent(form, e);
    }
  }

  public static int PilotMain(int cmd, int cmdBPB, int launchFlags)
  {
    if (cmd == 0) 
      run();
    return 0;
  }

  public static void run()
  {
    Palm.FrmGotoForm(FORM1_ID);
    Event e = new Event();
    ShortHolder err = new ShortHolder((short)0);
    while (e.eType != Event.appStopEvent) 
    {
      Palm.EvtGetEvent(e, 0);
      if (!Palm.SysHandleEvent(e)) 
      {
        if (!Palm.MenuHandleEvent(0, e, err)) 
        {
          if (!appHandleEvent(e)) 
          {
            Palm.FrmDispatchEvent(e);
          }
        }
      }
    }
    feh = null;
    Palm.FrmSetEventHandler( form, null );
    Palm.FrmCloseAllForms();
  }

  static FormEventHandler feh;
  static int form;

  static boolean appHandleEvent(Event e)
  {
    if (e.eType == Event.frmLoadEvent) 
    {
      int formID = e.formID();
      form = Palm.FrmInitForm(formID);
      Palm.FrmSetActiveForm(form);
      if ( formID == FORM1_ID )
        feh = new Form1Handler();
      else if ( formID == FORM2_ID )
        feh = new Form2Handler();
      else
        return false;
      Palm.FrmSetEventHandler( form, feh );
    }
    return false;
  }
}

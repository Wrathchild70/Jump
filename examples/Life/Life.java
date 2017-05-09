import palmos.*;

class Life {
  static final int idfMain  = 1000;
  static final int idfAbout = 1100;

  static final int idcStep  = 1010;
  static final int idcRun   = 1011;
  static final int idcStop  = 1012;
  static final int idcAbout = 1019;

  static final int XSIZE = 20;
  static final int YSIZE = 18;
  static final int CELLSIZE = 8;

  byte Boards[][][];
  int dispboard;
  byte dragstate;
  boolean running;

  Rectangle r = new Rectangle();

  public static int PilotMain(int cmd, int cmdBPB, int launchFlags)
  {
    if (cmd == 0) {
      new Life().run();
    }
    return 0;
  }

  public void run()
  {
    Boards = new byte[2][YSIZE+2][XSIZE+2];

    dispboard = 0;
    running = false;

    Palm.FrmGotoForm(idfMain);
    Event e = new Event();
    ShortHolder err = new ShortHolder((short)0);
    while (e.eType != Event.appStopEvent) {
      Palm.EvtGetEvent(e, running ? 10 : -1);
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
      return true;
    } else if (e.eType == Event.frmOpenEvent) {
      Palm.FrmDrawForm(Palm.FrmGetActiveForm());
      return true;
    } else if (e.eType == Event.penDownEvent || e.eType == Event.penMoveEvent) {
      int x = e.screenX / CELLSIZE + 1;
      int y = e.screenY / CELLSIZE + 1;
      if (x >= 1 && x <= XSIZE && y > 0 && y <= YSIZE) {
        if (e.eType == Event.penDownEvent) {
          dragstate = (byte)(Boards[dispboard][y][x] ^ 1);
        }
        Boards[dispboard][y][x] = dragstate;
        drawCell(x, y, dragstate);
        return true;
      }
    } else if (e.eType == Event.ctlSelectEvent) {
      if (e.controlID() == idcStep) {
        step();
        return true;
      } else if (e.controlID() == idcRun) {
        step();
        running = true;
        return true;
      } else if (e.controlID() == idcStop) {
        running = false;
        return true;
      } else if (e.controlID() == idcAbout) {
        Palm.FrmAlert(idfAbout);
      }
    } else if (running && e.eType == Event.nilEvent) {
      step();
      return true;
    }
    return false;
  }

  void step()
  {
    int newboard = dispboard ^ 1;
    int changes = 0;
    for (int y = 1; y <= YSIZE; y++) {
      for (int x = 1; x <= XSIZE; x++) {
        int n = neighbors(Boards[dispboard], x, y);
        byte state;
        if (Boards[dispboard][y][x] != 0) {
          state = (byte)(n == 2 || n == 3 ? 1 : 0);
          if (state == 0) {
            drawCell(x, y, (byte)0);
            changes++;
          }
        } else {
          state = (byte)(n == 3 ? 1 : 0);
          if (state != 0) {
            drawCell(x, y, (byte)1);
            changes++;
          }
        }
        Boards[newboard][y][x] = state;
      }
    }
    dispboard = newboard;
    if (changes == 0) {
      running = false;
    }
  }

  int neighbors(byte[][] board, int x, int y)
  {
    return board[y-1][x-1] + board[y-1][x] + board[y-1][x+1]
         + board[y  ][x-1] +                 board[y  ][x+1]
         + board[y+1][x-1] + board[y+1][x] + board[y+1][x+1];
  }

  void drawCell(int x, int y, byte on)
  {
    r.topLeft_x = (short)((x-1)*CELLSIZE);
    r.topLeft_y = (short)((y-1)*CELLSIZE);
    r.extent_x = (short)(CELLSIZE);
    r.extent_y = (short)(CELLSIZE);
    if (on != 0) {
      Palm.WinDrawRectangle(r, CELLSIZE/2);
    } else {
      Palm.WinEraseRectangle(r, CELLSIZE/2);
    }
  }
}

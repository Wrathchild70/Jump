package palmos;

public class Event {
  public static final short nilEvent              = 0;
  public static final short penDownEvent          = 1;
  public static final short penUpEvent            = 2;
  public static final short penMoveEvent          = 3;
  public static final short keyDownEvent          = 4;
  public static final short winEnterEvent         = 5;
  public static final short winExitEvent          = 6;
  public static final short ctlEnterEvent         = 7;
  public static final short ctlExitEvent          = 8;
  public static final short ctlSelectEvent        = 9;
  public static final short ctlRepeatEvent        = 10;
  public static final short lstEnterEvent         = 11;
  public static final short lstSelectEvent        = 12;
  public static final short lstExitEvent          = 13;
  public static final short popSelectEvent        = 14;
  public static final short fldEnterEvent         = 15;
  public static final short fldHeightChangedEvent = 16;
  public static final short fldChangedEvent       = 17;
  public static final short tblEnterEvent         = 18;
  public static final short tblSelectEvent        = 19;
  public static final short daySelectEvent        = 20;
  public static final short menuEvent             = 21;
  public static final short appStopEvent          = 22;
  public static final short frmLoadEvent          = 23;
  public static final short frmOpenEvent          = 24;
  public static final short frmGotoEvent          = 25;
  public static final short frmUpdateEvent        = 26;
  public static final short frmSaveEvent          = 27;
  public static final short frmCloseEvent         = 28;
  // MRX changes for Jump 2.0.3
  public static final short frmTitleEnterEvent    = 29;
  public static final short frmTitleSelectEvent   = 30;
  public static final short tblExitEvent          = 31;
  public static final short sclEnterEvent         = 32;
  public static final short sclExitEvent          = 33;
  public static final short sclRepeatEvent        = 34;
  //
  public static final short tsmConfirmEvent       = 35;
  public static final short tsmFepButtonEvent     = 36;
  public static final short tsmFepModeEvent       = 37;
  
  public static final short menuCmdBarOpenEvent   = 0x0800;
  public static final short menuOpenEvent         = 0x0801;
  public static final short menuCloseEvent        = 0x0802;
  public static final short frmGadgetEnterEvent   = 0x0803;
  public static final short frmGadgetMiscEvent    = 0x0804;
  public static final short firstINetLibEvent     = 0x1000;
  public static final short firstWebLibEvent      = 0x1100;
  // <chg 10/9/98 SCL> Changed firstUserEvent from 32767 (0x7FFF) to 0x6000
  // Enums are signed ints, so 32767 technically only allowed for ONE event.
  public static final short firstUserEvent        = 0x6000;
  // MRx Added
  public static final short lastUserEvent        = 0x7FFF;
  
  // Symbol Scanner events
  public static final int scanDecodeEvent		= 0x87FF;
  public static final int scanBatteryErrorEvent	= 0x8800;
  public static final int scanTriggerEvent		= 0x8801;
  public static final int s24BatteryErrorEvent  = 0x8802;
  public static final int scanSymbolRFUAEvent  = 0x8803;
  public static final int scanSymbolRFUBEvent  = 0x8804;
  public static final int scanSymbolRFUCEvent  = 0x8805;
  public static final int scanSymbolRFUDEvent  = 0x8806;
  public static final int scanSymbolRFUEEvent  = 0x8807;
  public static final int scanSymbolRFUFEvent  = 0x8808;
  public static final int scanSymbolRFUGEvent  = 0x8809;
  public static final int scanSymbolRFUHEvent  = 0x880A;
  public static final int wanLowBatteryEventEvent  = 0x880B;
  public static final int wanBatteryErrorEvent  = 0x880C;
   
  public short eType;
  public boolean penDown;
  public byte tapCount; /* PMD added 2.0.3 */
  public short screenX;
  public short screenY;
  public short data1;
  public short data2;
  public short data3;
  public short data4;
  public short data5;
  public short data6;
  public short data7;
  public short data8;

  // penUp
  public final short start_x() { return data1; }
  public final short start_y() { return data2; }
  public final short end_x() { return data3; }
  public final short end_y() { return data4; }

  // keyDown
  /** accessor for keyDownEvent data */
  public final short chr() { return data1; }  // char is not good (==byte)
  /** accessor for keyDownEvent data */
  public final short keyCode() { return data2; }
  /** accessor for keyDownEvent data */
  public final short modifiers() { return data3; }

  // winEnter, winExit
  public final int enterWindow() { return (data1 << 16) | (data2 & 0xFFFF); }
  public final int exitWindow() { return (data3 << 16) | (data4 & 0xFFFF); }

  // ctl
  public final short controlID() { return data1; }
  public final int   pControl() { return (data2 << 16) | (data3 & 0xFFFF); }

  // ctlSelect
  public final boolean on() { return data4 != 0; }

  // ctlRepeat
  /** accessor for ctlRepeatEvent data */
  public final int time() { return (data4 << 16) | (data5 & 0xFFFF); }

  // fld
  /** accessor for fld events data */
  public final short fieldID() { return data1; }
  /** accessor for fld events data */
  public final int   pField() { return (data2 << 16) | (data3 & 0xFFFF); }

  // fldHeightChanged
  /** accessor for fldHeightChangedEvent data */
  public final short newHeight() { return data4; }
  /** accessor for fldHeightChangedEvent data */
  public final short currentPos() { return data5; }

  // lst
  /** accessor for lst events data */
  public final short listID() { return data1; }
  /** accessor for lst events data */
  public final int   pList() { return (data2 << 16) | (data3 & 0xFFFF); }

  // lstEnter, lstSelect
  /** accessor for lstselectEvent data */
  public final short selection() { return data4; }

  // tbl
  /** accessor for tble events data */
  public final short tableID() { return data1; }
  /** accessor for tble events data */
  public final int   pTable() { return (data2 << 16) | (data3 & 0xFFFF); }
  /** accessor for tble events data */
  public final short row() { return data4; }
  /** accessor for tble events data */
  public final short column() { return data5; }

  // frm
  /** accessor for frm events data */
  public final short formID() { return data1; }

  // frmGoto
  /** accessor for frmGotoEvent data */
  public final short recordNum() { return data2; }
  /** accessor for frmGotoEvent data */
  public final short matchPos() { return data3; }
  /** accessor for frmGotoEvent data */
  public final short matchLen() { return data4; }
  /** accessor for frmGotoEvent data */
  public final short matchFieldNum() { return data5; }
  /** accessor for frmGotoEvent data */
  public final int   matchCustom() { return (data6 << 16) | (data7 & 0xFFFF); }

  // frmUpdate
  /** accessor for frmUpdateEvent data */
  public final short updateCode() { return data2; }

  // daySelect
  /** accessor for daySelectEvent data */
  public final int   pSelector() { return (data1 << 16) | (data2 & 0xFFFF); }
  /** accessor for daySelectEvent data */
  public final short daySelect_selection() { return data3; }
  /** accessor for daySelectEvent data */
  public final boolean useThisDate() { return data4 != 0; }

  // menu
  /** accessor for menuEvent data */
  public final short itemID() { return data1; }

  // popSelect
  /** accessor for popSelectEvent data */
  public final short popSelect_controlID() { return data1; }
  /** accessor for popSelectEvent data */
  public final int   popSelect_controlP() { return (data2 << 16) | (data3 & 0xFFFF); }
  /** accessor for popSelectEvent data */
  public final short popSelect_listID() { return data4; }
  /** accessor for popSelectEvent data */
  public final int   popSelect_listP() { return (data5 << 16) | (data6 & 0xFFFF); }
  /** accessor for popSelectEvent data */
  public final short popSelect_selection() { return data7; }
  /** accessor for popSelectEvent data */
  public final short popSelect_priorSelection() { return data8; }

  // scroll bar
  /** accessor for scl events data */
  public final short scrollBarID() { return data1; }
  /** accessor for scl events data */
  public final int   pScrollBar() { return (data2 << 16) | (data3 & 0xFFFF); }
  /** accessor for scl events data */
  public final short scrollBarValue() { return data4; }
  /** accessor for scl events data */
  public final short scrollBarNewValue() { return data5; }
  /** accessor for scl events data */
  public final int   scrollBarTime() { return (data6 << 16) | (data7 & 0xFFFF); }
  
  // Symbol scanner events
  /** accessor for multiple barcode packets */
  public final short scanGen() { return data1; }
  /** accessor for batteryError */
  public final short batteryLevel() { return data1; }
  public final short batteryErrorType() { return data2; }
  
}

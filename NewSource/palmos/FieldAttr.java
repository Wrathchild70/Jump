package palmos;

/**
 * This class describes field attributes.
 * <p>
 * Usage:
 * <pre>
 * attr = new FieldAttr();
 * Palm.FldGetAttributes(field,attr);
 * 
 * if ((attr.attributes & FieldAttr.USABLE) != 0) 
 *    // field is usable.
 *
 * if ((attr.attributes & FieldAttr.UNDERLINED) == FieldAttr.SOLID_UNDERLINE)
 *    // field has solid underline.
 * </pre>
 */

public class FieldAttr {

  /** constant bitmask for 'usable' single-bit attribute. */
  public static final int USABLE         = 0x8000;

  /** constant bitmask for 'visible' single-bit attribute. */
  public static final int VISIBLE        = 0x4000;

  /** constant bitmask for 'editable' single-bit attribute. */
  public static final int EDITABLE       = 0x2000;

  /** constant bitmask for 'single-line' single-bit attribute. */
  public static final int SINGLE_LINE    = 0x1000;

  /** constant bitmask for 'has-focus' single-bit attribute. */
  public static final int HAS_FOCUS      = 0x0800;

  /** constant bitmask for 'dynamic-size' single-bit attribute. */
  public static final int DYNAMIC_SIZE   = 0x0400;

  /** constant bitmask for 'ins-pt-visible' single-bit attribute. */
  public static final int INS_PT_VISIBLE = 0x0200;

  /** constant bitmask for 'dirty' single-bit attribute. */
  public static final int DIRTY          = 0x0100;

  /** constant bitmask for 'underlined' multiple-choice attribute. */
  public static final int UNDERLINED     = 0x00c0;

  /** constant bitmask for 'justification' multiple-choice attribute. */
  public static final int JUSTIFICATION  = 0x0030;

  /** constant bitmask for 'auto-shift' single-bit attribute. */
  public static final int AUTO_SHIFT     = 0x0008;

  /** constant bitmask for 'has-scroll-bar' single-bit attribute. */
  public static final int HAS_SCROLL_BAR = 0x0004;

  /** constant bitmask for 'numeric' single-bit attribute. */
  public static final int NUMERIC        = 0x0002;


  /** constant choice value for 'underlined'. */
  public static final int NO_UNDERLINE    = 0x0000;

  /** constant choice value for 'underlined'. */
  public static final int GRAY_UNDERLINE  = 0x0040;

  /** constant choice value for 'underlined'. */
  public static final int SOLID_UNDERLINE = 0x0080;


  /** constant choice value for 'justification'. */
  public static final int LEFT_ALIGN      = 0x0000;

  /** constant choice value for 'justification'. */
  public static final int CENTER_ALIGN    = 0x0010;

  /** constant choice value for 'justification'. */
  public static final int RIGHT_ALIGN     = 0x0020;


  /** variable containing the attributes of a field. */
  public short attributes;
}

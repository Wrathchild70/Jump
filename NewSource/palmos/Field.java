package palmos;

/**
 * This class describes a field.
 * <p>
 * Usage:
 * <pre>
 * field = new Field();
 * Palm.FldSetFocus(field);
 * 
 * </pre>
 */

public class Field {
	/** field number */
	public short		id;
	
	/** pointer to FrmRectangle giving the screen coordinates for the field.
	 * <pre>
	 *	typedef struct {
	 *		FormObjAttrType attr;
	 *		RectangleType rect;
	 *	} FormRectangleType;
	 * </pre>
	 */
	public int			rectPtr;
	
	/** value of the field Attr bits  */
	public short		fieldAttr;
	
	/** memory of the text	*/
	public int			textPtr;					// pointer to the start of text string 
	
	/** handle of the text	*/
	public int			textHandle;					// block the contains the text string
	
	/** pointer to an a LineInfoPtr structure, which is
	 * <pre>
	 * typedef struct {
	 *		UInt16 start;
	 *		UInt16 length;
	 * } LineInfoType;
	 * </pre>
	 */
	public int			lineInfoPtr;
	
	/** number of characters, up to 32757  */
	public short		textLen;
	
	/**   */
	public short		textBlockSize;
	
	/**   */
	public short		maxChars;
	
	/**   */
	public short		selFirstPos;
	
	/**   */
	public short		selLastPos;
	
	/**   */
	public short		insPtXPos;
	
	/**   */
	public short		insPtYPos;
	
	/**   */
	public byte			fontID;					// enumeration
	
	/**   */
	public byte 		reserved;
}

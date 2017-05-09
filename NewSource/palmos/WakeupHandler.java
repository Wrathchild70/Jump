package palmos;

/**
 * This class corresponds to a callback in the Palm OS API.
 * The class is used by deriving a class from it and
 * overriding the callback(int) method. The class is then passed
 * to palmos.Palm.SrmSetWakeupHandler().
 * Note that the WakeupHandler object must be kept alive during
 * the time that a callback may occur. This can be done by having a variable
 * contain the object.
 * 
 * <P><B>NOTE:</B> Currently WakeupHandler <B>is unlikely to work</B>
 * with the <B>huge</B> memory model.
 * This class is extremely experimentle. The callback is called at interrupt
 * time, so you can do almost nothing safely there. You might even be in mid
 * garbage collection.
 * 
 * @see palmos.Palm#SetWakeupHandler(int, palmos.WakeupHandler, int)
 */
public class WakeupHandler
{
  // a 10-byte code fragment that punts the callback via dispatch.
  /** part of instructions making up callback <I>thunk</I> */
  short pea_op_code;
  /** part of instructions making up callback <I>thunk</I> */
  short pea_offset;
  /** part of instructions making up callback <I>thunk</I> */
  short jmp_op_code;
  /** part of instructions making up callback <I>thunk</I> */
  int   jmp_address;

  // native contructor

  /**
   * Called as part of the callback mechanism to provide virtual dispatch.
   * The code fragment at the start of the object puts 'this' and refCon
   * on the stack, and then calls here. This is done instead of
   * vectoring to callback() directly because it is difficult to
   * write asm to do the virtual method call - the vtable index is not
   * currently available to the asm code.
   */
  private void dispatch(int refCon)
  {
    callback(refCon);
  }

  /**
   * Override this method to implement a callback.
   */
  public void callback(int refCon)
  {
    Palm.EvtWakeup();
  }
}
/*
    Jump - Java post-compiler for PalmPilot
    Copyright (C) 1996,97  Greg Hewgill <gregh@lightspeed.net>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
    This file has been modified in 03/2000 
    by Ralf Kleberhoff <Kleberhoff@aol.com>
    to make Jump compatible with current Java and PalmOS versions
    and to extend the functionality.
    Many thanks to Greg Hewgill for the original version!
*/
/*
   November 2001
    This file has been modified by Peter Dickerson <peter.dickerson@ukonline.co.uk>
    to add some code optimization and to extend the functionality.
*/

import java.io.*;
import java.util.*;

class StackEntry implements JVM 
{
  
  /** the type signature of this entry. */
  String signature;
  
  /** the size of this entry (1 or 2). */
  int size;

  /**
   * Indicates the local variable origin or -1 if not known.
   * Used to try to avoid checking for null pointers that have
   * already been checked.
   */
  int localSlot = -1;

  /**
   * Contains the name of the field that was pushed into this item.
   * For now this is only valid for static fields.
   */
  String staticName;

  /**
   * Indicates that the entry is a valid non-null pointer.
   * The entry originated with a value known to be non-null
   * such as the result of op_new.
   */
  boolean isKnownNonNull = false;

  /**
   * An identifier for this value. 
   * Normally, we use the index of the op-code generating this value. 
   */
  int[] sourceIDs = new int[1];

  /** 
   * the next entry on the stack, just below this one. 
   * Bottom-of-stack is denoted by a null value.
   */
  StackEntry next;

  /**
   * constructs a new stack entry.
   */
  StackEntry (String signature, int sourceID, StackEntry next)
  {
    this.signature = signature;
    switch (signature.charAt(0))
    {
    case 'J':
    case 'D':
      this.size = 2;
      break;
    default:
      this.size = 1;
      break;
    }
    this.sourceIDs[0] = sourceID;
    this.next = next;
  }

  /**
   * constructs a new stack entry.
   */
  StackEntry (int localSlot, int sourceID, StackEntry next)
  {
    this.localSlot = localSlot;
    this.staticName = null;
    this.signature = "Ljava/lang/Object;";
    this.size = 1;
    this.sourceIDs[0] = sourceID;
    this.next = next;
  }

  /**
   * constructs a new stack entry.
   */
  StackEntry (String signature, int[] sourceIDs, StackEntry next)
  {
    this.signature = signature;
    switch (signature.charAt(0))
    {
    case 'J':
    case 'D':
      this.size = 2;
      break;
    default:
      this.size = 1;
      break;
    }
    this.sourceIDs = sourceIDs;
    this.next = next;
  }

  /** 
   * push one value (size 1 or 2) onto stack. 
   */
  StackEntry push (String signature, int sourceID)
  {
    return new StackEntry (signature, sourceID, this);
  }

  /** 
   * push one value localSlot  address (size 1) onto stack. 
   */
  StackEntry push (int localSlot, int sourceID)
  {
    return new StackEntry (localSlot, sourceID, this);
  }

  /** 
   * push one value (size 1 or 2) onto stack. 
   */
  StackEntry push (String signature, int[] sourceIDs)
  {
    return new StackEntry (signature, sourceIDs, this);
  }

  /**
   * pop a size-1 value from stack.
   */
  StackEntry popSingle ()
  {
    ASSERT.check (size==1, "popSingle() from size-2 StackEntry");
    return next;
  }

  /**
   * pop a size-2 value from stack.
   */
  StackEntry popDouble ()
  {
    if (size == 2) 
    {
      return next;
    }
    else  
    {
      ASSERT.check (next.size==1, "popDouble() from size-1/2 Top-Of-Stack");
      return next.next;
    }
  }

  /**
   * pops a given number of size-1 words from the stack.
   * The stack may also contain size-2 entries, counting 
   * for 2 words.
   */
  StackEntry popNWords (int n)
  {
    StackEntry stack = this;
    
    while (n > 0) 
    {
      ASSERT.check (stack.size<=n, "popNWords() size mismatch");
      n -= stack.size;
      stack = stack.next;
    }
    return stack;
  }

  /**
   * swap the 2 top stack entries (size-1).
   */
  StackEntry swapSingle ()
  {
    ASSERT.check ((size==1) && (next.size==1), "swapSingle() with size-2 entries");
    localSlot = -1;
    staticName = null;
    next.localSlot = -1;
    next.staticName = null;
    return new StackEntry (next.signature, next.sourceIDs, 
      new StackEntry (signature, sourceIDs, next.next));
  }

  /**
   * duplicate the top size-1 stack entry.
   */
  StackEntry dupSingle ()
  {
    ASSERT.check (size==1, "dupSingle() with size-2 entry");
    StackEntry se = new StackEntry (signature, sourceIDs, this);
    se.isKnownNonNull = isKnownNonNull;
    // We can't copy with one aload resulting in multiple stack
    // entries. When invalidate the deeper one so that putfield
    // doesn't try to remove it.
    se.localSlot = localSlot;
    se.staticName = staticName;
    return se;
  }

  /**
   * duplicate the top size-1 stack entry and bury it 1 place down.
   */
  StackEntry dupSingleBury1 ()
  {
    ASSERT.check ((size==1) && (next.size==1), "dupSingleBury1() with size-2 entry");
    localSlot = -1;
    staticName = null;
    next.localSlot = -1;
    next.staticName = null;
    next.next.localSlot = -1;
    next.next.staticName = null;
    return new StackEntry (signature, sourceIDs,
      new StackEntry (next.signature, next.sourceIDs,
      new StackEntry (signature, sourceIDs,
      next.next)));
  }

  /**
   * duplicate the top size-1 stack entry and bury it
   * 2 places down (or 1 size-2-place down).
   */
  StackEntry dupSingleBury2 ()
  {
    localSlot = -1;
    staticName = null;
    next.localSlot = -1;
    next.staticName = null;
    next.next.localSlot = -1;
    next.next.staticName = null;
    ASSERT.check ((size==1), "dupSingleBury2() with size-2 top-entry");
    if (next.size == 2) 
    {
      return new StackEntry (signature, sourceIDs,
        new StackEntry (next.signature, next.sourceIDs,
        new StackEntry (signature, sourceIDs,
        next.next)));
    }
    else 
    {
      ASSERT.check ((next.next.size==1),
        "dupSingleBury2() with size-1/1/2 top-entries");
      next.next.next.localSlot = -1;
      next.next.staticName = null;
      return 
        new 
        StackEntry (signature, sourceIDs,
        new 
        StackEntry (next.signature, next.sourceIDs,
        new
        StackEntry (next.next.signature, next.next.sourceIDs,
        new 
        StackEntry (signature, sourceIDs,
        next.next.next))));
    }
  }

  /**
   * duplicate the top size-2 stack entry (or two size-1 entries).
   */
  StackEntry dupDouble()
  {
    localSlot = -1;
    staticName = null;
    if (size == 2) 
    {
      return new StackEntry (signature, sourceIDs, this);
    }
    else 
    {
      ASSERT.check ((next.size==1),
        "dupDouble() with size-1/2 top-entries");
      // too much to keep track of local vars
      next.localSlot = -1;
      next.staticName = null;
      return new StackEntry (signature, sourceIDs,
        new StackEntry (next.signature, next.sourceIDs,
        this));
    }
  }
 
  /**
   * duplicate the top size-2 stack entry (or two size-1 entries)
   * and bury it (or them) 1 place down.
   */
  StackEntry dupDoubleBury1 ()
  {
    if (size == 2) 
    {
      ASSERT.check ((next.size==1), 
        "dupDoubleBury1() with size-2/2 top-entries");
      return new StackEntry (signature, sourceIDs,
        new StackEntry (next.signature, next.sourceIDs,
        new StackEntry (signature, sourceIDs,
        next.next)));
    }
    else 
    {
      ASSERT.check ((next.size==1) && (next.next.size==1),
        "dupDoubleBury1() with size-1/1/2 or 1/2/1 top-entries");
      next.localSlot = -1;
      next.staticName = null;
      next.next.localSlot = -1;
      next.next.staticName = null;
      next.next.next.localSlot = -1;
      next.next.next.staticName = null;
      return 
        new StackEntry 
        (signature, sourceIDs,
        new StackEntry 
        (next.signature, next.sourceIDs,
        new StackEntry 
        (next.next.signature, next.next.sourceIDs,
        new StackEntry 
        (signature, sourceIDs,
        new StackEntry 
        (next.signature, next.sourceIDs, next.next.next)))));
    }
  }

  /**
   * duplicate the top size-2 stack entry (or two size-1 entries)
   * and bury it (or them) 2 places down.
   */
  StackEntry dupDoubleBury2 ()
  {
    next.localSlot = -1;
    next.staticName = null;
    next.next.localSlot = -1;
    next.next.staticName = null;
    if (size == 2) 
    {
      if (next.size == 1) 
      {
        ASSERT.check (next.next.size==1, 
          "dupDoubleBury2() with size-2/1/2 top-entries");
        next.next.next.localSlot = -1;
        return 
          new StackEntry 
          (signature, sourceIDs,
          new StackEntry 
          (next.signature, next.sourceIDs,
          new StackEntry 
          (next.next.signature, next.next.sourceIDs,
          new StackEntry (signature, sourceIDs,
          next.next.next))));
      }
      else 
      {
        return 
          new StackEntry 
          (signature, sourceIDs,
          new StackEntry 
          (next.signature, next.sourceIDs,
          new StackEntry (signature, sourceIDs,
          next.next)));
      }
    }
    else 
    {
      ASSERT.check (next.size==1,
        "dupDoubleBury2() with size-1/2 top-entries");
      StackEntry next2 = next.next;
      if (next2.size == 1) 
      {
        StackEntry next3 = next2.next;
        ASSERT.check (next3.size==1, 
          "dupDoubleBury2() with size-1/1/1/2 top-entries");
        next3.localSlot = -1;
        next3.staticName = null;
        next3.next.localSlot = -1;
        next3.next.staticName = null;
        return 
          new StackEntry
          (signature, sourceIDs,
          new StackEntry
          (next.signature, next.sourceIDs,
          new StackEntry
          (next2.signature, next2.sourceIDs,
          new StackEntry
          (next3.signature, next3.sourceIDs,
          new StackEntry
          (signature, sourceIDs,
          new StackEntry
          (next.signature, next.sourceIDs,
          next3.next))))));
      }
      else 
      {
        next2.next.localSlot = -1;
        next2.next.staticName = null;
        return 
          new StackEntry
          (signature, sourceIDs,
          new StackEntry
          (next.signature, next.sourceIDs,
          new StackEntry
          (next2.signature, next2.sourceIDs,
          new StackEntry
          (signature, sourceIDs,
          new StackEntry
          (next.signature, next.sourceIDs,
          next2.next)))));
      }
    }
  }

  /**
   * merge 2 stacks producing a common description.
   * The 2 stacks come from different code segments,
   * e.g. one from linear execution, and the other from
   * a branch into the code.
   * If the 2 stacks are incompatible, 
   * an AssertionFailedException is thrown.
   */
  static StackEntry merge (StackEntry first, StackEntry other)
  {
    String newSignature = null;
    int[] newSourceIDs;
    StackEntry mergedNext;

    if (first == other) 
    {
      return first;
    }
    if (first == null) 
    {
      return other;
    }
    if (other == null) 
    {
      return first;
    }
    if (other.size != first.size) 
    {
      ASSERT.fail ("incompatible stacks: " + first + " and " + other);
      return null;
    }

    if (other.signature.equals (first.signature)) 
    {
      newSignature = first.signature;
    }
    else 
    {
      switch (other.signature.charAt(0)) 
      {
      case 'B':
      case 'C':
      case 'I':
      case 'S':
      case 'Z':
        switch (first.signature.charAt(0)) 
        {
        case 'B':
        case 'C':
        case 'I':
        case 'S':
        case 'Z':
          newSignature = "I";
          break;
        default:
          ASSERT.fail ("incompatible stacks: " + first + " and " + other);
          break;
        }
        break;
      case 'L':
      case '[':
        switch (first.signature.charAt(0)) 
        {
        case 'L':
        case '[':
          if (first.signature.equals("Lnull;")) 
          {
            newSignature = other.signature;
          }
          else if (other.signature.equals("Lnull;")) 
          {
            newSignature = first.signature;
          }
          else 
          {
            newSignature = "Ljava/lang/Object;";
          }
          break;
        default:
          ASSERT.fail ("incompatible stacks: " + first + " and " + other);
          break;
        }
        break;
      default:
        ASSERT.fail ("incompatible stacks: " + first + " and " + other);
        break;
      }
    }
    if (other.sourceIDs == first.sourceIDs) 
    {
      newSourceIDs = first.sourceIDs;
    }
    else 
    {
      Vector ids = new Vector();
      for (int i=0; i<first.sourceIDs.length; i++) 
      {
        ids.addElement (new Integer(first.sourceIDs[i]));
      }
      for (int i=0; i<other.sourceIDs.length; i++) 
      {
        Integer otherID = new Integer(other.sourceIDs[i]);
        if (!ids.contains(otherID)) 
        {
          ids.addElement (new Integer(other.sourceIDs[i]));
        }
      }
      if (ids.size() > first.sourceIDs.length) 
      {
        newSourceIDs = new int[ids.size()];
        for (int i=0; i<newSourceIDs.length; i++) 
        {
          newSourceIDs[i] = ((Integer) ids.elementAt(i)).intValue();
        }
      }
      else 
      {
        newSourceIDs = first.sourceIDs;
      }
    }

    mergedNext = merge (first.next, other.next);

    if (newSignature.equals (first.signature) &&
      (newSourceIDs == first.sourceIDs) &&
      (mergedNext == first.next)) 
    {
      return first;
    }
    else 
    {
      return new StackEntry (newSignature, newSourceIDs, mergedNext);
    }
  }
  
  /**
   * readable description of the whole stack, not just the top entry.
   */
  public String toString ()
  {
    StringBuffer buf = new StringBuffer(signature);
    for (int i=0; i<sourceIDs.length; i++) 
    {
      buf.append(".").append(sourceIDs[i]);
    }
    for (StackEntry en=next; en!=null; en=en.next) 
    {
      StringBuffer buf2 = new StringBuffer(en.signature);
      for (int i=0; i<en.sourceIDs.length; i++) 
      {
        buf2.append(".").append(en.sourceIDs[i]);
      }
      buf2.append (" + ");
      buf.insert (0, buf2.toString());
    }
    return buf.toString();
  }

}

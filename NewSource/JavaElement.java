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

import java.io.*;
import java.util.*;

/**
 * JavaElement is the superclass of all components of
 * a runnable Java program. 
 * <p>
 * This abstract class contains or defines the methods 
 * necessary for the decisions whether a component is
 * needed in the resulting program. 
 * This class supports different modes of being needed,
 * e.g. a class can be 
 * <ul>
 * <li>(0) unneeded,</li>
 * <li>(1) needed in the class table (e.g for 'instanceof' checks),</li>
 * <li>(2) needed with instances,</li>
 * <li>(3) needed with instances and exact layout.</li>
 * </ul>
 * These basic modes are ordered: a mode with a higher 
 * numeric value implies and supersedes one with a lower value.
 * <p>
 * In addition to the basic modes described above 
 * (excluding one another) there are add-on modes that
 * can be combined with the basic modes and with one another.
 * <p>
 * Basic modes range from 0 to 255, add-on modes are bit masks
 * from 256 upwards.
 */

abstract class JavaElement 
{
  /** needed-mode constant: element unneeded */
  final static int UNNEEDED = 0;

  /** 
   * needed-mode constant: needed in default-mode.
   * <ul>
   * <li>class: needs a class index and a classtable entry.</li>
   * <li>field: needs storage.</li>
   * <li>method: code is needed.</li>
   * </ul>
   */
  final static int NEEDED = 1;

  /** needed-mode constant: instances of this class needed. */
  final static int INSTANCE_NEEDED = 2;

  /** 
   * needed-mode constant: instances of this class needed 
   * with byte-exact layout of all fields.
   */
  final static int EXACT_INSTANCE_NEEDED = 3;

  /** 
   * needed-mode constant: method is being called virtually. 
   * This is an add-on mode to be combined with UNNEEDED or NEEDED.
   * <p>
   * <i>NEEDED_VIRTUALLY can be combined with UNNEEDED, if only
   * subclasses of the method's class have instances and all
   * the subclasses have their own implementation of the method.
   * Then there's no chance that the method being called virtually
   * is really executed - the subclass methods will be executed 
   * instead.</i>
   */
  final static int NEEDED_VIRTUALLY = 256;

  /** 
   * needed-mode constant for classes: 
   * instances of other classes are checked to belong to this class.
   * This is an add-on mode to be combined with NEEDED, 
   * INSTANCE_NEEDED or EXACT_INSTANCE_NEEDED.
   */
  final static int NEEDED_INSTANCEOF = 256;

  /** the basic mode describing how this element is needed. */
  int neededModeBasic = UNNEEDED;

  /** the add-on modes modifying how this element is needed. */
  int neededModeAddOn = 0;

  /** reasons why this element is needed. */
  Vector neededReasons = null;

  /**
   * mark this Java element needed in a specific mode,
   * adding logically to the current mode.
   * As a side-effect, all elements that this one 
   * depends upon, are also marked 'needed' recursively.
   *
   * @param reason the reason why this element is needed
   *               (normally another Java element referencing this one).
   * @param mode   a mode constant describing how this element is needed.
   */
  void markNeeded (Object reason, int mode)
  {
    try 
    {
      boolean changes = false;

      if (neededReasons == null) 
      {
        neededReasons = new Vector();
        neededReasons.addElement (reason);
      }
      else if (!neededReasons.contains (reason)) 
      {
        neededReasons.addElement (reason);
      }
      
      int basicMode = mode & 0xff;
      int addOn = mode & 0xffffff00;
      
      if (basicMode > neededModeBasic) 
      {
        neededModeBasic = basicMode;
        changes = true;
      }
      
      if ((neededModeAddOn & addOn) != addOn) 
      {
        neededModeAddOn |= addOn;
        changes = true;
      }
      
      if (changes) 
      {
        Jump.newNeeds = true;
        updateNeeded();
      }
    }
    catch (Exception exc) 
    {
      throw JumpException.addInfo(exc, "needed " + this + " for " + reason);
    }
  }

  /**
   * check whether this element is needed at least in the specified mode.
   */
  boolean isNeeded (int mode)
  {
    int basicMode = mode & 0xff;
    int addOn = mode & 0xffffff00;

    return ((neededModeBasic >= basicMode) &&
      ((neededModeAddOn & addOn) == addOn));
  }

  /**
   * check whether this element is needed in any mode.
   */
  boolean isNeeded ()
  {
    return ((neededModeBasic > 0) ||
      (neededModeAddOn > 0));
  }

  /**
   * update the 'needed'-state of all Java elements that this one depends upon.
   * This method must be implemented in all subclasses of JavaElement.
   */
  abstract void updateNeeded();

}

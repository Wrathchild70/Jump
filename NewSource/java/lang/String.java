/* java.lang.String
   Copyright (C) 1998, 1999, 2000 Free Software Foundation, Inc.

This file is part of GNU Classpath.

GNU Classpath is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.
 
GNU Classpath is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Classpath; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA.

As a special exception, if you link this library with other files to
produce an executable, this library does not by itself cause the
resulting executable to be covered by the GNU General Public License.
This exception does not however invalidate any other reasons why the
executable file might be covered by the GNU General Public License. */

/* Extended/modified for use with Jump by Ralf Kleberhoff */
/* Modified for improved performance by Peter Dickerson */

package java.lang;

import java.util.Hashtable;
import java.util.Locale;
import java.io.*;

/**
 * Strings represent an immutable set of characters.
 * Compliant with JDK 1.1.
 * 
 * <P>This class is a JUMP specific version of the standard Java
 * class and may only support a subset of the full class. See
 * the standard Java javadocs for clarification.
 *
 * @author Paul N. Fisher
 * @since JDK1.0
 */
public final class String 
{
  /**
   * Holds the references for each intern()'d String.
   * Once a String has been intern()'d it cannot be GC'd.
   *
   * @XXX Replace with a weak reference structure for 1.2
   */
  // modified for Jump: lazy initialization
  // private static Hashtable internTable = new Hashtable();
  private static Hashtable internTable = null;

  /**
   * Characters which make up the String.
   * Package access is granted for use by StringBuffer.
   */
  char[] value;

  /**
   * Holds the number of characters in str[].  This number is generally
   * the same as str.length, but if a StringBuffer is sharing memory
   * with this String, then len will be equal to StringBuffer.length().
   * Package access is granted for use by StringBuffer.
   */
  int count;

  /**
   * Holds the starting position for characters in str[].  Since
   * substring()'s are common, the use of `offset' allows the operation
   * to perform in O(1).
   *
   * @FIXME The use of offset has not been implemented.
   */
  private int offset;

  /**
   * Caches the result of hashCode().  If this value is zero, the hashcode
   * is considered uncached (even if 0 is the correct hash value).
   */
  // private int cachedHashCode;

  /**
   * Creates an empty String (length 0)
   */
  public String() {
    value = new char[0];
  }

  /**
   * Copies the contents of a String to a new String.
   * Since Strings are immutable, only a shallow copy is performed.
   *
   * @param str String to copy
   *
   * @exception NullPointerException if `value' is null
   */
  public String(String str) throws NullPointerException {
    // since Strings are immutable, there's no reason to
    //  make a deep copy of `value'
    value = str.value;
    count = str.count;
    offset = str.offset;
  }

  /**
   * Creates a new String using the character sequence represented by
   * the StringBuffer.
   *
   * @param value StringBuffer to copy
   *
   * @exception NullPointerException if `value' is null
   */
  public String(StringBuffer buf) throws NullPointerException {
    count = buf.length();
    value = new char[count];
    if (count > 0) {
      buf.getChars(0, buf.length(), value, 0);
    }
  }
  
  /**
   * Creates a new String using the character sequence of the char
   * array.
   *
   * @param data char array to copy
   *
   * @exception NullPointerException if `data' is null
   */
  public String(char[] data) throws NullPointerException {
    count = data.length;
    value = new char[count];
    System.arraycopy(data, 0, value, 0, data.length);
  }

  /**
   * Creates a new String using the character sequence of the char
   * array, starting at the offset, and copying chars up
   * to the count.
   *
   * @param data char array to copy
   * @param offset position (base 0) to start copying out of `data'
   * @param count the number of characters from `data' to copy
   *
   * @exception NullPointerException if `data' is null
   * @exception StringIndexOutOfBoundsException 
   *   if (offset < 0 || count < 0 || offset+count > data.length)
   */
  public String(char[] data, int offset, int count) 
       throws NullPointerException, IndexOutOfBoundsException {
    if (offset < 0 || count < 0 || offset+count > data.length || offset+count < 0)
      throw new StringIndexOutOfBoundsException();
    this.count = count;
    value = new char[count];
    System.arraycopy(data, offset, value, 0, count);
  }

  /**
   * Creates a new String using the byte array.
   *
   * Uses the default encoding for the system to decode the byte array, or if
   * that doesn't work, uses 8859_1.
   *
   * @param data byte array to copy
   *
   * @exception NullPointerException if `data' is null
   */
  public String(byte[] data) throws NullPointerException {
    this(data,0);
  }

  /**
   * Creates a new String using the byte array.
   *
   * Uses the specified encoding type to decode the byte array, or if
   * that doesn't work, uses 8859_1.
   * <p>
   * <b>For Jump, no encoding is used.</b>
   *
   * @param data byte array to copy
   * @param encoding the name of the encoding to use
   * @exception NullPointerException if `data' is null.
   * @exception UnsupportedEncodingException if the specified encoding is not
   *            found.
   */
  public String(byte[] data, String encoding)
       throws NullPointerException, UnsupportedEncodingException 
  {
    this(data,0);
  }

  /**
   * Creates a new String using the portion of the byte array starting at the
   * offset and ending at offset+count.
   *
   * Uses the specified encoding type to decode the byte array, or if
   * that doesn't work, uses 8859_1.
   *
   * @param data byte array to copy
   * @param offset the offset to start at
   * @param count the number of characters in the array to use
   * @param encoding the name of the encoding to use
   * @exception NullPointerException if `data' is null.
   * @exception IndexOutOfBoundsException if the specified offset or count is
   *            incorrect.
   * @exception UnsupportedEncodingException if the specified encoding is not
   *            found.
   */
  public String(byte[] data, int offset, int count, String encoding)
    throws NullPointerException, IndexOutOfBoundsException, 
    UnsupportedEncodingException 
  {
    this(data, 0, offset, count);
  }

  public String(byte[] data, int offset, int count)
    throws NullPointerException, IndexOutOfBoundsException 
  {
    this(data, 0, offset, count);
  }

  /**
   * Creates a new String using an 8-bit array of integer values.
   * Each character `c', using corresponding byte `b', is created 
   * in the new String by performing:
   *
   * <pre>
   * c = (char) (((hibyte & 0xff) << 8) | (b & 0xff))
   * </pre>
   *
   * @param ascii array of integer values
   * @param hibyte top byte of each Unicode character
   * 
   * @exception NullPointerException if `ascii' is null
   *
   * @deprecated Use constructors with byte to char decoders.
   */
  public String(byte[] ascii, int hibyte) throws NullPointerException {
    count = ascii.length;
    value = new char[count];
    for (int i = 0; i < count; i++)
      value[i] = (char) (((hibyte & 0xff) << 8) | (ascii[i] & 0xff));
  }

  /**
   * Creates a new String using an 8-bit array of integer values,
   * starting at an offset, and copying up to the count.
   * Each character `c', using corresponding byte `b', is created
   * in the new String by performing:
   *
   * <pre>
   * c = (char) (((hibyte & 0xff) << 8) | (b & 0xff))
   * </pre>
   *
   * @param ascii array of integer values
   * @param hibyte top byte of each Unicode character
   * @param offset position (base 0) to start copying out of `ascii'
   * @param count the number of characters from `ascii' to copy
   *
   * @exception NullPointerException if `ascii' is null
   * @exception StringIndexOutOfBoundsException
   *   if (offset < 0 || count < 0 || offset+count > ascii.length)
   *
   * @deprecated Use constructors with byte to char decoders.
   */
  public String(byte[] ascii, int hibyte, int offset, int count)
       throws NullPointerException, IndexOutOfBoundsException {
    if (offset < 0 || count < 0 || offset+count > ascii.length)
      throw new StringIndexOutOfBoundsException();
    this.count = count;
    value = new char[count];
    for (int i = 0; i < count; i++)
      value[i] = (char) (((hibyte & 0xff) << 8) | (ascii[i+offset] & 0xff));
  }

  /**
   * Special constructor used by StringBuffer, which results
   * in a new String which shares memory with a StringBuffer.
   *
   * @param data internal pointer to StringBuffer character data
   * @param length number of characters in `data' (data.length is the
   * capacity of the StringBuffer)
   */
  String(char[] data, int length) {
    value = data;
    count = length;
  }

  /**
   * Private constructor used by String.substring, which results
   * in a new String which shares memory with existing String.
   *
   * @param offset offset in character array
   * @param count  length of new String
   * @param data   character array to be shared with new String
   */
  private String(int offset, int count, char[] data) {
    this.value  = data;
    this.count  = count;
    this.offset = offset;
  }

  /**
   * Returns `this'.
   */
  public String toString() {
    return this;
  }

  /**
   * Predicate which compares anObject to this.
   *
   * @return true if anObject is a String and contains the
   * same character sequence as this String, else false
   */
  public boolean equals(Object anObject) {
    if (anObject == null) return false;
    if (!(anObject instanceof String)) return false;
    String str2 = (String) anObject;
    if (count != str2.count) return false;
    return compareTo(str2) == 0;
  }

  /**
   * Computes the hashcode for this String, according to JLS, Appendix D.
   *
   * @return hashcode value of this String
   */
  public int hashCode() {
    // if (cachedHashCode != 0) return cachedHashCode;

    /* compute the hash code using a local variable such that we're
       reentrant */
    int hashCode = 0;
    int end = count+offset;
    for (int i = offset; i < end; i++)
      hashCode = hashCode * 31 + value[i];

    // cachedHashCode = hashCode;
    return hashCode;
  }
  
  /**
   * Returns the number of characters contained in this String.
   *
   * @return the length of this String.
   */
  public int length() {
    return count;
  }

  /**
   * Returns the character located at the specified index within
   * this String.
   *
   * @param index position of character to return (base 0)
   *
   * @return character located at position `index'
   *
   * @exception StringIndexOutOfBoundsException
   *   if (index < 0 || index >= this.length())
   */
  public char charAt(int index) throws IndexOutOfBoundsException {
    if (index < 0 || index >= count) 
      throw new StringIndexOutOfBoundsException(index);
    return value[index+offset];
  }

  /**
   * Copies characters from this String starting at a specified start index,
   * ending at a specified stop index, to a character array starting at
   * a specified destination begin index.
   *
   * @param srcBegin index to begin copying characters from this String
   * @param srcEnd index after the last character to be copied from this String
   * @param dst character array which this String is copied into
   * @param dstBegin index to start writing characters into `dst'
   *
   * @exception NullPointerException if `dst' is null
   * @exception StringIndexOutOfBoundsException
   * if (srcBegin < 0 || srcBegin > srcEnd || srcEnd > this.length() || 
   *     dstBegin < 0 || dstBegin+(srcEnd-srcBegin) > dst.length)
   */
  public void getChars(int srcBegin, int srcEnd, char dst[], int dstBegin)
       throws NullPointerException, IndexOutOfBoundsException {
    if (srcBegin < 0 || srcBegin > srcEnd || srcEnd > count || 
        dstBegin < 0 || dstBegin+(srcEnd-srcBegin) > dst.length)
      throw new StringIndexOutOfBoundsException();
    int num = srcEnd-srcBegin;
    int i, i1, i2;
    for (i=0, i1=srcBegin+offset, i2=dstBegin; 
         i<num; 
         i++, i1++, i2++)
      dst[i2] = value[i1];
  }

  /**
   * Copies the low byte of each character from this String starting
   * at a specified start index, ending at a specified stop index, to
   * a byte array starting at a specified destination begin index.
   *
   * @param srcBegin index to being copying characters from this String
   * @param srcEnd index after the last character to be copied from this String
   * @param dst byte array which each low byte of this String is copied into
   * @param dstBegin index to start writing characters into `dst'
   *
   * @exception NullPointerException if `dst' is null
   * @exception StringIndexOutOfBoundsException
   * if (srcBegin < 0 || srcBegin > srcEnd || srcEnd > this.length() || 
   *     dstBegin < 0 || dstBegin+(srcEnd-srcBegin) > dst.length)
   *
   * @deprecated Use a getBytes() which uses a char to byte encoder.
   */
  public void getBytes(int srcBegin, int srcEnd, byte dst[], int dstBegin)
       throws NullPointerException, IndexOutOfBoundsException {
    if (srcBegin < 0 || srcBegin > srcEnd || srcEnd > count || 
        dstBegin < 0 || dstBegin+(srcEnd-srcBegin) > dst.length)
      throw new StringIndexOutOfBoundsException();
    int num = srcEnd-srcBegin;
    int i, i1, i2;
    for (i=0, i1=srcBegin+offset, i2=dstBegin; 
         i<num; 
         i++, i1++, i2++)
      dst[i2] = (byte) value[i1];
  }

  /**
   * Converts the Unicode characters in this String to a byte stream
   * using a specified encoding method.
   *
   * @param enc encoding name
   *
   * @return byte array representing the characters in this String using
   * enc encoding, or null if the encoding fails
   *
   * @exception UnsupportedEncodingException if encoding is not supported
   */
  public byte[] getBytes(String enc) throws UnsupportedEncodingException {
    return getBytes();
  }

  /**
   * Converts the Unicode characters in this String to a byte stream
   * using the system's default encoding method.
   *
   * @return byte array representing the characters in this String using
   * the default encoding, or null if the encoding fails
   */
  public byte[] getBytes() {
    byte[] result = new byte[count];
    for (int i=0, i1=offset;
         i<count;
         i++, i1++) {
      result[i] = (byte) value[i1];
    }
    return result;
  }    

  /**
   * Copies the contents of this String into a character array.
   *
   * @return character array containing the same character sequence as
   *   this String.
   */
  public char[] toCharArray() {
    char[] copy = new char[count];

    /* --- deleted by rk ---
    if (value.length != count)
      System.err.println("value.length=" + value.length + " count=" + count);
      */
    System.arraycopy(value, offset, copy, 0, count);
    return copy;
  }

  /**
   * Compares a String to this String, ignoring case.
   *
   * @param anotherString String to compare to this String
   *
   * @return true if `anotherString' and this String have the same
   *   character sequence, ignoring case, else false.
   */
  public boolean equalsIgnoreCase(String anotherString) {
    if (anotherString == null || count != anotherString.count)
      return false;
    int i, i1, i2;
    for (i=0, i1=offset, i2=anotherString.offset;
         i<count; 
         i++, i1++, i2++)
      if (value[i1] == anotherString.value[i2] ||
          Character.toUpperCase(value[i1]) == Character.toUpperCase(anotherString.value[i2]))
        continue;
      else
        return false;
    return true;
  }

  /**
   * Compares this String and another String (case sensitive).
   *
   * @return returns an integer less than, equal to, or greater than
   *   zero, if this String is found, respectively, to be less than,
   *   to match, or be greater than `anotherString'.
   */
  public int compareTo(String anotherString) throws NullPointerException {
    // Jump replaces this with a native implemention
    int min = Math.min(count, anotherString.count);
    int i, i1, i2;
    for (i=0, i1=offset, i2=anotherString.offset; 
         i<min; 
         i++, i1++, i2++) {
      int result = value[i1]-anotherString.value[i2];
      if (result != 0) 
        return result;
    }
    return count-anotherString.count;
  }

  /**
   * Predicate which determines if this String matches another String
   * starting at a specified offset for each String and continuing
   * for a specified length.
   *
   * @param toffset index to start comparison at for this String
   * @param other String to compare region to this String
   * @param oofset index to start comparison at for `other'
   * @param len number of characters to compare
   *
   * @return true if regions match (case sensitive), false otherwise.
   *
   * @exception NullPointerException if `other' is null
   */
  public boolean regionMatches(int toffset, String other, int ooffset, 
                               int len)
       throws NullPointerException {
    // Jump replaces this with a native implemention.
    // or replicating the match case code rather than passing on to the general
    // form is much faster.
    if (toffset < 0 || ooffset < 0 || toffset+len > count || 
      ooffset+len > other.count)
      return false;
    int i, i1, i2;
    for (i=0, i1=toffset+offset, i2=ooffset+other.offset;
      i<len;
      i++, i1++, i2++)
      if (value[i1] != other.value[i2])
        return false;
    return true;
  }

  /**
   * Predicate which determines if this String matches another String
   * starting at a specified offset for each String and continuing for
   * a specified length, optionally ignoring case.
   *
   * @param ignoreCase true if case should be ignored in comparision
   * @param toffset index to start comparison at for this String
   * @param other String to compare region to this String
   * @param oofset index to start comparison at for `other'
   * @param len number of characters to compare
   *
   * @return true if regions match, false otherwise.
   *
   * @exception NullPointerException if `other' is null
   */
  public boolean regionMatches(boolean ignoreCase, int toffset, String other,
                               int ooffset, int len)
       throws NullPointerException {
    if (toffset < 0 || ooffset < 0 || toffset+len > count || 
        ooffset+len > other.count)
      return false;
    int i, i1, i2;
    for (i=0, i1=toffset+offset, i2=ooffset+other.offset;
         i<len;
         i++, i1++, i2++)
      if (ignoreCase)
        if (value[i1] == other.value[i2] ||
            Character.toLowerCase(value[i1]) ==
            Character.toLowerCase(other.value[i2]))
          continue;
        else
          return false;
      else
        if (value[i1] != other.value[i2])
          return false;
    return true;
  }

  /**
   * Predicate which determines if this String starts with a given prefix.
   * If the prefix is an empty String, true is returned.
   *
   * @param prefex String to compare
   *
   * @return true if this String starts with the character sequence
   *   represented by `prefix', else false.
   *
   * @exception NullPointerException if `prefix' is null
   */
  public boolean startsWith(String prefix) throws NullPointerException {
    return (prefix.count == 0) ? true : 
      regionMatches(0, prefix, 0, prefix.count);
  }
  
  /**
   * Predicate which determines if this String starts with a given
   * prefix, beginning comparison using offset of this String.
   * If the prefix is an empty String, true is returned.
   *
   * @param prefix String to compare
   * @param toffset offset for this String where comparison starts
   *
   * @return true if this String starts with the character sequence
   *   represented by prefix, else false.
   *
   * @exception NullPointerException if `prefix' is null
   */
  public boolean startsWith(String prefix, int toffset) 
       throws NullPointerException {
    if (toffset < 0 || toffset > count) return false;
    return (prefix.count == 0) ? true :
      regionMatches(toffset, prefix, 0, prefix.count);
  }
  
  /**
   * Predicate which determines if this String ends with a given suffix.
   * If the suffix is an empty String, true is returned.
   *
   * @param suffix String to compare
   *
   * @return true if this String ends with the character sequence
   *   represented by prefix, else false.
   *
   * @exception NullPointerException if `suffix' is null
   */
  public boolean endsWith(String suffix) throws NullPointerException {
    return (suffix.count == 0) ? true : 
      regionMatches(count-suffix.count, suffix, 0, suffix.count);
  }
  
  /**
   * Finds the first instance of a character in this String.
   *
   * @param ch character to find
   *
   * @return location (base 0) of the character, or -1 if not found
   */
  public int indexOf(int ch) {
    return indexOf(ch, 0);
  }

  /**
   * Finds the first instance of a character in this String, starting at
   * a given index.  If starting index is less than 0, the search
   * starts at the beginning of this String.  If the starting index
   * is greater than the length of this String, -1 is returned.
   *
   * @param ch character to find
   * @param fromIndex index to start the search
   *
   * @return location (base 0) of the character, or -1 if not found
   */
  public int indexOf(int ch, int fromIndex) {
    if (fromIndex < 0) fromIndex = 0;
    int i, i1;
    for (i=fromIndex, i1=fromIndex+offset;
         i<count; 
         i++, i1++)
      if (value[i1] == ch)
        return i;
    return -1;
  }

  /**
   * Finds the first instance of a String in this String.
   *
   * @param str String to find
   * 
   * @return location (base 0) of the String, or -1 if not found
   *
   * @exception NullPointerException if `str' is null
   */
  public int indexOf(String str) throws NullPointerException {
    return indexOf(str, 0);
  }

  /**
   * Finds the first instance of a String in this String, starting at
   * a given index.  If starting index is less than 0, the search
   * starts at the beginning of this String.  If the starting index
   * is greater than the length of this String, -1 is returned.
   *
   * @param str String to find
   * @param fromIndex index to start the search
   *
   * @return location (base 0) of the String, or -1 if not found
   *
   * @exception NullPointerException if `str' is null
   */
  public int indexOf(String str, int fromIndex) throws NullPointerException {
    if (fromIndex < 0) fromIndex = 0;
    if ( str.count == 0 )
      return fromIndex;
    char v[] = value; // caching these values can double performance
    char ch = str.value[str.offset];
    for (int i = fromIndex, j=fromIndex+offset; i < count; i++,j++)
      if ( v[j] == ch && regionMatches(i, str, 0, str.count))
        return i;
    return -1;
  }

  /**
   * Finds the last instance of a character in this String.
   *
   * @param ch character to find
   *
   * @return location (base 0) of the character, or -1 if not found
   */
  public int lastIndexOf(int ch) {
    return lastIndexOf(ch, count-1);
  }

  /**
   * Finds the last instance of a character in this String, starting at
   * a given index.  If starting index is greater than the maximum valid
   * index, then the search begins at the end of this String.  If the 
   * starting index is less than zero, -1 is returned.
   *
   * @param ch character to find
   * @param fromIndex index to start the search
   *
   * @return location (base 0) of the character, or -1 if not found
   */
  public int lastIndexOf(int ch, int fromIndex) {
    if (fromIndex >= count)
      fromIndex = count-1;
    int i, i1;
    for (i=fromIndex, i1=fromIndex+offset; 
         i>=0; 
         i--, i1--)
      if (value[i1] == ch)
        return i;
    return -1;
  }

  /**
   * Finds the last instance of a String in this String.
   *
   * @param str String to find
   * 
   * @return location (base 0) of the String, or -1 if not found
   *
   * @exception NullPointerException if `str' is null
   */
  public int lastIndexOf(String str) throws NullPointerException {
    return lastIndexOf(str, count-str.length());
  }

  /**
   * Finds the last instance of a String in this String, starting at
   * a given index.  If starting index is greater than the maximum valid
   * index, then the search begins at the end of this String.  If the 
   * starting index is less than zero, -1 is returned.
   *
   * @param str String to find
   * @param fromIndex index to start the search
   *
   * @return location (base 0) of the String, or -1 if not found
   *
   * @exception NullPointerException if `str' is null
   */
  public int lastIndexOf(String str, int fromIndex)
    throws NullPointerException {
    if (fromIndex > count)
      fromIndex = count;
    if ( str.count == 0 )
      return fromIndex;
    char v[] = value; // caching these values can double performance
    char ch = str.value[str.offset];
    for (int i = fromIndex, j=fromIndex+offset; i >= 0; i--, j--)
      if (v[j] == ch && regionMatches(i, str, 0, str.count))
        return i;
    return -1;
  }
    
  /**
   * Creates a substring of this String, starting at a specified index
   * and ending at the end of this String.
   *
   * @param beginIndex index to start substring (base 0)
   * 
   * @return new String which is a substring of this String
   *
   * @exception StringIndexOutOfBoundsException 
   *   if (beginIndex < 0 || beginIndex > this.length())
   */
  public String substring(int beginIndex) throws IndexOutOfBoundsException {
    return substring(beginIndex, count);
  }
    
  /**
   * Creates a substring of this String, starting at a specified index
   * and ending at one character before a specified index.
   *
   * @param beginIndex index to start substring (base 0)
   * @param endIndex index after the last character to be 
   *   copied into the substring
   * 
   * @return new String which is a substring of this String
   *
   * @exception StringIndexOutOfBoundsException 
   *   if (beginIndex < 0 || endIndex > this.length() || beginIndex > endIndex)
   */
  public String substring(int beginIndex, int endIndex) 
       throws IndexOutOfBoundsException {
    if (beginIndex < 0 || endIndex > count || beginIndex > endIndex)
      throw new StringIndexOutOfBoundsException();
    return new String(offset+beginIndex, endIndex-beginIndex, value);
  }

  /**
   * Concatenates a String to this String.
   *
   * @param str String to append to this String
   *
   * @return newly concatenated String
   *
   * @exception NullPointerException if `str' is null
   */
  public String concat(String str) throws NullPointerException {
    if (str.count == 0) return this;
    char[] newStr = new char[count + str.count];
    System.arraycopy(this.value, this.offset, newStr,     0, this.count);
    System.arraycopy( str.value,  str.offset, newStr, count,  str.count);
    return new String(newStr);
  }

  /**
   * Replaces every instances of a character in this String with
   * a new character.
   *
   * @param oldChar the old character to replace
   * @param newChar the new character to put in place of the old character
   *
   * @return new String with all instances of `oldChar' replaced with `newChar'
   */
  public String replace(char oldChar, char newChar) {
    // re-designed by rk
    int endIndex = offset+count;
    for (int index = offset; index < endIndex; index++) {
      if (value[index] == oldChar) {
        char[] newStr = new char[count];
        System.arraycopy(value, offset, newStr, 0, count);
        for (int i = index-offset; i < count; i++)
          if (newStr[i] == oldChar)
            newStr[i] = newChar;
        return new String(newStr);
      }
    }
    return this;
  }

  /**
   * Lowercases this String.
   *
   * @return new lowercased String, 
   *   or `this' if no characters where lowercased
   */
  public String toLowerCase() {
    // re-designed by rk
    int endIndex = offset+count;
    for (int index = offset; index < endIndex; index++) {
      char c = value[index];
      if (c != Character.toLowerCase(c)) {
        char[] newStr = new char[count];
        System.arraycopy(value, offset, newStr, 0, count);
        for (int i = index-offset; i < count; i++) {
          newStr[i] = Character.toLowerCase(newStr[i]);
        }
        return new String(newStr);
      }
    }
    return this;
  }

  /**
   * Lowercases this String according to a particular locale.
   * In general, this method has the same results as toLowerCase().
   *
   * @param loc locale to use
   *
   * @return new lowercased String, or `this' if no characters were lowercased
   */
  public String toLowerCase(Locale loc) {
    return toLowerCase();
  }

  /**
   * Uppercases this String.
   *
   * @return new uppercased String, or `this' if no characters were uppercased
   */
  public String toUpperCase() {
    // re-designed by rk
    int endIndex = offset+count;
    for (int index = offset; index < endIndex; index++) {
      char c = value[index];
      if (c != Character.toUpperCase(c)) {
        char[] newStr = new char[count];
        System.arraycopy(value, offset, newStr, 0, count);
        for (int i = index-offset; i < count; i++) {
          newStr[i] = Character.toUpperCase(newStr[i]);
        }
        return new String(newStr);
      }
    }
    return this;
  }

  /**
   * Uppercases this String according to a particular locale.
   * In general, this method has the same results as toUpperCase().
   *
   * @param loc locale to use
   *
   * @return new uppercased String, or `this' if no characters were uppercased
   */
  public String toUpperCase(Locale loc) {
    return toUpperCase();
  }
  
  /**
   * Trims all ASCII control characters (includes whitespace) from
   * the beginning and end of this String.
   *
   * @return new trimmed String, or `this' if the String was empty
   *   or contained characters greater than '\u0020' at index zero,
   *   and index this.length()-1.
   */
  public String trim() {
    // re-designed by rk
    int begin = offset;
    int end_1 = offset+count-1;
    if (count == 0 || 
        (value[begin] > '\u0020' && 
         value[end_1] > '\u0020'))
      return this;

    // make 'begin' point to the first non-control char
    while (value[begin] <= '\u0020') {
      if (begin >= end_1) {
        return "";
      }
      begin++;
    }
    // make 'end_1' point to the last non-control char
    while (value[end_1] <= '\u0020') {
      end_1--;
    }
    return substring(begin-offset, end_1-offset + 1);
  }

  /**
   * Returns a new String from a subarray of the given character array.
   *
   * @param data   the character array
   * @param offset the start position of the subarray
   * @param count  the length of the subarray
   *
   * @return the new String
   */
  public static String copyValueOf(char[] data, int offset, int count)
  {
    return new String(data, offset, count);
  }

  /**
   * Returns a new String from a given character array.
   *
   * @param data   the character array
   *
   * @return the new String
   */
  public static String copyValueOf(char[] data)
  {
    return new String(data);
  }

  /**
   * Returns a String representation of an Object.
   *
   * @param obj the Object
   *
   * @return "null" if `obj' is null, else `obj.toString()'
   */
  public static String valueOf(Object obj) {
    return (obj == null) ? "null" : obj.toString();
  }

  /**
   * Returns a String representation of a character array.
   *
   * @param data the character array
   *
   * @return a String containing the same character sequence as `data'
   */
  public static String valueOf(char[] data) throws NullPointerException {
    return new String(data);
  }

  /**
   * Returns a String representing the character sequence of the char
   * array, starting at the specified offset, and copying chars up
   * to the specified count.
   *
   * @param data character array
   * @param offset position (base 0) to start copying out of `data'
   * @param count the number of characters from `data' to copy
   *
   * @return String containing the chars from `data[offset..offset+count]'
   *
   * @exception StringIndexOutOfBoundsException 
   *   if (offset < 0 || count < 0 || offset+count > data.length)
   */
  public static String valueOf(char[] data, int offset, int count)
       throws NullPointerException, IndexOutOfBoundsException {
    return new String(data, offset, count);
  }

  /**
   * Returns a String representing a boolean.
   *
   * @param b the boolean
   *
   * @return "true" if `b' is true, else "false"
   */
  public static String valueOf(boolean b) {
    return (b) ? "true" : "false";
  }

  /**
   * Returns a String representing a character.
   * 
   * @param c the character
   *
   * @return String containing the single character `c'.
   */
  public static String valueOf(char c) {
    // faster that new String( new char[] ) bc it avoids copying/duplication
    return new String(0, 1, new char[] { c });
  }

  /**
   * Returns a String representing an integer.
   *
   * @param i the integer
   *
   * @return Integer.toString(i)
   */
  public static String valueOf(int i) {
    return Integer.toString(i);
  }

  /**
   * Returns a String representing a long.
   *
   * @param i the long
   *
   * @return Long.toString(i)
   */
  public static String valueOf(long l) {
    return Long.toString(l);
  }

  /**
   * Returns a String representing a float.
   *
   * @param i the float
   *
   * @return Float.toString(i)
   */
  public static String valueOf(float f) {
    return Float.toString(f);
  }

  /**
   * Returns a String representing a double.
   *
   * @param i the double
   *
   * @return Double.toString(i)
   */
  public static String valueOf(double d) {
    return Double.toString(d);
  }

  /**
   * Fetches this String from the intern hashtable.
   * If two Strings are considered equal, by the equals() method,
   * then intern() will return the same String instance.
   * ie. if (s1.equals(s2)) then (s1.intern() == s2.intern())
   *
   * @return intern'd String
   */
  public String intern() {
    // Jump-specific:
    // lazy initialization of the internTable,
    // fill with constant Strings.
    if (internTable == null) {
      internTable = new Hashtable();
      _fillInternTable();
    }
    Object o = internTable.get(this);
    if (o != null) return (String) o;
    internTable.put(this, this);
    return this;
  }

  /** Initialize the internTable from constant Strings. */
  private static native void _fillInternTable();
}

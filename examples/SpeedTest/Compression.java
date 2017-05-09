/*********************************************************************************
 *  SuperWaba Virtual Machine, version 2.0                                       *
 *  Modified by Peter Dickerson <peter.dickerson@ukonline.co.uk> to improve      *
 *  speed.                                                                       *
 *  Copyright (C) 2002 Guilherme Campos Hazan <guich@superwaba.org.>             *
 *  Copyright (C) 2001 Valentim Batista                                          *
 *  All Rights Reserved                                                          *
 *                                                                               *
 *  This library and virtual machine is free software; you can redistribute      *
 *  it and/or modify it under the terms of the Amended GNU Lesser General        *
 *  Public License distributed with this software.                               *
 *                                                                               *
 *  This library and virtual machine is distributed in the hope that it will     *
 *  be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of    *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                         *
 *                                                                               *
 *  All software that links or interacts with this library and virtual machine,  *
 *  or any derivative works, require the software to prominently display the     *
 *  following notice:                                                            *
 *                                                                               *
 *                   Created with SuperWaba                                      *
 *                  http://www.superwaba.org                                     *
 *                                                                               *
 *  Please see the software license located at org/superwaba/license.txt         *
 *  for more details.                                                            *
 *                                                                               *
 *  You should have received a copy of the License along with this software;     *
 *  if not, write to                                                             *
 *                                                                               *
 *     Guilherme Campos Hazan                                                    *
 *     Av. Nossa Senhora de Copacabana 728 apto 605 - Copacabana                 *
 *     Rio de Janeiro / RJ - Brazil                                              *
 *     Cep: 22050-000                                                            *
 *     E-mail: guich@superwaba.org                                               *
 *                                                                               *
 *********************************************************************************/

// package waba.util;

/*
    Compression - a free java compression class based on a static/predefined Huffmann type scheme.
    Compresses text to on average 60%-70% of original size and works with byte[] on input and output.
    Uses waba.sys.Vm.copyArray() to redimension the output byte[].
    This is the compression class used in my Dic program to compress the data and index dbs.
    <p>
    Has 2 public methods to shrink and to grow the data in a byte[] of len bytes:
    public static byte[] shrink(byte[] in, int len)
    public static byte[] grow(byte[] in, int len)
    <p>
    The routine was thought to be used as a text compressor so it's optimized to
    common european language text, but it can be optimized anyhow. It's a kind
    of Huffman encoding but it's statically predefined so it requires only one
    pass, it compresses on the fly using the tables that defined which
    characters are expected to be more commonly found in a text (with in
    addition the caracters ",", ";" and " "). I also used it with the Dic
    indexes forcing the index data to be text characters by means of using byte
    data offsetted to start with "a".
    <p>
    The first 4 characters ('e', ',', 'a', 'r') are reduced to 3 bits;<br>
    The next 8 characters ('i', 'n', 't', 'o', 's', 'l', ';', 'c') are reduced to 5 bits;<br>
    The next 8 characters ('u', 'd', 'm', 'h', 'p', 'g', 'b', ' ') are reducedto 6 bits;<br>
    The next 8 characters ('f', 'v', 'k', 'y', 'w', 'z', 'A', 'q', '-', 'x', 'S', 'B', 'j', 'G', 'E', 'M') are keeped at 8 bits (no gain);<br>
    All other characters are expanded to 12 bits (loss);<br>
    <p>
    Normally a text can be reduced to 60% of original size.
    <p>
    Here is an example of how to use it:
    <pre>
    byte []in = "If you clicked in the SuperWaba icon|and have no idea of what it is... This is|the Java Virtual Machine (JVM) for a|program that you maybe had|installed in your device.".getBytes();
    byte []out = waba.util.Compression.shrink(in,in.length);
    Vm.debug(in.length+" -> "+out.length+" - "+new String(out));
    byte []def = waba.util.Compression.grow(out,out.length);
    String ss = new String(def);
    </pre>    
*/

import waba.sys.*;
 
public class Compression 
{
  private static char[] chrtbl = { 'e', ',', 'a', 'r', 'i', 'n', 't', 'o', 's', 'l', ';', 'c', 'u', 'd', 'm', 'h', 'p', 'g', 'b', ' ', 'f', 'v', 'k', 'y', 'w', 'z', 'A', 'q', '-', 'x', 'S', 'B', 'j', 'G', 'E', 'M'};
  private static int[] tblndx = null;
  private static byte[] bx = 
   {  
     0, 
     1, 1, 1, 1, 
     2, 2, 2, 2, 2, 2, 2, 2, 
     3, 3, 3, 3, 3, 3, 3, 3, 
     4, 4, 4, 4, 4, 4, 4, 4,
     4, 4, 4, 4, 4, 4, 4, 4 
   };
  private static byte[] b1 = { 4, 1, 2, 3, 4 };
  private static byte[] b2 = { 8, 2, 3, 3, 4 };
  private static byte[] bi = { 15, 0, 2, 6, 14 };
  private static byte[] bv = 
   {  
     0, 
     0, 1, 2, 3, 
     0, 1, 2, 3, 4, 5, 6, 7, 
     0, 1, 2, 3, 4, 5, 6, 7, 
     0, 1, 2, 3, 4, 5, 6, 7, 
     8, 9, 10, 11, 12, 13, 14, 15 
   };

  /** Shrinks the given <code>in</code> array with length <code>len</code>
     * @returns a newly created array with the compressed data.
     */
  public static byte[] shrink(byte[] in, int len)
  {
    int i;
    int ol = 0;
    int[] po = {0, 0};      
    int bpoa;
    int bxx;
    int b1l;
    int b2l;
    byte b1v;
    byte b2v;
    byte[] tmp = new byte[len<<1+1];

    if ( tblndx == null )
    {
      tblndx = new int[256];
      for (i=0; i<256; i++) 
        tblndx[i]=0;
      for (i=0; i<chrtbl.length; i++) 
        tblndx[chrtbl[i]]=i+1;
    }

    tmp[0]=0;
    for (i=0; i<len; i++) 
    {
      int ii = ((int)in[i])&0xff;
      bpoa = tblndx[ii];
      bxx = bx[bpoa];
      b1l = b1[bxx];
      b2l = b2[bxx];
      b1v = (byte)bi[bxx];
      if (b2l < 8) 
        b2v = (byte)bv[bpoa];
      else 
        b2v = (byte)ii;
      ol = ol+b1l+b2l;
      putBits(tmp, po, b1v, b1l);
      putBits(tmp, po, b2v, b2l);            
    }     
      
    int xol=ol-((ol>>>3)<<3); // 8 bit multiple ????      
    if (xol>0) 
    {
      int m = 0xff>>>xol;
      xol=8-xol;
      putBits(tmp, po, (byte)m, xol); // 1111111... to pad end to 8 bit multiple
      ol += xol; 
    }

    int bol = ol>>>3;    
    byte[] out = new byte[bol];
    Vm.copyArray(tmp, 0, out, 0, bol); 
    // for (i=0; i<bol; i++) out[i]=tmp[i];
      
    return out;
  }

  /** Grows the given <code>in</code> array with length <code>len</code> compressed with 
     * the <code>shrink</code> method. @returns a newly created array with the expanded data.
     */
  public static byte[] grow(byte[] in, int len)
  {
    byte[] bytes = new byte[(len<<1)+1]; // is supposed that the compression will not be > than 100%
    int ol = 0;
    int[] p = {0, 0, len};
      
    while (p[0]<len)
      bytes[ol++] = getBits(in, p);  
    if (p[1]==99)
      ol--;

    byte[] out = new byte[ol];
    Vm.copyArray(bytes, 0, out, 0, ol);
      
    return out;
  }

  private static void putBits(byte[] a, int[] p, byte b, int l)
  {
    byte z;
    int p0 = p[0], p1 = p[1];
    int s = 8 - p1 - l;
    int v = ((int)b) & 0xff;
    if (s>=0)
      z = (byte)(v << s);
    else
      z = (byte)(v >>> -s);
    a[p0] |= z;
    p1 += l; 
    if (p1>7) 
    {
      p0++;
      a[p0] = 0;
      if (p1>8) 
      {
        s = 16 - p1;
        v = ((int)b) & 0xff;
        if (s>=0)
          z = (byte)(v << s);
        else
          z = (byte)(v >>> -s);
        a[p0] = z;
      }
      p1 -= 8;
    }
    p[0] = p0;
    p[1] = p1;
  }

  private static byte getBits(byte[] b, int[] p)
  {
    byte c = 0;
    int p0 = p[0], p1 = p[1], p2= p[2];
            
    int z = (b[p0]<<p1) & 0xff;

    if (p1>0) 
    {
      if ((p0+1)<p2) 
      {
        z |= ((0xff & ((int)b[p0+1])) >>> (8-p1));
      }
      else 
      {
        if ( (z | (0xff >>> (8-p1))) == 0xff )
        {
          p[0]=p0+1;
          p[1]=99;
          return 0;
        }
      }
    }
      
    if (z < 0x80) 
    {
      c=(byte)chrtbl[(z>>>5)&0x03];
      p1 += 3;
    }
    else if (z < 0xC0) 
    {
      c=(byte)chrtbl[((z>>>3)&0x07)+4];
      p1 += 5;
    }
    else if (z < 0xE0) 
    {
      c=(byte)chrtbl[((z>>>2)&0x07)+12];
      p1 += 6;
    }
    else if (z < 0xF0) 
    {
      c=(byte)chrtbl[(z&0x0f)+20];
      p1 += 8;
    }
    else 
    {
      p1 += 4;
      if (p1 > 7) 
      {
        p0++;
        p1 -= 8;
      }
         
      z = b[p0]<<p1;
      if (p1>0 && (p0+1)<p2)
        z |= ((b[p0+1]&0xff) >>> (8-p1));
      c=(byte)z;
      p1 += 8;
    }
            
    if (p1 > 7) 
    {
      p0++;
      p1 -= 8;
    }
    p[0] = p0;
    p[1] = p1;
      
    return c;
  }
}

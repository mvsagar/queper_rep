/*
     Copyright 2006-2017, QuePer 

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
*/
package com.queper.util.common;
import java.util.*;

public class ConvNumber 
{

  public static String getRomanNumberString(int num) 
  {
     StringBuffer sb = new StringBuffer("");
     int tens = num /10;
     switch(num) {
        case 1: return "I";
        case 2: return "II";
        case 3: return "III";
        case 4: return "IV";
        case 5: return "V";
        case 6: return "VI";
        case 7: return "VII";
        case 8: return "VIII";
        case 9: return "IX";
        case 10: return "X";
        case 11: return "XI";
        case 12: return "XII";
        case 13: return "XIII";
        case 14: return "XIV";
        case 15: return "XV";
        case 16: return "XVI";
        case 17: return "XVII";
        case 18: return "XVIII";
        case 19: return "XIX";
        case 20: return "XX";
        case 21: return "XXI";
        case 22: return "XXII";
        case 23: return "XXIII";
        case 24: return "XXIV";
        case 25: return "XXV";
        case 26: return "XXVI";
        case 27: return "XXVII";
        case 28: return "XXVIII";
        case 29: return "XXIX";
        case 30: return "XXX";
        default: { 
	   // Implement later!
           return Integer.toString(num);
        }
     }
  }

  public static String getSmallRomanNumberString(int num) 
  {
     switch(num) {
        case 1: return "i";
        case 2: return "ii";
        case 3: return "iii";
        case 4: return "iv";
        case 5: return "v";
        case 6: return "vi";
        case 7: return "vii";
        case 8: return "viii";
        case 9: return "ix";
        case 10: return "x";
        case 11: return "xi";
        case 12: return "xii";
        case 13: return "xiii";
        case 14: return "xiv";
        case 15: return "xv";
        case 16: return "xvi";
        case 17: return "xvii";
        case 18: return "xviii";
        case 19: return "xix";
        case 20: return "xx";
        case 21: return "xxi";
        case 22: return "xxii";
        case 23: return "xxiii";
        case 24: return "xxiv";
        case 25: return "xxv";
        case 26: return "xxvi";
        case 27: return "xxvii";
        case 28: return "xxviii";
        case 29: return "xxix";
        case 30: return "xxx";
        default: { 
	   // Implement later!
           return Integer.toString(num);
        }
     }
  }

  public static String getKannadaNumberString(int num) 
  {
     String inStr = Integer.toString(num);
     int nDigits = inStr.length();
     int i, digit;
     StringBuffer outStrBuff = new StringBuffer("");
     
     for (i = 0; i < nDigits; ++i)
     {
	 digit = Integer.parseInt(inStr.substring(i, i+1));
         switch(digit) {
             case 0: outStrBuff.append("\u0CE6"); break;
             case 1: outStrBuff.append("\u0CE7"); break;
             case 2: outStrBuff.append("\u0CE8"); break;
             case 3: outStrBuff.append("\u0CE9"); break;
             case 4: outStrBuff.append("\u0CEA"); break;
             case 5: outStrBuff.append("\u0CEB"); break;
             case 6: outStrBuff.append("\u0CEC"); break;
             case 7: outStrBuff.append("\u0CED"); break;
             case 8: outStrBuff.append("\u0CEE"); break;
             case 9: outStrBuff.append("\u0CEF"); break;
             default: break; 
         }
     }
     return outStrBuff.toString();
  }

  public static String getHindiNumberString(int num) 
  {
     String inStr = Integer.toString(num);
     int nDigits = inStr.length();
     int i, digit;
     StringBuffer outStrBuff = new StringBuffer("");

     for (i = 0; i < nDigits; ++i)
     {
	 digit = Integer.parseInt(inStr.substring(i, i+1));
         switch(digit) {
             case 0: outStrBuff.append("\u0966"); break;
             case 1: outStrBuff.append("\u0967"); break;
             case 2: outStrBuff.append("\u0968"); break;
             case 3: outStrBuff.append("\u0969"); break;
             case 4: outStrBuff.append("\u096A"); break;
             case 5: outStrBuff.append("\u096B"); break;
             case 6: outStrBuff.append("\u096C"); break;
             case 7: outStrBuff.append("\u096D"); break;
             case 8: outStrBuff.append("\u096E"); break;
             case 9: outStrBuff.append("\u096F"); break;
             default: break; 
         }
     }
     return outStrBuff.toString();
  }

  public static String getTeluguNumberString(int num) 
  {
     String inStr = Integer.toString(num);
     int nDigits = inStr.length();
     int i, digit;
     StringBuffer outStrBuff = new StringBuffer("");

     for (i = 0; i < nDigits; ++i)
     {
	 digit = Integer.parseInt(inStr.substring(i, i+1));
         switch(num) {
             case 0: outStrBuff.append("\u0C66"); break;
             case 1: outStrBuff.append("\u0C67"); break;
             case 2: outStrBuff.append("\u0C68"); break;
             case 3: outStrBuff.append("\u0C69"); break;
             case 4: outStrBuff.append("\u0C6A"); break;
             case 5: outStrBuff.append("\u0C6B"); break;
             case 6: outStrBuff.append("\u0C6C"); break;
             case 7: outStrBuff.append("\u0C6D"); break;
             case 8: outStrBuff.append("\u0C6E"); break;
             case 9: outStrBuff.append("\u0C6F"); break;
             default: break; 
         }
     }
     return outStrBuff.toString();
  }

  public static String getAlphaNumberString(int num) 
  {
	return String.valueOf( (char)((int)('A')  + num - 1));
  }

  public static String getSmallAlphaNumberString(int num) 
  {
	return String.valueOf( (char)((int)('a')  + num - 1));
  }

  public static String getNumberString(String numberSystem, int num)
  {
      if (numberSystem.equals("U") || numberSystem.equals("A") ) { // Alphabetic
	   return ConvNumber.getAlphaNumberString(num);
      } else if (numberSystem.equals("L") || numberSystem.equals("a") ) { 
	   return ConvNumber.getSmallAlphaNumberString(num);
      } else if (numberSystem.equals("D")) { //
	   return Integer.toString(num);
      } else if (numberSystem.equals("R")) { //
	   return ConvNumber.getRomanNumberString(num);
      } else if (numberSystem.equals("S") || numberSystem.equals("r")) { 
	   return ConvNumber.getSmallRomanNumberString(num);
      } else if (numberSystem.equals("H")) { 
	   return ConvNumber.getHindiNumberString(num);
      } else if (numberSystem.equals("K")) { 
	   return ConvNumber.getKannadaNumberString(num);
      } else if (numberSystem.equals("T")) { 
	   return ConvNumber.getTeluguNumberString(num);
      } else {
           return new String("");
      }
  }

  public static String getDivisionNotation(String inStr)
  {
      String mantissaStr = null;
      String fractionStr = null;
      int ma = 0;
      int fr = 0;
      StringTokenizer st = new StringTokenizer(inStr, ".", false);
      if (st.hasMoreTokens()) {
	 mantissaStr = st.nextToken();
      }
      if (st.hasMoreTokens()) {
	 fractionStr = st.nextToken();
      }
      if (fractionStr == null) {
	 return mantissaStr;
      } else {
          fr = Integer.parseInt(fractionStr);
          if (fr == 0) {
	     return mantissaStr;
          }
          ma = Integer.parseInt(mantissaStr);
	  if (ma == 0) {
	     mantissaStr = "";
	  } else {
             mantissaStr = mantissaStr + " + ";
	  }
          switch (fr) {
	    case 25: return mantissaStr + "1/" + "4";
	    case 5: return mantissaStr + "1/" + "2";
	    case 50: return mantissaStr + "1/" + "2";
	    case 75: return mantissaStr + "3/" + "4";
            default: return mantissaStr + "." + fractionStr;
     	  }
      }
  }

  public static String getDecimalNotation(String inStr)
  {
      String mantissaStr = null;
      String fractionStr = null;
      float ma = 0.0f;
      float fr = 0.0f;
      String outStr = null;

      StringTokenizer st = new StringTokenizer(inStr, "&+", false);
      if (st.hasMoreTokens()) {
	 mantissaStr = st.nextToken();
      }
      if (st.hasMoreTokens()) {
	 fractionStr = st.nextToken();
      }
      if (fractionStr == null) {
	 // Take care of numbers such as just "1/4", "1/2", etc.
	 fractionStr = mantissaStr;
	 mantissaStr = "0.0";
      } 

      float nu = 0.0f;
      float de = 0.0f;
      float result = 0.0f;

      st = new StringTokenizer(fractionStr, "/", false);
      if (st.hasMoreTokens()) {
	 nu = Float.parseFloat(st.nextToken());
      }
      if (st.hasMoreTokens()) {
	 de = Float.parseFloat(st.nextToken());
      }
      ma = Float.parseFloat(mantissaStr);
      if (de == 0.0f) {
	 result = ma + nu;
      } else { 
	  result = ma + (nu/de);
      }
      outStr =  Float.toString(result);
      return outStr;
  }

} // class

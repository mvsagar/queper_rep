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

import java.io.PrintWriter;
import java.io.StringWriter;

public class StringOps 
{
    final protected static char[] hexArray = "0123456789ABCDEF".toCharArray();

  // For converting string literals for use in SQL stmts.
  // Each single quote is replaced with two single quotes. 
  public static String getSQLString(String inStr) 
  {
    int len = inStr.length();
    char ch = ' ';
    StringBuffer buff = new StringBuffer("");

    for (int i = 0; i < len; ++i)
    {
       ch = inStr.charAt(i);
       buff.append(ch);
       // If there is any single quote, put another single quote 
       // as an esacpe character to make the string compatible with
       // SQL string literals. 
       if (ch == '\'')
	 buff.append(ch);
    }
    return buff.toString();
  }

  // For converting string literals for use in mainly VALUE attributes
  // of HTML tags. This method replaced single and double quotes with
  // corresponding ascii decimal values to avoid problems with HTML
  // processing.
  public static String getHTMLString(String inStr) 
  {
    int len = 0;
    char ch = ' ';
    StringBuffer buff = new StringBuffer("");

    if (inStr == null)
      return null;
    len = inStr.length();
    for (int i = 0; i < len; ++i)
    {
       ch = inStr.charAt(i);
       // If there is any single quote, put another single quote 
       // as an esacpe character to make the string compatible with
       // SQL string literals. 
       if (ch == '"')
	 buff.append("&#34;");
       else if (ch == '\'')
	 buff.append("&#39;");
       else
	 buff.append(ch);
    }
    return buff.toString();
  }

    /*
     * Replaces UTF-8 bytes of a character such as mathematical symbols 
     * of input string inStr with corresponding HTML codes and outputs 
     * a new string.
     *
     * If HTML code is not known, string "?" is output in place of the
     * UTF-8 character bytes.
     */
    public static String replaceSymbolUTF8BytesWithHTMLNames(String inStr)
    {
        int len = inStr.length();
	   	int i = 0;
	   	int i0 = 0, i1 = 0, i2 = 0, i3 = 0, i4 = 0;	// indexed into inStr
	   	int cp = 0, cp1= 0, cp2 = 0, cp3 = 0;	// Characters at positions i0, i1, i2, i3
		StringBuffer outStrBuf = new StringBuffer();	// String after replacement.
	
	   	while (i < len) { 
	   		i0 = i;
      	    cp = inStr.codePointAt(i0); 
      	    switch (cp) {
      	    
	            /*
		     * Do not enable the following code. Or tags in question/answer
		     * text do not work!
		    case 0x3c: // <
				outStrBuf.append("&lt;");
				break;
		    case 0x3e: // >
				outStrBuf.append("&gt;");
				break;
		    */
      	    case 0x2a:	// * symbol
		    	outStrBuf.append("&#1645;");
		    	break;
      	    	
		    case 0xc2: 
		    	i1 = ++i;
		        cp1 = inStr.codePointAt(i1);
				switch (cp1) {
			    case 0xa2: // cent
			    	outStrBuf.append("&cent;");
			    	break;
			    case 0xa3: // pound
			    	outStrBuf.append("&pound;");
			    	break;
			    case 0xa4: // Currency
			    	outStrBuf.append("&curren;");
			    	break;
			    case 0xa5: // yen
			    	outStrBuf.append("&yen;");
			    	break;
			    case 0xa6: // split vertical line
			    	outStrBuf.append("&brvbar;");
			    	break;
			    case 0xa7: // section
			    	outStrBuf.append("&sect;");
			    	break;
			    case 0xa9: // copy right
			    	outStrBuf.append("&copy;");
			    	break;
			    case 0xab: // left double angle quote
			    	outStrBuf.append("&#171;");
			    	break;
			    case 0xac: // logical not
			    	outStrBuf.append("&not;");
			    	break;
			    case 0xae: // registered
			    	outStrBuf.append("&reg;");
			    	break;
			    case 0xb0:
			    	outStrBuf.append("&deg;");
			    	break;
			    case 0xb1: // plus or minus
			    	outStrBuf.append("&plusmn;");
			    	break;
			    case 0xb2: // super script 2
			    	outStrBuf.append("&sup2;");
			    	break;
			    case 0xb3: // super script 3
			    	outStrBuf.append("&sup3;");
			    	break;
			    case 0xbc: // 1/4
			    	outStrBuf.append("&frac14;");
			    	break;
			    case 0xb7: // Mid dot
			    	outStrBuf.append("&middot;");
			    	break;
			    case 0xb9: // super script 1
			    	outStrBuf.append("&sup1;");
			    	break;
			    case 0xbb: // right double angle quote
			    	outStrBuf.append("&#187;");
			    	break;
			    case 0xbd: // 1/2
			    	outStrBuf.append("&frac12;");
			    	break;
			    case 0xbe: // 3/4
			    	outStrBuf.append("&frac34;");
			    	break;
			    default:
			    	outStrBuf.append(inStr.charAt(i0));
			    	outStrBuf.append(inStr.charAt(i1));
			    	break;
				}
				break;	// cp == 0xc2
		
		    case 0xc3: 
		    	i1 = ++i;
		        cp1 = inStr.codePointAt(i1);
				switch (cp1) {
				case 0x97: // Multiplication
				    outStrBuf.append("&times;");
					break;
				case 0xb7: // division
					outStrBuf.append("&divide;");
					break;
				default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					break;
				}	    
				break;	// cp == 0xc3	    

		    case 0xc5: 
		    	i1 = ++i;
		        cp1 = inStr.codePointAt(i1);
				switch (cp1) {
				case 0xbf: // f without horizontal line
				    outStrBuf.append("&#383;");
					break;
				default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					break;
				}
				break;	// cp == 0xc5	    

		    case 0xc6: 
		    	i1 = ++i;
		        cp1 = inStr.codePointAt(i1);
				switch (cp1) {
				case 0x92: // function of/italic f
				    outStrBuf.append("&fnof;");
					break;
				default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					break;
				}
	        	break;	// cp == 0xc6

		    case 0xdb: 
		    	i1 = ++i;
		        cp1 = inStr.codePointAt(i1);
				switch (cp1) {
				case 0x9e: // Some design like muggu!
				    outStrBuf.append("&#1758;");
					break;
				case 0xa2: // 
				    outStrBuf.append("&#1762;");
					break;
				case 0xa9: // House
				    outStrBuf.append("&#1769;");
					break;
				default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					break;
				}
	        	break;	 // cp == 0xdb   

	        // 3 byte utf8 char
	      	case 0xe0: 
	      		i1 = ++i;
	      		i2 = ++i;
		        cp1 = inStr.codePointAt(i1);
		        cp2 = inStr.codePointAt(i2);
		        switch (cp1) {
		        case 0xab: 
		        	switch(cp2) {
		            case 0xaa: // r kind of symbol
		            	outStrBuf.append("&#2794;"); 
		            	break; 
					default:
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
						break;
					}
		        	break;
		        case 0xa9: 
		        	switch(cp2) {
		            case 0xaa: // Symbol lools like 8
		            	outStrBuf.append("&#2666;"); 
		            	break; 
					default:
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
						break;
					}
		        	break;
		        case 0xae: 
		        	switch(cp2) {
		            case 0x83: // Therefore
		            	outStrBuf.append("&#2947;"); 
		            	break; 
					default:
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
						break;
					}
		        	break;
		        case 0xb9: 
		        	switch(cp2) {
		            case 0x8f: // Circle with dot
		            	outStrBuf.append("&#3663;"); 
		            	break; 
		            case 0x90: // Thick Circle
		            	outStrBuf.append("&#3664;"); 
		            	break; 
					default:
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
						break;
					}
		        	break;
		        default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
					break;
				}
	      		break;	// cp == 0xe0
        
            // 3 byte utf8 char
          	case 0xe1: 
          		i1 = ++i;
          		i2 = ++i;
    	        cp1 = inStr.codePointAt(i1);
    	        cp2 = inStr.codePointAt(i2);
    	        switch (cp1) {
    	        case 0x83: 
    	        	switch(cp2) {
    	            case 0xbb: // Therefore turned -90 degrees
    	            	outStrBuf.append("&#4347;"); 
    	            	break; 
    				default:
    					outStrBuf.append(inStr.charAt(i0));
    					outStrBuf.append(inStr.charAt(i1));
    					outStrBuf.append(inStr.charAt(i2));
    					break;
    				}
    	        	break;
    	        default:
    				outStrBuf.append(inStr.charAt(i0));
    				outStrBuf.append(inStr.charAt(i1));
    				outStrBuf.append(inStr.charAt(i2));
    				break;
    			}
          		break;
      		
	        // 3 byte utf8 char
	      	case 0xe2: {
	      		i1 = ++i;
	      		i2 = ++i;
		        cp1 = inStr.codePointAt(i1);
		        cp2 = inStr.codePointAt(i2);
		        
		        switch (cp1) {
		        case 0x80: {
		        	switch(cp2) {
		            case 0x91: // small dash
		            	outStrBuf.append("&#8209;"); 
		            	break; 
		            case 0x93: // en dash
		            	outStrBuf.append("&ndash;"); 
		            	break; 
		            case 0x94: // em dash
		            	outStrBuf.append("&mdash;"); 
		            	break; 
		            case 0x95: // long dash
		            	outStrBuf.append("&#8213;"); 
		            	break; 
		            case 0x97: // short double under line
		            	outStrBuf.append("&#8215;"); 
		            	break; 
		            case 0xa0: // dagger
		            	outStrBuf.append("&#8224;"); 
		            	break; 
		            case 0xa1: // double dagger
		            	outStrBuf.append("&#8225;"); 
		            	break; 
		            case 0xa2: // Bullet
		            	outStrBuf.append("&bull;"); 
		            	break; 
		            case 0xa6: // ellipsis
		            	outStrBuf.append("&#8230;"); 
		            	break; 
		            case 0xb0: // Per thousand
		            	outStrBuf.append("&permil;"); 
		            	break; 
		            case 0xb2: // prime
		            	outStrBuf.append("&#8242;"); 
		            	break; 
		            case 0xb3: // double prime
		            	outStrBuf.append("&#8243;"); 
		            	break; 
		            case 0xb9: // Left single angle quote
		            	outStrBuf.append("&lsaquo;"); 
		            	break; 
		            case 0xba: // Right single angle quote
		            	outStrBuf.append("&rsaquo;"); 
		            	break; 
		            case 0xbe: // over line
		            	outStrBuf.append("&oline;"); 
		            	break; 
		            default: 
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
		            	break; 
		        	}
	            }
	            break;		    
			
            case 0x81: 
                switch(cp2) {
                case 0xb0: // super script 1
                	outStrBuf.append("&#x2070;"); 
                	break; 
                case 0xb1: // super script 1
                	outStrBuf.append("&sup1;"); 
                	break; 
                case 0xb2: // super script 2
                	outStrBuf.append("&sup2;"); 
                	break; 
                case 0xb3: // super script 3
                	outStrBuf.append("&sup2;"); 
                	break; 
                case 0xb4: // super script 4
                	outStrBuf.append("&#x2074;"); 
                	break; 
                case 0xb5: // super script 5
                	outStrBuf.append("&#x2075;"); 
                	break; 
                case 0xb6: // super script 6
                	outStrBuf.append("&#x2076;"); 
                	break; 
                case 0xb7: // super script 7
                	outStrBuf.append("&#x2077;"); 
                	break; 
                case 0xb8: // super script 8
                	outStrBuf.append("&#x2078;"); 
                	break; 
                case 0xb9: // super script 9
                	outStrBuf.append("&#x2079;"); 
                	break; 
                case 0xba: // super script +
                	outStrBuf.append("&#x207A;"); 
                	break; 
                case 0xbb: // super script -
                	outStrBuf.append("&#x207B;"); 
                	break; 
                case 0xbc: // super script =
                	outStrBuf.append("&#x207C;"); 
                	break; 
                case 0xbd: // super script (
                	outStrBuf.append("&#x207D;"); 
                	break; 
                case 0xbe: // super script )
                	outStrBuf.append("&#x207E;"); 
                	break; 
                case 0xbf: // super script n
                	outStrBuf.append("&#x207F;"); 
                	break; 
                default: 
    				outStrBuf.append(inStr.charAt(i0));
    				outStrBuf.append(inStr.charAt(i1));
    				outStrBuf.append(inStr.charAt(i2));
                	break; 
                }
                break;		    

            case 0x82: 
                switch(cp2) {
                case 0x80: // Subscript 0
                	outStrBuf.append("&#x2080;"); 
                	break; 
                case 0x81: // Subscript 1
                	outStrBuf.append("&#x2081;"); 
                	break; 
                case 0x82: // Subscript 2
                	outStrBuf.append("&#x2082;"); 
                	break; 
                case 0x83: // Subscript 3
                	outStrBuf.append("&#x2083;"); 
                	break; 
                case 0x84: // Subscript 4
                	outStrBuf.append("&#x2084;"); 
                	break; 
                case 0x85: // Subscript 5
                	outStrBuf.append("&#x2085;"); 
                	break; 
                case 0x86: // Subscript 6
                	outStrBuf.append("&#x2086;"); 
                	break; 
                case 0x87: // Subscript 7
                	outStrBuf.append("&#x2087;"); 
                	break; 
                case 0x88: // Subscript 8
                	outStrBuf.append("&#x2088;"); 
                	break; 
                case 0x89: // Subscript 9
                	outStrBuf.append("&#x2089;"); 
                	break; 
                case 0x8a: // Subscript +
                	outStrBuf.append("&#x208a;"); 
                	break; 
                case 0x8b: // Subscript -
                	outStrBuf.append("&#x208b;"); 
                	break; 
                case 0x8c: // Subscript =
                	outStrBuf.append("&#x208c;"); 
                	break; 
                case 0x8d: // Subscript (
                	outStrBuf.append("&#x208d;"); 
                	break; 
                case 0x8e: // Subscript )
                	outStrBuf.append("&#x208e;"); 
                	break; 
                case 0xa4: // Lira
                	outStrBuf.append("&#8356;"); 
                	break; 
                case 0xa7: // Peseta
                	outStrBuf.append("&#8359;"); 
                	break; 
                case 0xac: // Euro
                	outStrBuf.append("&euro;"); 
                	break; 
                case 0xaa: // Latched U and upside down U.
                	outStrBuf.append("&#8362;"); 
                	break; 
                case 0xab: // d with horizontal line at the top.
                	outStrBuf.append("&#8363;"); 
                	break; 
                case 0xb9: // Rupee
                	outStrBuf.append("&#8377;"); 
                	break; 
                default: 
    				outStrBuf.append(inStr.charAt(i0));
    				outStrBuf.append(inStr.charAt(i1));
    				outStrBuf.append(inStr.charAt(i2));
                	break; 
                }
                break;		    

            case 0x84: 
            	switch(cp2) {
	            case 0x85: // c/o
	            	outStrBuf.append("&#8453;"); 
	            	break; 
	            case 0x93: // Curved L 
	            	outStrBuf.append("&#8467;"); 
	            	break; 
	            case 0x96: // Number symbol
	            	outStrBuf.append("&#8470;"); 
	            	break; 
	            case 0xa2: // Trade mark
	            	outStrBuf.append("&trade;"); 
	            	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
	            	break; 
            	}
            	break;		    
		    
		    case 0x85: 
		    	switch(cp2) {
	            case 0x93: // 1/3
	            	outStrBuf.append("&#8531;"); 
	            	break; 
	            case 0x94: // 2/3
	            	outStrBuf.append("&#8532;"); 
	            	break; 
	            case 0x95: // 1/5
	            	outStrBuf.append("&#8533;"); 
	            	break; 
	            case 0x96: // 2/5
	            	outStrBuf.append("&#8534;"); 
	            	break; 
	            case 0x97: // 3/5
	            	outStrBuf.append("&#8535;"); 
	            	break; 
	            case 0x98: // 4/5
	            	outStrBuf.append("&#8536;"); 
	            	break; 
	            case 0x99: // 1/6
	            	outStrBuf.append("&#8537;"); 
	            	break; 
	            case 0x9a: // 5/6
	            	outStrBuf.append("&#8538;"); 
	            	break; 
	            case 0x9b: // 1/8
	            	outStrBuf.append("&#8539;"); 
	            	break; 
	            case 0x9d: // 5/8
	            	outStrBuf.append("&#8541;"); 
	            	break; 
	            case 0x9e: // 7/8
	            	outStrBuf.append("&#8542;"); 
	            	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
	            	break; 
		    	}
		    	break;		    

		    case 0x86: // Arrows
			switch (cp2) {
	        	case 0x90: // left arrow
			       	outStrBuf.append("&larr;");
			       	break; 
	            case 0x91: // up arrow
			       	outStrBuf.append("&uarr;");
			       	break; 
	            case 0x92: // right arrow
			       	outStrBuf.append("&rarr;");
			       	break; 
	            case 0x93: // down arrow
			       	outStrBuf.append("&darr;");
			       	break; 
	            case 0x94: // left right arrow
			       	outStrBuf.append("&harr;");
			       	break; 
	            case 0xb5: // down left arrow.
	            	outStrBuf.append("&crarr;"); 
	            	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
				}
		    	break;
		    
		    case 0x87: // Arrows
				switch (cp2) {
		        	case 0x90: // left double arrow
				       	outStrBuf.append("&lArr;");
				       	break; 
		            case 0x91: // up double arrow
				       	outStrBuf.append("&uArr;");
				       	break; 
		            case 0x92: // right double arrow
				       	outStrBuf.append("&rArr;");
				       	break; 
		            case 0x93: // down double arrow
				       	outStrBuf.append("&dArr;");
				       	break; 
		            case 0x94: // left right double arrow
				       	outStrBuf.append("&hArr;");
				       	break; 
		            default: 
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
				       	break; 
				}
				break;
		    
	        case 0x88: 
	        	switch(cp2) {
	            case 0x80: // for all.
	            	outStrBuf.append("&forall;"); 
	            	break; 
	            case 0x82: // partial differential
	            	outStrBuf.append("&part;"); 
	            	break;
	            case 0x83: // There exists
	            	outStrBuf.append("&exist;"); 
	            	break; 
	            case 0x85: // empty set.
			       	outStrBuf.append("&empty;");
			       	break;
	            case 0x86:
			       	outStrBuf.append("&delta;");
			       	break; 
	            case 0x87: // Backward difference.
			       	outStrBuf.append("&nabla;");
			       	break;
	            case 0x88: // Element of.
			       	outStrBuf.append("&isin;");
			       	break;
	            case 0x89: // Not an element of 
			       	outStrBuf.append("&notin;");
			       	break;
	            case 0x8b: // Contains as member 
			       	outStrBuf.append("&ni;");
			       	break;
	            case 0x8f: // N-ary product.
			       	outStrBuf.append("&prod;");
			       	break;
	            case 0x91: // N-ary summation.
			       	outStrBuf.append("&sum;");
			       	break;
	            case 0x92: // Minus
			       	outStrBuf.append("&minus;");
			       	break;
	            case 0x95: // Division slash
			       	outStrBuf.append("&#x2215;");
			       	break;
	            case 0x97: // Asterix-operator.
			       	outStrBuf.append("&lowast;");
			       	break;
	            case 0x99: // Bullet
			       	outStrBuf.append("&bull;");
			       	break;
	            case 0x9a: // square root
			       	outStrBuf.append("&radic;");
			       	break;
	            case 0x9d: // proportional to.
			       	outStrBuf.append("&prop;");
			       	break;
	            case 0x9e: // Infinity
			       	outStrBuf.append("&infin;");
			       	break;
	            case 0x9f: // right angle
			       	outStrBuf.append("&#x221F;");
			       	break;
	            case 0xa0: // angle.
			       	outStrBuf.append("&ang;");
			       	break;
	            case 0xa1: // measured angle.
			       	outStrBuf.append("&#x2221;");
			       	break;
	            case 0xa2: // spherical angle.
			       	outStrBuf.append("&#x2222;");
			       	break;
	            case 0xa3: // Divides.
			       	outStrBuf.append("&#x2223;");
			       	break;
	            case 0xa4: // Does not Divide.
			       	outStrBuf.append("&#x2224;");
			       	break;
	            case 0xa5: // parallel.
			       	outStrBuf.append("&#x2225;");
			       	break;
	            case 0xa6: // not parallel.
			       	outStrBuf.append("&#x2226;");
			       	break;
	            case 0xa7: // Logical and.
			       	outStrBuf.append("&and;");
			       	break;
	            case 0xa8: // Logical or.
			       	outStrBuf.append("&or;");
			       	break;
	            case 0xa9: // Intersection.
			       	outStrBuf.append("&cap;");
			       	break;
	            case 0xaa: // Union.
			       	outStrBuf.append("&cup;");
			       	break;
	            case 0xab: // Integral.
			       	outStrBuf.append("&int;");
			       	break;
	            case 0xb4: // Therefore
			       	outStrBuf.append("&there4;");
			       	break;
	            case 0xb5: // Because
			       	outStrBuf.append("&#x2235;");
			       	break;
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
	            } // switch cp2
			break;
			
		    case 0x89:
		    	switch (cp2) {
		    	case 0x85: // Approximately equal to
		    		outStrBuf.append("&cong;");
		    		break; 
	            case 0x88: // Almost equal to
			       	outStrBuf.append("&asymp;");
			       	break; 
	            case 0xa0: // Not equal to
			       	outStrBuf.append("&ne;");
			       	break; 
	            case 0xa1: // Identical to
			       	outStrBuf.append("&equiv;");
			       	break; 
	            case 0xa4: // <=
			       	outStrBuf.append("&le;");
			       	break; 
	            case 0xa5: // >=
			       	outStrBuf.append("&ge;");
			       	break; 
	            default: 
	            	outStrBuf.append(inStr.charAt(i0));
	            	outStrBuf.append(inStr.charAt(i1));
	            	outStrBuf.append(inStr.charAt(i2));
	            	break; 
		    	}
		    	break;
		    	
		    case 0x8a: 
			switch (cp2) {
	                    case 0x82: // Subset of
			       	outStrBuf.append("&sub;");
			       	break; 
	                    case 0x83: // Superset of
			       	outStrBuf.append("&sup;");
			       	break; 
	                    case 0x84: // Not a subset of
			       	outStrBuf.append("&nsub;");
			       	break; 
	                    case 0x86: // Subset or equal to
			       	outStrBuf.append("&sube;");
			       	break; 
	                    case 0x87: // Superset or equal to
			       	outStrBuf.append("&supe;");
			       	break; 
	                    case 0x95: // Circled plus or direct sum
			       	outStrBuf.append("&#8853;");
			       	break; 
	                    case 0x97: // Circled times or vector product
			       	outStrBuf.append("&#8855;");
			       	break; 
	                    case 0xa5: // Uptack
			       	outStrBuf.append("&perp;");
			       	break; 
	                    case 0xbe: // Right angle with arc
			       	outStrBuf.append("&#x22BE;");
			       	break; 
	                    case 0xbf: // Right triangle
			       	outStrBuf.append("&#x22Bf;");
			       	break; 
	                default: 
	    				outStrBuf.append(inStr.charAt(i0));
	    				outStrBuf.append(inStr.charAt(i1));
	    				outStrBuf.append(inStr.charAt(i2));
			       	break; 
				}
		    	break;
		    
		    case 0x8c: 
		    	switch (cp2) {
	        	case 0x82: // Block up arrow head
			       	outStrBuf.append("&#8962;");
			       	break; 
	        	case 0x88: // Left ceiling
			       	outStrBuf.append("&lceil;");
			       	break; 
	            case 0x89: // Right ceiling
			       	outStrBuf.append("&rceil;");
			       	break; 
	            case 0x8a: // Left floor
			       	outStrBuf.append("&lfloor;");
			       	break; 
	            case 0x8b: // Left floor
			       	outStrBuf.append("&rfloor;");
			       	break; 
	            case 0xa0: // Integral, upper half
			       	outStrBuf.append("&#8992;");
			       	break; 
	            case 0xa1: // Integral, lower half
			       	outStrBuf.append("&#8993;");
			       	break; 
	            case 0xa9: // Left angle bracket
			       	outStrBuf.append("&lang;");
			       	break; 
	            case 0xaa: // Left angle bracket
			       	outStrBuf.append("&rang;");
			       	break; 
				
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
				}
		    	break;

		    case 0x94: 
		    	switch (cp2) {
		    	case 0x80: // Moderate thick dash
			       	outStrBuf.append("&#9472;");
			       	break; 
		    	case 0x82: // Vertical line.
			       	outStrBuf.append("&#9474;");
			       	break; 
		    	case 0x8c: // top left corner
			       	outStrBuf.append("&#9484;");
			       	break; 
		    	case 0x90: // top right corner
			       	outStrBuf.append("&#9488;");
			       	break; 
		    	case 0x94: // bottom left corner
			       	outStrBuf.append("&#9492;");
			       	break; 
		    	case 0x98: // bottom right corner
			       	outStrBuf.append("&#9496;");
			       	break; 
		    	case 0x9c: // Left T
			       	outStrBuf.append("&#9500;");
			       	break; 
		    	case 0xa4: // Right T
			       	outStrBuf.append("&#9508;");
			       	break; 
		    	case 0xac: // T junction
			       	outStrBuf.append("&#9516;");
			       	break; 
		    	case 0xb2: // T junction
			       	outStrBuf.append("&#9522;");
			       	break; 
		    	case 0xb4: // Inversed T junction
			       	outStrBuf.append("&#9524;");
			       	break; 
		    	case 0xbc: // Plus form
			       	outStrBuf.append("&#9532;");
			       	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
		    	}
		    	break;
		    
		    case 0x95: 
		    	switch (cp2) {
		    	case 0x91: // Vertical double lime.
			       	outStrBuf.append("&#9553;");
			       	break; 
		    	case 0x92: // F type corner.
			       	outStrBuf.append("&#9554;");
			       	break; 
		    	case 0x93: // Corner looks like pi.
			       	outStrBuf.append("&#9555;");
			       	break; 
		    	case 0x94: // double line top left corner
			       	outStrBuf.append("&#9556");
			       	break; 
		    	case 0x95: // top right corner with double horizontal line
			       	outStrBuf.append("&#9557;");
			       	break; 
		    	case 0x96: // top right corner with double vertical line
			       	outStrBuf.append("&#9558;");
			       	break; 
		    	case 0x97: // double line top right corner
			       	outStrBuf.append("&#9559;");
			       	break; 
		    	case 0x98: // bottom left corner with double horizontal line
			       	outStrBuf.append("&#9560;");
			       	break; 
		    	case 0x99: // bottom left corner with double vertical line
			       	outStrBuf.append("&#9561;");
			       	break; 
		    	case 0x9a: // double lined bottom left corner
			       	outStrBuf.append("&#9562;");
			       	break; 
		    	case 0x9b: // bottom right corner with double horizontal line 
			       	outStrBuf.append("&#9563;");
			       	break; 
		    	case 0x9c: // bottom right corner with double vertical line 
			       	outStrBuf.append("&#9564;");
			       	break; 
		    	case 0x9d: // double lined bottom right corner
			       	outStrBuf.append("&#9565;");
			       	break; 
		    	case 0x9e: // Left T with double horizontal line
			       	outStrBuf.append("&#9566;");
			       	break; 
		    	case 0x9f: // Left T with double vertical line
			       	outStrBuf.append("&#9567;");
			       	break; 
		    	case 0xa0: // Left T with double vertical and horizontal lines
			       	outStrBuf.append("&#9568;");
			       	break; 
		    	case 0xa1: // Right T with double Horizontal line
			       	outStrBuf.append("&#9569;");
			       	break; 
		    	case 0xa2: // Right T with double vertical line
			       	outStrBuf.append("&#9570;");
			       	break; 
		    	case 0xa3: // Right T with double lines
			       	outStrBuf.append("&#9571;");
			       	break; 
		    	case 0xa4: // T with double horizontal lines
			       	outStrBuf.append("&#9572;");
			       	break; 
		    	case 0xa5: // T with double vertical lines
			       	outStrBuf.append("&#9573;");
			       	break; 
		    	case 0xa6: // Double lined T junction
			       	outStrBuf.append("&#9574;");
			       	break; 
		    	case 0xa7: // Inversed T with double horizontal line
			       	outStrBuf.append("&#9575;");
			       	break; 
		    	case 0xa8: // Inversed T with double vertical line
			       	outStrBuf.append("&#9576;");
			       	break; 
		    	case 0xa9: // Inversed T with double line
			       	outStrBuf.append("&#9577;");
			       	break; 
		    	case 0xaa: // Double horizontal line with a vertical line
			       	outStrBuf.append("&#9578;");
			       	break; 
		    	case 0xab: // Single horizontal line cut by a double vertical line
			       	outStrBuf.append("&#9579;");
			       	break; 
		    	case 0xac: // Double horizontal line cut by a double vertical line
			       	outStrBuf.append("&#9580;");
			       	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
		    	}
		    	break;

		    case 0x96: 
		    	switch (cp2) {
		    	case 0x80: // Solid half-box top
			       	outStrBuf.append("&#9600;");
			       	break; 
		    	case 0x84: // Solid half-box bottom
			       	outStrBuf.append("&#9604;");
			       	break; 
		    	case 0x88: // Full box
			       	outStrBuf.append("&#9608;");
			       	break; 
		    	case 0x8c: // Solid half-box left
			       	outStrBuf.append("&#9612;");
			       	break; 
		    	case 0x90: // Solid half-box right
			       	outStrBuf.append("&#9616;");
			       	break; 
		    	case 0x91: // Dither light
			       	outStrBuf.append("&#9617;");
			       	break; 
		    	case 0x92: // Dither medium
			       	outStrBuf.append("&#9618;");
			       	break; 
		    	case 0x93: // Dither heavy
			       	outStrBuf.append("&#9619;");
			       	break; 
		    	case 0xa0: // Solid medium square
			       	outStrBuf.append("&#9632;");
			       	break; 
		    	case 0xa1: // Hollow medium square
			       	outStrBuf.append("&#9633;");
			       	break; 
		    	case 0xaa: // Solid small square
			       	outStrBuf.append("&#9642;");
			       	break; 
		    	case 0xab: // Hollow small square
			       	outStrBuf.append("&#9643;");
			       	break; 
		    	case 0xb2: // Solid upward arrow head
			       	outStrBuf.append("&#9650;");
			       	break; 
		    	case 0xba: // Solid rightward arrow head
			       	outStrBuf.append("&#9658;");
			       	break; 
		    	case 0xbc: // Solid downward arrow head
			       	outStrBuf.append("&#9660;");
			       	break; 
		    	case 0xac: // thick dash
			       	outStrBuf.append("&#9644;");
			       	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
		    	}
		    	break;
		    

		    case 0x97: 
		    	switch (cp2) {
		    	case 0x84: // Solid leftward arrow head
			       	outStrBuf.append("&#9668;");
			       	break; 
		    	case 0x8a: // Lozenge
			       	outStrBuf.append("&loz;");
			       	break; 
		    	case 0x8b: // Circle
			       	outStrBuf.append("&#9675;");
			       	break; 
		    	case 0x8f: // Filled Circle
			       	outStrBuf.append("&#9679;");
			       	break; 
		    	case 0x98: // Square with a hole
			       	outStrBuf.append("&#9688;");
			       	break; 
		    	case 0x99: // Black Square with black hole
			       	outStrBuf.append("&#9689;");
			       	break; 
		    	case 0xa6: // Small circle
			       	outStrBuf.append("&#9702;");
			       	break; 
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
			       	break; 
		    	}
		    	break;
		    

			    case 0x98: 
			    	switch (cp2) {
			    	case 0x84: // Commet
				       	outStrBuf.append("&#9732;");
				       	break; 
			    	case 0x85: // Star
				       	outStrBuf.append("&#9733;");
				       	break; 
			    	case 0x89: // The Sun
				       	outStrBuf.append("&#9737;");
				       	break; 
			    	case 0x8a: // Ascending node
				       	outStrBuf.append("&#9738;");
				       	break; 
			    	case 0x8b: // Descending node
				       	outStrBuf.append("&#9739;");
				       	break; 
			    	case 0x8c: // Conjunction
				       	outStrBuf.append("&#9740;");
				       	break; 
			    	case 0x8d: // Opposition
				       	outStrBuf.append("&#9741;");
				       	break; 
			    	case 0xba: // Smiley
				       	outStrBuf.append("&#9786;");
				       	break; 
			    	case 0xbb: // Black Smiley
				       	outStrBuf.append("&#9787;");
				       	break; 
			    	case 0xbc: // Sun
				       	outStrBuf.append("&#9788;");
				       	break; 
			    	case 0xbd: // Moon, 1st quarter
				       	outStrBuf.append("&#9789;");
				       	break; 
			    	case 0xbe: // Moon, last quarter
				       	outStrBuf.append("&#9790;");
				       	break; 
			    	case 0xbf: // Mercury
				       	outStrBuf.append("&#9791;");
				       	break; 
		            default: 
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
				       	break; 
			    	}
			    	break;
		    
			    case 0x99: 
					switch (cp2) {
			        case 0x80: // Venus/female
			        	outStrBuf.append("&#9792;");
					    break; 
			        case 0x81: // Earth
			        	outStrBuf.append("&#9793;");
					    break; 
			        case 0x82: // Mars/Male
			        	outStrBuf.append("&#9794;");
					    break; 
			        case 0x83: // Jupiter
			        	outStrBuf.append("&#9795;");
					    break; 
			        case 0x84: // Saturn
			        	outStrBuf.append("&#9796;");
					    break; 
			        case 0x85: // Uranus
			        	outStrBuf.append("&#9797;");
					    break; 
			        case 0x86: // Neptune
			        	outStrBuf.append("&#9798;");
					    break; 
			        case 0x87: // Pluto
			        	outStrBuf.append("&#9799;");
					    break; 
			        case 0x88: // Aries
			        	outStrBuf.append("&#9800;");
					    break; 
			        case 0x89: // Taurus
			        	outStrBuf.append("&#9801;");
					    break; 
			        case 0x8a: // Gemini
			        	outStrBuf.append("&#9802;");
					    break; 
			        case 0x8b: // Cancer
			        	outStrBuf.append("&#9803;");
					    break; 
			        case 0x8c: // Leo
			        	outStrBuf.append("&#9804;");
					    break; 
			        case 0x8d: // Virgi
			        	outStrBuf.append("&#9805;");
					    break; 
			        case 0x8e: // Libra
			        	outStrBuf.append("&#9806;");
					    break; 
			        case 0x8f: // Scorpius
			        	outStrBuf.append("&#9807;");
					    break; 
			        case 0x90: // Sagittarius
			        	outStrBuf.append("&#9808;");
					    break; 
			        case 0x91: // Capricorn
			        	outStrBuf.append("&#9809;");
					    break; 
			        case 0x92: // Aquarius
			        	outStrBuf.append("&#9810;");
					    break; 
			        case 0x93: // Pisces
			        	outStrBuf.append("&#9811;");
					    break; 
			        case 0xa0: // spade
			        	outStrBuf.append("&spades;");
					    break; 
			        case 0xa3: // club
			        	outStrBuf.append("&clubs;");
					    break; 
			        case 0xa5: // heart
			        	outStrBuf.append("&hearts;");
					    break; 
			        case 0xa6: // diamond
			        	outStrBuf.append("&diams;");
					    break; 
			        case 0xaa: // single music note
			        	outStrBuf.append("&#9834;");
					    break; 
			        case 0xab: // Double music note
			        	outStrBuf.append("&#9835;");
					    break; 
			        default: 
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
					    break; 
					}
					break;
		    
			    
			    case 0x9a: 
					switch (cp2) {
			        case 0x95: // Hygeia 
			        	outStrBuf.append("&#9877;");
					    break; 
			        case 0x98: // Flora
			        	outStrBuf.append("&#9880;");
					    break; 
			        case 0xb3: // Ceres
			        	outStrBuf.append("&#9907;");
					    break; 
			        case 0xb4: // Pallas
			        	outStrBuf.append("&#9908;");
					    break; 
			        case 0xb5: // Juno
			        	outStrBuf.append("&#9909;");
					    break; 
			        case 0xb6: // Vesta
			        	outStrBuf.append("&#9910;");
					    break; 
			        default: 
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
					    break; 
					}
					break;
			    
			    case 0x9b: 
					switch (cp2) {
			        case 0xa2: // Euranus
			        	outStrBuf.append("&#9954;");
					    break; 
			        default: 
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
					    break; 
					}
					break;
			    
			    
	            default: 
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
	            	break; 
	        	} // switch cp1 
      		} // cp = 0xe2
      		break;
	    
	    case 0xce: 
	    	i1 = ++i;
	        cp1 = inStr.codePointAt(i1);
			switch (cp1) {
			case 0x91:
				outStrBuf.append("&Alpha;");
				break;
			case 0x92:
				outStrBuf.append("&Beta;");
				break;
			case 0x93:
				outStrBuf.append("&Gamma;");
				break;
			case 0x94:
				outStrBuf.append("&Delta;");
				break;
			case 0x95:
				outStrBuf.append("&Epsilon;");
				break;
			case 0x96:
				outStrBuf.append("&Zeta;");
				break;
			case 0x97:
				outStrBuf.append("&Eta;");
				break;
			case 0x98:
				outStrBuf.append("&Theta;");
				break;
			case 0x99:
				outStrBuf.append("&Iota;");
				break;
			case 0x9a:
				outStrBuf.append("&Kappa;");
				break;
			case 0x9b:
				outStrBuf.append("&Lambda;");
				break;
			case 0x9c:
				outStrBuf.append("&Mu;");
				break;
			case 0x9d:
				outStrBuf.append("&Nu;");
				break;
			case 0x9e:
				outStrBuf.append("&Xi;");
				break;
			case 0x9f:
				outStrBuf.append("&Omicron;");
				break;
			case 0xa0:
				outStrBuf.append("&Pi;");
				break;
			case 0xa1:
				outStrBuf.append("&Rho;");
				break;
			case 0xa3:
				outStrBuf.append("&Sigma;");
				break;
			case 0xa4:
				outStrBuf.append("&Tau;");
				break;
			case 0xa5:
				outStrBuf.append("&Upsilon;");
				break;
			case 0xa6:
				outStrBuf.append("&Phi;");
				break;
			case 0xa7:
				outStrBuf.append("&Chi;");
				break;
			case 0xa8:
				outStrBuf.append("&Phi;");
				break;
			case 0xa9:
				outStrBuf.append("&Omega;");
				break;
			case 0xb1:
				outStrBuf.append("&alpha;");
				break;
			case 0xb2:
				outStrBuf.append("&beta;");
				break;
			case 0xb3:
				outStrBuf.append("&gamma;");
				break;
			case 0xb4:
				outStrBuf.append("&delta;");
				break;
			case 0xb5:
				outStrBuf.append("&epsilon;");
				break;
			case 0xb6:
				outStrBuf.append("&zeta;");
				break;
			case 0xb7:
				outStrBuf.append("&eta;");
				break;
			case 0xb8:
				outStrBuf.append("&theta;");
				break;
			case 0xb9:
				outStrBuf.append("&iota;");
				break;
			case 0xba:
				outStrBuf.append("&kappa;");
				break;
			case 0xbb:
				outStrBuf.append("&lambda;");
				break;
			case 0xbc:
				outStrBuf.append("&mu;");
				break;
			case 0xbd:
				outStrBuf.append("&nu;");
				break;
			case 0xbe:
				outStrBuf.append("&xi;");
				break;
			case 0xbf:
				outStrBuf.append("&omicron;");
				break;
			default:
				outStrBuf.append(inStr.charAt(i0));
				outStrBuf.append(inStr.charAt(i1));
				break;
			}
			break; // cp = 0xce
	    
		    case 0xcf: 
		    	i1 = ++i;
		        cp1 = inStr.codePointAt(i1);
		        switch (cp1) {
			    case 0x80:
			    	outStrBuf.append("&pi;");
			    	break;
			    case 0x81:
			    	outStrBuf.append("&rho;");
			    	break;
			    case 0x83:
			    	outStrBuf.append("&sigma;");
			    	break;
			    case 0x84:
			    	outStrBuf.append("&tau;");
			    	break;
			    case 0x85:
			    	outStrBuf.append("&upsilon;");
			    	break;
			    case 0x86:
			    	outStrBuf.append("&phi;");
			    	break;
			    case 0x87:
			    	outStrBuf.append("&chi;");
			    	break;
			    case 0x88:
			    	outStrBuf.append("&phi;");
			    	break;
			    case 0x89:
			    	outStrBuf.append("&omega;");
			    	break;
			    default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
			    	break;
		        }
		        break;

		    
		    case 0xf0: 
		    	i1 = ++i;
		    	i2 = ++i;
		    	i3 = ++i;
		        cp1 = inStr.codePointAt(i1);
		        cp2 = inStr.codePointAt(i2);
		        cp3 = inStr.codePointAt(i3);
		        switch (cp1) {
			    case 0x9f:
			        switch (cp2) {
			    	case 0x8c:
			    		switch (cp3) {
			    		case 0x91: // New Moon
				    		outStrBuf.append("&#127761;");
				    		break;
			    		case 0x95: // Full Moon
				    		outStrBuf.append("&#127765;");
				    		break;
			    		case 0x9a: // New Moon
				    		outStrBuf.append("&#127770;");
				    		break;
			    		case 0x9b: // Moon, 1st quarter
				    		outStrBuf.append("&#127771;");
				    		break;
			    		case 0x9c: // Moon, last quarter
				    		outStrBuf.append("&#127772;");
				    		break;
			    		case 0x9d: // Full Moon
				    		outStrBuf.append("&#127773;");
				    		break;
			    		case 0x9e: // Face of the sun
				    		outStrBuf.append("&#127774;");
				    		break;
					    default:
							outStrBuf.append(inStr.charAt(i0));
							outStrBuf.append(inStr.charAt(i1));
							outStrBuf.append(inStr.charAt(i2));
							outStrBuf.append(inStr.charAt(i3));
					    	break;
			    		} // switch cp3
			    		break;
			    	case 0x8d:
			    		switch (cp3) {
			    		case 0xb7: // Hebe
				    		outStrBuf.append("&#127863;");
				    		break;
					    default:
							outStrBuf.append(inStr.charAt(i0));
							outStrBuf.append(inStr.charAt(i1));
							outStrBuf.append(inStr.charAt(i2));
							outStrBuf.append(inStr.charAt(i3));
					    	break;
			    		} // switch cp3
			    		break;
			    	case 0x9c:
			    		switch (cp3) {
			    		case 0x9a: // Sun with one ray
				    		outStrBuf.append("&#128794;");
				    		break;
			    		case 0xa8: // Earth
				    		outStrBuf.append("&#128808;");
				    		break;
					    default:
							outStrBuf.append(inStr.charAt(i0));
							outStrBuf.append(inStr.charAt(i1));
							outStrBuf.append(inStr.charAt(i2));
							outStrBuf.append(inStr.charAt(i3));
					    	break;
			    		} // switch cp3
			    		break;
				    default:
						outStrBuf.append(inStr.charAt(i0));
						outStrBuf.append(inStr.charAt(i1));
						outStrBuf.append(inStr.charAt(i2));
						outStrBuf.append(inStr.charAt(i3));
				    	break;
			        } // switch cp2
			        break;
			    default:
					outStrBuf.append(inStr.charAt(i0));
					outStrBuf.append(inStr.charAt(i1));
					outStrBuf.append(inStr.charAt(i2));
					outStrBuf.append(inStr.charAt(i3));
			    	break;
		        } // switch cp1
		        break; // case cp == 0xf0
		    
	    	default: 
		    // Output the character without any change.
	            outStrBuf.append(inStr.charAt(i0));
	            break; 
        	} // switch cp 
        	++i;
   		} // while
   		return outStrBuf.toString();
    }

    /*
     * Method used to transform question (group) text for printing.
     *
     * Q_20100904_00017:
     * If the question contains QHTML tag, print everything
     * between the tags as it is. Otherwise, output BR tag
     * for every new line character and &nbsp for every space.
     */
    /*
    public static String xformTextForPrinting(String inText)
    {
        boolean qhtmlTag = false;
	String subStr = null;
	StringBuffer outBuff = new StringBuffer("");

	if (inText == null) {
	    return new String("");
	}

	for (int i = 0; i < inText.length(); ++i) {
	    if ((i + 7) < inText.length()) {
	        try {
	            subStr = inText.substring(i, i+7);
		    if (subStr != null && subStr.equals("<QHTML>")) {
                        qhtmlTag = true;
		    }
                } catch(StringIndexOutOfBoundsException e) {
	            // Debug stmt: out.print("index=" + i);
                }
	     }
	     if ((i + 8) < inText.length()) {
	         try {
	             subStr = inText.substring(i, i+8);
		     if (subStr != null && subStr.equals("</QHTML>")) {
                         qhtmlTag = false;
		     }
                 } catch(StringIndexOutOfBoundsException e) {
	            // Debug stmt: out.print("index=" + i);
	         }
             }
	     if (qhtmlTag == false) {
	         if (inText.charAt(i) == '\n') {
	             outBuff.append("<BR>");
	         } else if (inText.charAt(i) == ' ') {
	             outBuff.append("&nbsp;");
	         } else {
	             outBuff.append(inText.charAt(i));
	         }
	     } else {
	          outBuff.append(inText.charAt(i));
	     }
	}
	return outBuff.toString();
    }
    */

    /*
    public static String xformTextForPrinting(String inText)
    {
	int MAXLINELEN = 80;

	String subStr = null;
	StringBuffer outBuff = new StringBuffer("");

	if (inText == null) {
	    return new String("");
	}

	String strArr[] = inText.split(" ");
	int arrSize = strArr.length;
	int lineLen = 0;
	int termLen = 0;
	String term = null;

	for (int i = 0; i < arrSize; ++i) {
            term = strArr[i];
	    termLen = term.length();
	    if (lineLen + termLen <= MAXLINELEN) {
		outBuff.append(" " + term);
		lineLen += termLen;
	    } else {
		outBuff.append("<BR>");
		outBuff.append(" " + term);
		lineLen = termLen;
            }
	}
	return outBuff.toString();
    }
    */

    public static String xformTextForPrinting(String inText)
    {
	int MAXLINELEN = 80;

	String subStr = null;
	StringBuffer outBuff = new StringBuffer("");

	if (inText == null) {
	    return new String("");
	}

	int strLen = inText.length();

	for (int i = 0; i < strLen; ++i) {
            if (inText.charAt(i) == '\n') {
		 outBuff.append("<BR>");
            } else {
		 outBuff.append(inText.charAt(i) );
	    }
	}
	return outBuff.toString();
    }

    public static String convertUtf8ToUnicode(String inText)
    {
        int l = inText.length();
        byte[] utf8Bytes = new byte[l];

        for (int j = 0; j < l; ++j) {
            utf8Bytes[j] = (byte)inText.codePointAt(j);
        }
		try {
	            return new String(utf8Bytes, "UTF-8");
		} catch (java.io.UnsupportedEncodingException ex) {
		    return "QuePer: Error in converting text to Unicode";
		}
    }
    
    // Converts UTF8 bytes to Unicode string.
    public static String convertUtf8ToUnicode(byte[] inBytes)
    {
		if (inBytes == null) {
            return null;
		}
		try {
            return new String(inBytes, "UTF-8");
		} catch (java.io.UnsupportedEncodingException ex) {
		    return "QuePer: Error in converting UTF-8 bytes to Unicode";
		}
    }

    // transform for java script.
    public static String xForm4JS(String inStr)
    {
	String outStr="";

	if (inStr == null) {
            return null;
	}
	// Remove double quotes.
	outStr =  inStr.replaceAll("\"", "\\\\\"");
	// Escape new line character to avoid interpretation by java.
	outStr =  outStr.replaceAll("\n", "\\\\n");
	return outStr;
    }    


    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = hexArray[v >>> 4];
            hexChars[j * 2 + 1] = hexArray[v & 0x0F];
        }
        return new String(hexChars);
    }

    public static byte[] hexToBytes(String s) {
        int len = s.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
                             + Character.digit(s.charAt(i+1), 16));
        }
        return data;
    }
    

    public static String bytesToBits(byte[] bytes) {
        String bitStr = "";
        for (int j = 0; j < bytes.length; j++) {
	    bitStr += Integer.toBinaryString(bytes[j] & 0xFF);
        }
        return bitStr;
    }
    
	/*
	 * Convert strings such as column values to a CSV separated values in a string
	 * 
	 * E.g. If values[] = {"5.03", "Clear", "E"} to 5.03, Clear, E.
	 */
	public static String convertStrArrToCSVString(String values[])
	{
		StringBuilder sb = new StringBuilder();
		for (String v : values) { 
			if (sb.length() > 0) sb.append(',');
			sb.append(v);
		}
		return sb.toString();
	}
	
	/*
	 * Convert strings such as column values to a CSV separated values in a string
	 * mainly for use in INSERT statements.
	 * 
	 * E.g. If values[] = {"5.03", "Clear", "E"} to '5.03', 'Clear', 'E'.
	 */
	public static String convertStrArrToCSVStringQuoted(String values[])
	{
		StringBuilder sb = new StringBuilder();
		for (String v : values) { 
			if (sb.length() > 0) sb.append(',');
			sb.append("'").append(v).append("'");
		}
		return sb.toString();
	}
	
    public static void printStackTrace(StackTraceElement[] stackTrace, PrintWriter pw) {
        for(StackTraceElement stackTraceEl : stackTrace) {
            pw.println(stackTraceEl);
        }
    }	
	public static String stackTraceToString(StackTraceElement[] stackTrace) {
        StringWriter sw = new StringWriter();
        printStackTrace(stackTrace, new PrintWriter(sw));
        return sw.toString();
    }	

  /*
  public static void main(String[] args) 
  {
    // Test the method.
    System.out.println(StringOps.getSQLString("Boy's School"));
    System.out.println(StringOps.getSQLString(
		    "Scholl name is \"Baldwin Boy's High School\""));
  }
  */
	  
} // class

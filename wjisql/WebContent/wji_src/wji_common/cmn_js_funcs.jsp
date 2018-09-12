/*
     Copyright 2006-2017 Vidyasagar Mundroy

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
/*
 * Returns true if a row is selected.
 */
function row_selected(form, fld_prefix, fld_col, n_rows)
{	
   for ( i = 1; i <= n_rows; ++i) { 
      if (form.elements[fld_prefix + i + fld_col].checked) {
         return true;
      }
   }
   return false;
} 

/*
 * Returns selected row number.
 */
function get_selected_row(form, fld_prefix, fld_col, n_rows)
{	
   for ( i = 1; i <= n_rows; ++i) { 
      if (form.elements[fld_prefix + "r" + i + "c" + fld_col].checked) {
         return i;
      }
   }
   return 0;
} 


function rtrim(str)
{
  var i = 0;
  var len1 = 0;
  var len2 = str.length;

  // alert("len2 = " + len2);

  for (i = len2 - 1; i > 0; --i) {
     if (str.charAt(i) != ' ')
	break;
  }
	  
  return str.substring(0, i+1);
}

function ltrim(str)
{
  var i = 0;
  var len1 = 0;
  var len2 = str.length;

  for (i = 0; i < len2; ++i) {
     if (str.charAt(i) != ' ')
	break;
  }
	  
  return str.substring(i, len2);
}

function trim(str)
{
    return ltrim(rtrim(str));
}

/*
 * Checks if the input string is a number.
 */
function is_num(in_str)
{
    var i = 0;
    var ch = ' ';    
    var dot_count = 0;

    num_str = trim(in_str);

    if (num_str == null || num_str == "") {
	return false;
    }
    for (i = 0; i < num_str.length; ++i) {
        ch = num_str.charAt(i);
        if (i == 0  &&  (ch == '-' || ch == '+')) {
             continue;
	} else if (ch == '.') {
             ++dot_count;
        } else if (ch < '0' || ch > '9') {
            return false;
        }
    }
    if (dot_count > 1) {
       return false;
    }
    return true;
}

function is_valid_date(date_str)
{
    var year, month, day;

    year = date_str.substring(0, 4);
    if (is_num(year) == false) {
	return "invalid_year";
    }

    month = date_str.substring(5, 7);
    if (is_num(month) == false) {
	return "invalid_month";
    }
    if (month < "01" || month > "12") {
	return "invalid_month";
    }

    day = date_str.substring(8, 10);
    if (is_num(day) == false) {
	return "invalid_day";
    }
    if (day < "01" || day > "31") {
	return "invalid_day";
    }
    return "valid_date";
}



function getDivisionNotation(inStr)
{
      var mantissaStr = null;
      var fractionStr = null;
      var ma = 0;
      var fr = 0;
      var numparts = inStr.split(".");
      if (numparts[0] != null) {
	 mantissaStr = numparts[0];
      }
      if (numparts[1] != null) {
	 fractionStr = numparts[1];
      }
      if (fractionStr == null) {
	 return mantissaStr;
      } else {
          fr = parseInt(fractionStr);
          if (fr == 0) {
	     return mantissaStr;
          }
          ma = parseInt(mantissaStr);
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

/*
* Converts strings such as "30 + 1/2" to decimal notation such as "30.5".
*/
function getDecimalNotation(inStr)
{
  //alert("inStr=" + inStr);
  var mantissaStr = null;
  var fractionStr = null;
  var ma = 0.0;
  var fr = 0.0;
  var numParts = inStr.split("+");
  var outStr = null;

  if (numParts[0] != null) {
    mantissaStr = numParts[0];
  }
  if (numParts[1] != null) {
    fractionStr = numParts[1];
  }
  if (fractionStr == null) {
    fractionStr = mantissaStr;
    mantissaStr = "0.0";
  } 
  var nu = 0.0;
  var de = 0.0;
  var result = 0.0;

  numParts = fractionStr.split("/");
  if (numParts[0] != null) {
    nu = parseFloat(numParts[0]);
  }
  if (numParts[1] != null) {
    de = parseFloat(numParts[1]);
  }
  ma = parseFloat(mantissaStr);
  if (de == 0.0) {
    result = ma + nu;
  } else { 
    result = ma + (nu/de);
  }
  outStr =  result + ''; // converting to string.
  // alert("result=" + outStr);
  return outStr;
} // getDecimalNotation.

function getFileNameFromPath(in_path) {
    var nparts = 1;
    var fname = in_path;
    var out_path = "";

    //alert("in path="+ in_path);
    var parts = in_path.split("\\");
    if (parts == null) {
        alert("parts is null");
        return in_path;
    }
    nparts = parts.length;
    //alert("noof parts="+ nparts);
    if (nparts == 1) { // no dir path in the file
       fname = in_path;
    } else {
       fname = parts[nparts-1];
    }
    //alert("fname="+ fname);
    return fname;
}

function getImageFilePath(in_path) {
    var fname = "";
    var out_path = "";
    var user_id = ""; // use it later so that users can keep their
                      // image files from their respective sub-directories.

    fname = getFileNameFromPath(in_path);
    if (user_id == null || user_id == "") {
        out_path = "C:\\QuePer\\images\\" + fname;
    } else {
        out_path = "C:\\QuePer\\images\\" + user_id + "\\" + fname;
    }
    return out_path;
}

function displayMessageConfirm(type, errCode, errMsg, doConfirm)
{
    var errMsg1 = "";
    var errType = "";

    if (type != null && type != "") {
        errType = type + " ";
    }
    if (errCode != null && errCode != "") {
   	if (errCode == "1062") {
      	    errMsg1 = errCode + ": Can not add as it is a duplicate entry.";
   	} else if (errCode == "1451") {
      	    errMsg1 = errCode + ": Can not delete/update as there exists dependent data.";
   	} else {
      	    errMsg1 = errCode + ".";
   	}
        if (errMsg != null && errMsg != "") {
           if (doConfirm) {
               return confirm(errType + errMsg1 + "\n\n"  + errMsg 
                   + "\n\n" + "Do you want to skip seeing further error messages?"
                   );
           } else {
               alert(errType + errMsg1 + "\n\n"  + errMsg);
               return false;
           }
        } else {
           if (doConfirm) {
               return confirm(errType + errMsg1
                   + "\n\n" + "Do you want to skip seeing further error messages?"
                   );
           } else {
               alert(errType + errMsg1);
               return false;
           }
        }
    } else {
        if (doConfirm) {
            return confirm(errType +  errMsg
                   + "\n\n" + "Do you want to skip seeing further error messages?"
                );
        } else {
            alert(errType +  errMsg);
            return false;
        }
    }
}

function displayMessage(type, errCode, errMsg)
{
    displayMessageConfirm(type, errCode, errMsg, false);
}



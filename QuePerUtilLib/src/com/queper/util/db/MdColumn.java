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

package com.queper.util.db;

/*
 * Class used to store metadata of a column of a table.
 */
public class MdColumn {
    String colName;
    int colType;
    String colTypeName;
    boolean isColNullable;
    String colDefault;
    boolean isColAutoIncrement;

    MdColumn(String name, int type, String typeName, boolean nullable,
		    String defaultVal, boolean autoIncrement) 
    {
        colName = name;
        colType = type;
        colTypeName = typeName;
	isColNullable = nullable;
	colDefault = defaultVal;
	isColAutoIncrement = autoIncrement;
    }

    public String getColName() { return colName; }
    public int getColType() { return colType; }
    public String getColTypeName() { return colTypeName; }
    public boolean isColNullable() { return isColNullable; }
    public String getColDefault() { return colDefault; }
    public boolean isColAutoIncrement() { return isColAutoIncrement; }
    public MdColumn getCopy() {
	 return new MdColumn(colName, colType, colTypeName, isColNullable,
			 colDefault, isColAutoIncrement);
    }

    public boolean equals(MdColumn col) {
        return colName.equalsIgnoreCase(col.getColName()) ? true : false;
    }
        
} // class

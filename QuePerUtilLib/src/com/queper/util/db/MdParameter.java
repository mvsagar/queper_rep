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
 * Class used to store metadata of a parameter of a procedure/function..
 */
public class MdParameter {
    String paramName;
    int paramInOutType;
    int paramDataType;
    String paramDataTypeName;
    boolean isParamNullable;
    String paramDefault;
    String paramVal;
    int position;

    MdParameter(String name, int inOutType, 
		    int dataType, String typeName, boolean nullable,
		    String defaultVal, int pos) 
    {
        paramName = name;
        paramInOutType = inOutType;
        paramDataType = dataType;
        paramDataTypeName = typeName;
		isParamNullable = nullable;
		paramDefault = defaultVal;
		position = pos;
		paramVal = null;
    }

    public String getParamName() { return paramName; }
    public int getParamInOutType() { return paramInOutType; }
    public int getParamDataType() { return paramDataType; }
    public String getParamDataTypeName() { return paramDataTypeName; }
    public boolean isParamNullable() { return isParamNullable; }
    public String getParamDefault() { return paramDefault; }
    public int getPosition() { return position; }

    public String getParamVal() {
    	return paramVal;
    }
    public void setParamVal(String val) {
    	paramVal = val;
    }
} // class

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

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.*;

public class FileOps 
{

    /*
     * Given an input file name, return its contents
     * as byte array.
     */
    public static byte[] getByteArray(String inFile) 
    {
        byte[] buf = new byte[1024];
        byte[] byteArray = null;
        InputStream ins = null;
        try {
            ins = new FileInputStream (inFile);
        } catch (java.io.FileNotFoundException e) {
        	return null;    
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        try {
            for (int readNum; (readNum = ins.read(buf)) != -1;) {
                bos.write(buf, 0, readNum);
            }
            ins.close();
        } catch (IOException ex) {
        	return null;
        }
        byteArray = bos.toByteArray();  
        return byteArray;
    } // getByteArray.

    /*
     * Sets an image parameter in a prepared stmt to to given file.
     */
    public static void setImageParamToFile(Connection conn, PreparedStatement pStmt, int col, String filePath) throws Exception
    {
    	InputStream strm = null;

    	if (filePath == null) {
    		pStmt.setNull(col, Types.BLOB);
    	} else {
    		if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase("SQLite") == true) {	 
    			pStmt.setBytes(col, FileOps.getByteArray(filePath));
    		} else {
    			strm = new FileInputStream (filePath);
    			pStmt.setBinaryStream(col, strm);
    		}
        }
    } // setImageParamToFile().


    /*
     * Writes image of a column in result set to given file.
     *
     * Returns false if column is null and true otherwise.
     * If not null, writes contents of the blob column in the given file.
     */
    public static boolean writeImageToFile(Connection conn, ResultSet rs, int col, String filePath) throws Exception
    {
    	InputStream strm = null;

        if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase("SQLite") == true) {
		    byte[] imageBytes = rs.getBytes(col);
		    if (rs.wasNull()) {
		    	strm = null;
		    } else {
		    	strm = new ByteArrayInputStream(imageBytes);
	        }
        } else {
             strm = rs.getBinaryStream(col); 
             if (rs.wasNull()) {
            	 strm = null;
             }
        }
        if (strm == null) {
        	return false;
        } else {
            // Writing to image file requires complete path.
                         
            int avlBytes = strm.available();
                         
            FileOutputStream fos = new FileOutputStream (filePath);
            BufferedOutputStream bos = new BufferedOutputStream (fos);
                         
            byte[] byteArray = new byte [512]; 
            int bytesRead = strm.read(byteArray);
            while (bytesRead > 0) {
                  bos.write(byteArray, 0, bytesRead);
	              bytesRead = strm.read(byteArray);
            }
            bos.flush();
            bos.close();
            fos.flush();
            fos.close();

            return true;
        }
    } // writeImageToFile().

    // 2016-06-14: Returns media type - image, video or audio - given file path.
    public static String getMediaType(String filePath) 
    {
    	if (filePath == null) {
    		return "";
    	} else if (filePath.trim().equals("")) {
    		return "";
    	} else {
    	    Path source = Paths.get(filePath);
    	    try {
				String sourceType = Files.probeContentType(source);
				// Source type will be something line "image/png", "video/mp4", ....
				// We need only the first part. Hence split and return 0th element.
				if (sourceType == null) {
					return "";
				} else {
					return sourceType.split("/")[0];
				}
			} catch (IOException e) {
				return "";
			}
    	}
    }
} // class

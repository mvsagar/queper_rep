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

import java.util.TimeZone;
import java.text.SimpleDateFormat;


public class DateTime
{
    /**
     * Gets current local date time or timestamp.
     */
    public static String getLocalDateTime() 
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date localDateTime = new java.util.Date();
	return sdf.format(localDateTime);
    }


    /**
     * Given utc date time in format "yyyy-MM-dd HH:mm:ss", 
     * the method returns local date time by adding offset 
     * to the utc date time.
     *
     * This is mainly to be used in the context of SQLite, as
     * its rs.getString(1) for timestamp column does not return
     * timestamp in local timezone.
     */
    public static String getLocalDateTime(String utcDateTimeStr) 
    {
    	// Get offset from UTC from the default timezone.
        TimeZone timeZone = TimeZone.getDefault();
        int offset = timeZone.getOffset(System.currentTimeMillis());
        java.util.Date utcDate;

        // Convert given timestamp to Java Date object.
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            utcDate = sdf.parse(utcDateTimeStr);
        } catch (java.text.ParseException p) {
        	return "DateTime.getLocalDateTime: Invalid date time format";
        }

        // Add offset to utc date time.
        long tm = utcDate.getTime() + offset; // New time with offset.
        java.util.Date localDate = new java.util.Date(tm);
	
        return sdf.format(localDate);
    }

    /*
    public static void main(String[] args)
    {
         System.out.println("Current timestamp=" + getLocalDateTime()); 
         System.out.println("Timestamp with additional timezone=" + getLocalDateTime(getLocalDateTime())); 
    }
    */
} // class

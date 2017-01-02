/*
 * This session listener is required to close database connection
 * when session timesout as per time specified in apps web.xml.
 * Othewise, database connections lingering inspite of closing of 
 * sessions cause locking issues.
 */
package com.queper.util.tomcat; 

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.sql.Connection;
import java.sql.SQLException;
 
public class TomcatSessionListener implements HttpSessionListener {
    private int sessionCount = 0;
 
    public void sessionCreated(HttpSessionEvent event) {
        synchronized (this) {
            sessionCount++;
        }
    }
 
    public void sessionDestroyed(HttpSessionEvent event) {
        synchronized (this) {
            sessionCount--;
        }

	/*
	 * Make sure connection object name used in jsps of apps
	 * as used below.
	 */
	Connection conn = (Connection)event.getSession().getAttribute("connobj");
	if (conn != null) {
	    try {
	       conn.close();
	    } catch (SQLException se) {
	    }
        }	
    }
}


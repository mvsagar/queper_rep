package com.queper.util.common;

public class OsEnv {
	private static String osName = null;
	private static String homeDir = null;
	
	public static String getOsName()
	{
		if(osName == null) { 
			osName = System.getProperty("os.name"); 
		}
	    return osName;
	}
	 
	public static boolean isWindows()
	{
	      return getOsName().startsWith("Windows");
	}
	
	public static String getHomeDir()
	{
		 if (homeDir == null) {
			 homeDir = System.getenv("HOME");
		 }
		 return homeDir;
	}	
}

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

public class RandomInt {
  private static final int BUFFER_SIZE = 101;
  private static double[] buffer = new double[BUFFER_SIZE];
  private int low;
  private int high;

  static {
    int i;
    for (i = 0; i < BUFFER_SIZE; ++i) {
      buffer[i] = java.lang.Math.random();
    }
  }


  public RandomInt(int l, int h) {
    low = l; high = h;
  }
  
  public int getRandomInt() {
    int r = low + (int)((high - low + 1) * nextRandom());
    return r;
  }

  // Get rNums number of unique random numbers in output array rArr.
  public void getRandomArr(int rNums, int [] rArr) {
    int i = 0;
    int j = 0;
    int num = 0;
    boolean duplicate = false;

    // initialize the arr for random numbers with -1.
    for (i = 0; i < rNums; ++i)
    {
       rArr[i] = -1;
    } 
    
    i = 0;
    while (i < rNums)
    {
       rArr[i] = getRandomInt();
       // Check if it is a duplicate.
       duplicate = false;
       for (j = 0; j <= (i-1); ++j)
       {
	   if (rArr[i] == rArr[j]) // duplicate.
	   {
	      duplicate = true;
	      rArr[i] = -1;
	      break;
	   }
       }
       if (duplicate == false)
          ++i;
    } 
  }

  private static double nextRandom() {
    int pos = (int)(java.lang.Math.random() * BUFFER_SIZE);
    if (pos == BUFFER_SIZE)
      pos = BUFFER_SIZE - 1;
    double r = buffer[pos];
    buffer[pos] = java.lang.Math.random();
    return r;
  }

  public static void main(String[] args) {
    int rNum = 0;
    RandomInt r = new RandomInt(1, 10);
    //rNum = r.getRandomInt();
    rNum = 10;
    System.out.println("randint = " + rNum);
    
    System.out.println(r + " Random integers: ");
    int[] rArr = new int[rNum];
    r.getRandomArr(rNum, rArr);
    for (int i = 0; i < rNum; ++i)
      System.out.println("i=" + i + ") " + rArr[i]);
	  
  }
	  
} // class

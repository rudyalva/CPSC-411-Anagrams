//
//  main.m
//  Assignment2
//
//  Created by rudy alvarado on 1/27/16.
//  Copyright © 2016 rudy alvarado. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <objc/Object.h>
#import "Anagram.h"


int main(int argc, const char * argv[])
{
  
    @autoreleasepool {
        
        // take in path to file from user
        char userInput[100];
        
        NSLog(@"Enter path to file:");
        scanf("%s", userInput);
        
        NSFileManager *fileManager= [[NSFileManager alloc] init];
        
        NSString *inputPath = [NSString stringWithUTF8String:userInput];
                               
        NSURL *path = [NSURL fileURLWithPath:inputPath];
        
        // File check
        if (![fileManager fileExistsAtPath:inputPath]) {
            
            NSLog(@"File does not exist");
            exit(1);
        }
        //@"/Users/Rudy/Desktop/411/Assignment2/Assignment2/words"
        
        NSDate *startTime = [NSDate date];
        
        NSMutableString *fileContent = [[NSMutableString alloc] initWithContentsOfURL:path encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *myWords = [fileContent componentsSeparatedByString:@"\n"];
        
        NSMutableArray *anagramWords = [[NSMutableArray alloc] init];
       
        // Create Anagram objs from NSString array
        for (NSString *word in myWords)
        {
            
            Anagram *anaObj = [[Anagram alloc] initWith:[word lowercaseString]];
            [anagramWords addObject:anaObj];
        
        }
        
        // Sort Anagram array by code word
        NSArray *sortedArray = [anagramWords sortedArrayUsingSelector:@selector(compare:)];
        
        int numbOfAnagrams = 0;
        int initialIndex = 0;
        int maxEnd = 0;
        int maxStart = 0;
        int max = 0;
        
        // Couting max and number of anagrams
        for (int currentIndex = 1; currentIndex < [sortedArray count]; currentIndex++)
        {

            // if not an Anagram of current word, calculates max and number of anagrams
            if([sortedArray[currentIndex] isAnagramOf:sortedArray[currentIndex-1]] == NO)
            {
                
                int tempMax = currentIndex - initialIndex;
                
                if (tempMax > 1)
                {
                    numbOfAnagrams += tempMax;

                }
                
                if(max < tempMax)
                {
                    
                    max = tempMax ;
                    maxStart = initialIndex;
                    maxEnd = currentIndex;
                }
                
                initialIndex = currentIndex;
                
            }
        }
        
        NSTimeInterval timeInterval = fabs([startTime timeIntervalSinceNow]);
        
        NSLog(@"Total number of anagrams: %i", numbOfAnagrams);
        NSLog(@"Largest set of anagrams: %i", max);
        NSLog(@"The words that make up the largest set of anagrams with the code word '%@':",[sortedArray[maxStart] codeWord]);
        
        // Display largest set of anagrams using indicies gained from above for loop
        for (int i = maxStart; i < maxEnd; i++)
        {
            NSLog(@" %@ ", [sortedArray[i] word]);
        }
        
        NSLog(@"The program took %f seconds to execute",timeInterval);

    }
    return 0;
}


//
//  Anagram.m
//  anagramAsgt
//
//  Created by rudy alvarado on 2/2/16.
//  Copyright © 2016 rudy alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Anagram.h"

// adding a sort extension to NSString
@interface NSString (SortExtension)
- (NSString *)sorted;
@end

@implementation NSString (SortExtension)

- (NSString *)sorted
{
    // init
    NSUInteger length = [self length];
    unichar *chars = (unichar *)malloc(sizeof(unichar) * length);
    
    // extract
    [self getCharacters:chars range:NSMakeRange(0, length)];
    
    // sort
    qsort_b(chars, length, sizeof(unichar), ^(const void *l, const void *r) {
        unichar left = *(unichar *)l;
        unichar right = *(unichar *)r;
        return (int)(left - right);
    });
    
    // recreate
    NSString *sorted = [NSString stringWithCharacters:chars length:length];
    
    // clean-up
    free(chars);
    
    return sorted;
}
@end

@implementation Anagram

@synthesize word;
@synthesize codeWord;

// initWith string initalizes object with string and codeWord
-(Anagram*)initWith:(NSString *) aWord
{
    self = [super init];
    if(self)
    {
        word = aWord ;
        // sorted method called to create codeWord
        codeWord = [aWord sorted];
    }
    return self;
}
// isAnagramOf will take in anagram object and return bool type
-(BOOL) isAnagramOf:(Anagram *)anAnagram
{
    if ([self codeWord] == [anAnagram codeWord] && [self codeWord].length == [anAnagram codeWord].length)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
// compare allows Anagram object to become comparable
- (NSComparisonResult)compare:(Anagram *)anAnagram {
    return [self.codeWord compare:anAnagram.codeWord];
}

@end

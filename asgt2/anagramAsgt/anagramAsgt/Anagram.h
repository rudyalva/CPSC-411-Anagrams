//
//  Anagram.h
//  anagramAsgt
//
//  Created by rudy alvarado on 2/2/16.
//  Copyright © 2016 rudy alvarado. All rights reserved.
//

@interface Anagram : NSObject

@property (strong, nonatomic) NSString *word; //strong = own property
@property (strong, nonatomic) NSString *codeWord;

- (Anagram*) initWith: (NSString*) word;
- (BOOL) isAnagramOf: (Anagram*) anAnagram;
- (NSComparisonResult) compare: (Anagram*) anAnagram;

@end
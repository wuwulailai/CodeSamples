//
//  NSData+Json.m
//  CodeSamples
//
//  Created by admin on 2023/12/14.
//

#import "NSData+Json.h"

@implementation NSData (Json)
- (NSDictionary *)toDict {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self
                                                        options:0
                                                          error:&error];
    if (error || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return dic;
}

@end

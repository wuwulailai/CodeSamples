//
//  NSBundle+Asset.m
//  CodeSamples
//
//  Created by admin on 2023/12/13.
//

#import "NSBundle+Asset.h"
#import <objc/runtime.h>

#pragma mark - 动态属性关联
static char kBundleKey;

@implementation NSBundle (Asset)

+ (NSDictionary *)bundleList {
    return objc_getAssociatedObject(self, &kBundleKey);
}

+ (NSBundle *)bundleWithAssetPath:(NSString *)bundlePath {
    NSBundle *bundle;
    
    NSDictionary *dict = [self bundleList];
    if(dict) {
        bundle = [dict valueForKey:bundlePath];
    }
    
    if(!bundle) {
        bundle = [NSBundle bundleWithPath:bundlePath];
        
        NSMutableDictionary *mutDict = [dict mutableCopy];
        if(!mutDict) {
            mutDict = [[NSMutableDictionary alloc] init];
        }
        [mutDict setValue:bundle forKey:bundlePath];
        
        objc_setAssociatedObject(self, &kBundleKey, [mutDict copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return bundle;
}

@end

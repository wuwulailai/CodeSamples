//
//  NSBundle+Language.m
//  LanguageSwitch
//
//  Created by admin on 2023/4/4.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>

static const char _bundle = 0;

@interface BundleEx : NSBundle
 
@end
 
@implementation BundleEx
 
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}
 
@end


@implementation NSBundle (Language)
+ (void)setLanguage:(NSString *)language inBundle:(NSBundle *)bundle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
 
    NSString *path;
    if(language) {
        if(bundle) {
            path = [bundle pathForResource:language ofType:@"lproj"];
        } else {
            path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
        }
    }
    
    if(path) {
        objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:path] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end

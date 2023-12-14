//
//  NSBundle+Asset.h
//  CodeSamples
//
//  Created by admin on 2023/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Asset)
+ (NSBundle *)bundleWithAssetPath:(NSString *)bundlePath;
+ (NSDictionary *)bundleList;
@end

NS_ASSUME_NONNULL_END

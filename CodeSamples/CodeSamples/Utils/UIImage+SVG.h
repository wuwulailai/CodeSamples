//
//  UIImage+SVG.h
//  CodeSamples
//
//  Created by admin on 2023/12/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SVG)
+ (UIImage *)svgImageName:(NSString *)name size:(CGSize)size;
+ (UIImage *)svgImageName:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor;
@end

NS_ASSUME_NONNULL_END

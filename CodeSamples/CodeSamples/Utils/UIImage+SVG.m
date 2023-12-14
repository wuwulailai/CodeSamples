//
//  UIImage+SVG.m
//  CodeSamples
//
//  Created by admin on 2023/12/13.
//

#import "UIImage+SVG.h"
#import <SVGKit/SVGKit.h>
#import "NSBundle+Asset.h"

@interface SVGKImage(fillColor)

@end

@implementation SVGKImage (fillColor)

- (void)fillColorForSubLayer:(CALayer *)layer color:(UIColor *)color opacity:(CGFloat)opacity {
    if ([layer isKindOfClass:[CAShapeLayer class]]) {
        [(CAShapeLayer *)layer setFillColor:color.CGColor];
        [(CAShapeLayer *)layer setOpacity:opacity];
    }
    
    if (layer.sublayers.count) {
        for (CALayer *sublayer in layer.sublayers) {
            [self fillColorForSubLayer:sublayer color:color opacity:opacity];
        }
    }
}

- (void)fillColorForOutter:(CALayer *)layer color:(UIColor *)color opacity:(CGFloat)opacity {
    if (layer.sublayers.count && [layer.sublayers.firstObject isKindOfClass:[CAShapeLayer class]]) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *)layer.sublayers.firstObject;
        shapeLayer.fillColor = color.CGColor;
        shapeLayer.opacity = opacity;
    }
}

- (void)fillColor:(UIColor *)color opacity:(CGFloat)opacity {
    if (self.CALayerTree) {
        [self fillColorForSubLayer:self.CALayerTree color:color opacity:opacity];
    }
}

- (void)fillOutterColor:(UIColor *)color opacity:(CGFloat)opacity {
    if (self.CALayerTree) {
        [self fillColorForOutter:self.CALayerTree color:color opacity:opacity];
    }
}

@end

@implementation UIImage (SVGManager)

+ (UIImage *)svgImageName:(NSString *)name size:(CGSize)size {
    SVGKImage *svgImage = [self imageInBundleWithName:name];
    if(!svgImage) {
        svgImage = [SVGKImage imageNamed:name];
    }
    
    if(!svgImage) {
        return nil;
    }
    
    svgImage.size = size;
    
    return svgImage.UIImage;
}

+ (UIImage *)svgImageName:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor {
    SVGKImage *svgImage = [self imageInBundleWithName:(NSString *)name];
    if(!svgImage) {
        svgImage = [SVGKImage imageNamed:name];
    }

    if(!svgImage) {
        return nil;
    }
    
    svgImage.size = size;
    [svgImage fillColor:tintColor opacity:1];
    return svgImage.UIImage;
}

+ (SVGKImage *)imageInBundleWithName:(NSString *)name {
    NSArray *bundles = [self bundleList];
    SVGKImage *svgImage;
    
    for(NSBundle *bundle in bundles) {
        svgImage = [SVGKImage imageNamed:name inBundle:bundle];
        if(svgImage) {
            break;
        }
    }
    
    return svgImage;
}


+ (NSArray<NSBundle *> *)bundleList {
    return [[NSBundle bundleList] allValues];
}

@end

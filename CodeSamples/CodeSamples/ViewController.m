//
//  ViewController.m
//  CodeSamples
//
//  Created by admin on 2023/12/12.
//

#import "ViewController.h"
#import "UIImage+SVG.h"
#import "NSBundle+Asset.h"
#import "NSData+Json.h"
#import "NSBundle+Language.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray<NSBundle *> *allBundles = [NSBundle allBundles];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"asset" ofType:@"bundle"];
    NSLog(@"bundle path:%@", path);
    NSBundle *bundle = [NSBundle bundleWithAssetPath:path];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"o_banner_detail" ofType:@"svg"]];
    NSLog(@"image:%@", image);
    
    UIImage *image_png = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"launch_icon" ofType:@"png"]];
    NSLog(@"image:%@", image_png);
    
    UIImage *welcome_png = [UIImage imageNamed:@"welcome" inBundle:bundle withConfiguration:nil];
    NSLog(@"welcome_png:%@", welcome_png);

    UIImage *image_with_name = [UIImage svgImageName:@"o_banner_detail" size:CGSizeMake(100, 50) tintColor:[UIColor redColor]];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image_with_name;
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(10, 100, 100, 50);
    
//    [UIImage imageNamed:@"o_banner_detail.svg" inBundle:bundle withConfiguration:nil];
    NSLog(@"image with name:%@", image_with_name);
    
    for(NSBundle *bundle in allBundles) {
        NSLog(@"bundle:%@", bundle);
    }
    
    [self parseColorConfig];
    
    [self parsePropertyConfig];
    
    [self setLanguage];
    
    NSString *string = NSLocalizedString(@"feedback", nil);
    NSLog(@"string:%@", string);
    
}

- (void)parseColorConfig {
    NSDictionary *colorsDict;
    NSString *colorsFile = [self colorConfigFilePath];
    if (colorsFile.length) {
        NSData *colorsData = [NSData dataWithContentsOfFile:colorsFile];
        if (colorsData.length) {
            colorsDict = [colorsData toDict];
        }
    }
    
    NSLog(@"color dict:%@", colorsDict);
}

- (void)parsePropertyConfig {
    NSDictionary *colorsDict;
    NSString *propertyFile = [self propertyFilePath];
    if (propertyFile.length) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:propertyFile];
        for(NSString *key in dict) {
            NSLog(@"key:%@, value:%@", key, [dict valueForKey:key]);
        }
        
        NSLog(@"property dict:%@", dict);
    }
}

- (void)setLanguage {
    [NSBundle setLanguage:@"en" inBundle:[self resourceBundle]];
}

// 颜色配置路径
- (NSString *)colorConfigFilePath {
    NSBundle *bundle = [self resourceBundle];
    return [bundle pathForResource:@"colors" ofType:@"json"];
}

- (NSString *)propertyFilePath {
    NSBundle *bundle = [self resourceBundle];
    return [bundle pathForResource:@"vod" ofType:@"plist"];
}

- (NSBundle *)resourceBundle {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"asset" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithAssetPath:path];
    
    return bundle;
}

@end

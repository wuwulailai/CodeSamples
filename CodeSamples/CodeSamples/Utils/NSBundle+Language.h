//
//  NSBundle+Language.h
//  LanguageSwitch
//
//  Created by admin on 2023/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Language)
// 设置语言
+ (void)setLanguage:(NSString *)language inBundle:(NSBundle *)bundle;
@end

NS_ASSUME_NONNULL_END

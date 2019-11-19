//
//  UIWindow+Extension.m
//  CubeLive
//
//  Created by zowell on 2019/11/5.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import "UIWindow+Extension.h"

@implementation UIWindow (Extension)

///// 显示 Window
//- (void)showWindow {
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window switchRootViewController];
//    [self.window makeKeyAndVisible];
//}

- (void)switchRootViewController {
    NSString *const LaunchVersion = @"LaunchVersion";
    NSString *version = NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] valueForKey:LaunchVersion];
    if (![lastVersion isEqualToString:version]) {
        // 启动页
        self.rootViewController = NSClassFromString(@"LaunchViewController").new;
        [[NSUserDefaults standardUserDefaults] setValue:version forKey:LaunchVersion];
    } else {
        // 主页面
        self.rootViewController = NSClassFromString(@"TabBarViewController").new;
    }
}

/*

//RGB格式
#define kRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//RGBA格式
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//16进制形式
#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

//弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type
//强引用
#define kStrongSelf(type)  __strong typeof(type) type = weak##type


//字符串是否为空
#define kISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
//字典是否为空
#define kISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]

*/

@end

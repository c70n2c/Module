//
//  TabBarViewController.m
//  CubeLive
//
//  Created by Chancc on 2019/11/4.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import "TabBarViewController.h"

NSString *const className = @"className";
NSString *const viewContrrolTitle = @"viewContrrolTitle";
NSString *const defaultImage = @"defaultImage";
NSString *const selectImage = @"selectImage";
NSString *const isLoadNavigation = @"isLoadNavigation";


@interface TabBarViewController ()

@property(nonatomic, strong) NSArray *array;

@end

@implementation TabBarViewController

-(NSArray *)array {
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBarViewController];
}

- (void)setupTabBarViewController {
    
    self.array = @[
    @{
        className: @"DeviceViewController",
        viewContrrolTitle: @"设备",
        defaultImage: @"",
        selectImage: @"",
        isLoadNavigation: @YES
    },
    @{
        className: @"IntelligentViewController",
        viewContrrolTitle: @"智能",
        defaultImage: @"",
        selectImage: @"",
        isLoadNavigation: @YES
    },
    @{
        className: @"MyViewController",
        viewContrrolTitle: @"我的",
        defaultImage: @"",
        selectImage: @"",
        isLoadNavigation: @NO
    }];
    
    [self.array enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:NSClassFromString(obj[className]).new title:obj[viewContrrolTitle] defaultImageName:obj[defaultImage] selectImageName:obj[selectImage] isLoadNavigation:[obj[isLoadNavigation] boolValue]];
    }];
}

- (void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title defaultImageName:(NSString *)defaultImage selectImageName:(NSString *)selectImage isLoadNavigation:(BOOL)isLoad {
    childViewController.title = title;
    self.tabBar.unselectedItemTintColor = kColorWithHex(0x000000);
    self.tabBar.tintColor = kColorWithHex(0xFFA07A);
    childViewController.tabBarItem.image = [[UIImage imageNamed:defaultImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navigation = [[NSClassFromString(@"NavigationViewController") alloc] initWithRootViewController:childViewController];
    UIViewController *childVC = isLoad ? navigation : childViewController;
    [self addChildViewController:childVC];
}

@end

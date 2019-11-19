//
//  DropdownMenuView.h
//  CubeLive
//
//  Created by zowell on 2019/11/5.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownMenuView : UIView

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) void (^didClick)(NSInteger);

- (void)showFrome:(UIView *)view;
- (void)dismiss;

/*
 - (void)addDevice:(UIButton *)sender {
     DropdownMenuView *dropdownMenuView = [[DropdownMenuView alloc] init];
     dropdownMenuView.dataSource = @[NSLocalizedString(@"SweepCode", nil), NSLocalizedString(@"Manual", nil), NSLocalizedString(@"LAN", nil)];
     [dropdownMenuView showFrome:sender];
     kWeakSelf(self);
     dropdownMenuView.didClick = ^(NSInteger index) {
         kStrongSelf(self);
         switch (index) {
             case sweepCodeType: {
                 // 扫码
                 SweepCodeViewController *sweepCodeViewController = [[SweepCodeViewController alloc] init];
                 [self.navigationController pushViewController:sweepCodeViewController animated:YES];
                 break;
             }
             case manualType: {
                 // 手动
                 AddDeviceViewController *addDeviceViewController = [[AddDeviceViewController alloc] init];
                 [self.navigationController pushViewController:addDeviceViewController animated:YES];
                 break;
             }
             case lanType: {
                 // 局域网
                 LANAFindDeviceViewController *lanAddDeviceViewController = [[LANAFindDeviceViewController alloc] init];
                 [self.navigationController pushViewController:lanAddDeviceViewController animated:YES];
                 break;
             }
             default:
                 break;
         }
     };
 }

*/

@end

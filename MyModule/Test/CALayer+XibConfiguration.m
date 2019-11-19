//
//  CALayer+XibConfiguration.m
//  CubeLive
//
//  Created by zowell on 2019/11/5.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

- (void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setShadowUIColor:(UIColor*)color {
    self.shadowColor = color.CGColor;
}

- (UIColor *)shadowUIColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end

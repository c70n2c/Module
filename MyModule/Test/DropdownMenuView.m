//
//  DropdownMenuView.m
//  CubeLive
//
//  Created by zowell on 2019/11/5.
//  Copyright © 2019 zviewtech. All rights reserved.
//

#import "DropdownMenuView.h"

CGFloat const cellHeight = 44.f;

static NSString *dropdownMenuIdentifier = @"dropdownMenuIdentifier";

@interface DropdownMenuView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DropdownMenuView

- (NSArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
//    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    tap.delegate = self;
//    [self addGestureRecognizer:tap];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = kRGBA(0, 0, 0, 0.5);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:dropdownMenuIdentifier];
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([touch.view isDescendantOfView:self.tableView]) {
//        return NO;
//    }
//    [self dismiss];
//    return YES;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dropdownMenuIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didClick != nil) {
        self.didClick(indexPath.row);
    }
    [self dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)showFrome:(UIView *)view {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self];
    CGRect rect = [view convertRect:view.frame toView:window];
    self.tableView.frame = CGRectMake(CGRectGetMaxX(rect) - 120.f, CGRectGetMaxY(rect), 120.f, self.dataSource.count * cellHeight);
}

- (void)dismiss {
    [self removeFromSuperview];
}


@end

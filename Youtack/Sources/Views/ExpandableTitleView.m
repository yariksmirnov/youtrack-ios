//
//  ExpandableTitleView.m
//
//  Created by Yarik Smirnov on 17/08/15.
//

#import "ExpandableTitleView.h"
#import <PureLayout/PureLayout.h>
#import "Youtack-Swift.h"

@interface ExpandableTitleView ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIButton *titleButton;
@end

@implementation ExpandableTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 999.0, 999.0)];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.text = @"Everywhere";
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:17];
        self.label.shadowOffset = CGSizeMake(0, 1);
        self.label.shadowColor = [UIColor colorWithWhite:0 alpha:.06];
        [self addSubview:self.label];
        [self.label autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:32.0];
        
        UIImage *arrowImage = [UIImage imageNamed:@"expand_arrow"];
        arrowImage = [arrowImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];
        self.arrowImageView.tintColor = [UIColor whiteColor];
        self.arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.arrowImageView];
        [self.arrowImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero
                                                      excludingEdge:ALEdgeLeft];
        [self.arrowImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.titleButton];
        [self.titleButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
    return self;
}

- (void)animateToArrowOrientation:(UIImageOrientation)orientation
{
    [UIView animateWithDuration:.2 animations:^{
        if (orientation == UIImageOrientationUp) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }
        if (orientation == UIImageOrientationDown) {
            self.arrowImageView.transform = CGAffineTransformMakeScale(1, -1);
        }
    }];
}

@end

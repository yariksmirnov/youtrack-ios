//
//  ExpandableTitleView.h
//
//
//  Created by Yarik Smirnov on 17/08/15.
//

#import <UIKit/UIKit.h>

@interface ExpandableTitleView : UIView
@property (nonatomic, readonly) UIButton *titleButton;
@property (nonatomic, readonly) UILabel *label;

- (void)animateToArrowOrientation:(UIImageOrientation)orientation;

@end

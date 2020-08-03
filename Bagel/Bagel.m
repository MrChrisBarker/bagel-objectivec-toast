//
//  Bagel.m
//  Bagel
//
//  Created by Chris Barker on 25/07/2020.
//  Copyright © 2020 Cocoa-Cabana Code Ltd. All rights reserved.
//

#import "Bagel.h"
#import "UIView+AddConstraints.h"

@implementation Bagel

+ (Bagel *) shared {
    static dispatch_once_t once;
    static Bagel *shared;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundColor = [UIColor blackColor];
        _textColor = [UIColor whiteColor];
        _lineCount = 0;
        _font = [UIFont systemFontOfSize:17.0];
        _textAlignment = NSTextAlignmentCenter;
        _bottomConstraint = -46.0;
        _speed = 0.4;
        _wait = 1.8;
    }
    return self;
}

-(void)pop:(UIView * _Nullable) view withMessage:(NSString * _Nonnull) message {
    
    UIView *viewToAdd = view;
    if (viewToAdd == nil) {
        viewToAdd = [self getKeyView];
    }
    
    // Setup UIView 🥯
    UIView *bagelView = [[UIView alloc]init];
    [bagelView setBackgroundColor:[_backgroundColor colorWithAlphaComponent:0.6]];
    [bagelView setAlpha:0.0];
    [bagelView.layer setCornerRadius:15];
    [bagelView setClipsToBounds:YES];
    
    // Setup UILabel 🏷
    UILabel *textLabel = [[UILabel alloc]init];
    [textLabel setTextColor:_textColor];
    [textLabel setTextAlignment:_textAlignment];
    [textLabel setText:message];
    [textLabel setNumberOfLines:_lineCount];
    [textLabel setFont:_font];
    [textLabel setClipsToBounds:YES];
    
    [bagelView addSubview:textLabel];
    [viewToAdd addSubview:bagelView];

    // Set Constaints 🏗
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bagelView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
    [bagelView addConstraintsTo:textLabel withLeading:16 withTrailing:-16 withTop:16 withBottom:-16];
    [viewToAdd addConstraintsTo:bagelView withLeading:66 withTrailing:-66 withTop:0.0 withBottom:_bottomConstraint];
    
    [UIView animateWithDuration:_speed delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [bagelView setAlpha:1.0];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.speed delay:self.wait options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [bagelView setAlpha:0.0];
        } completion:^(BOOL finished) {
            [bagelView removeFromSuperview];
        }];
    }];

}

-(UIView *)getKeyView{
    UIWindow *topWindow = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *firstWindow, UIWindow *secondWindow) {
        return firstWindow.windowLevel - secondWindow.windowLevel;
    }] lastObject];
    return [[topWindow subviews] lastObject];
}

@end
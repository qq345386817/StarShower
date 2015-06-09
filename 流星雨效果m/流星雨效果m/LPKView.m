//
//  LPKView.m
//  流星雨效果m
//
//  Created by 罗培克 on 5/26/15.
//  Copyright (c) 2015 lpk. All rights reserved.
//

#import "LPKView.h"

@implementation LPKView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(instancetype)init {
//    if (self = [super init]) {
//        self.userInteractionEnabled = YES;
//    }
//    return self;
//}

-(void)setTouchPoint:(CGPoint)touchPoint {
    _touchPoint = touchPoint;
    if ([self pointInside:touchPoint withEvent:nil]) {
        [self removeFromSuperview];
    }
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@--%s", self.class, __func__);
//    [self removeFromSuperview];
//}

@end

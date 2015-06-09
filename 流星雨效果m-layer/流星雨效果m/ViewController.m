//
//  ViewController.m
//  流星雨效果m
//
//  Created by 罗培克 on 5/15/15.
//  Copyright (c) 2015 lpk. All rights reserved.
//

#import "ViewController.h"

#define kTotalWidth [UIScreen mainScreen].bounds.size.width
#define kTotalHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
/**
 *  图片数组
 */
@property(nonatomic, strong)NSArray *imgs;
/**
 *  layer数组
 */
@property (strong, nonatomic) NSMutableArray *layers;
@end

@implementation ViewController
/**
 *  imgs懒加载
 *
 *  @return 返回固定的图片数组
 */
-(NSArray *)imgs{
    if (!_imgs) {
        _imgs = @[
                  [UIImage imageNamed:@"spark_yellow"],
                  [UIImage imageNamed:@"spark_red"],
                  [UIImage imageNamed:@"spark_blue"],
                  [UIImage imageNamed:@"spark_cyan"],
                  [UIImage imageNamed:@"spark_green"],
                  [UIImage imageNamed:@"spark_magenta"]
                  ];
    }
    return _imgs;
}

-(NSMutableArray *)layers {
    if (!_layers) {
        _layers = [NSMutableArray array];
    }
    return _layers;
}

/**
 *  随机点方法
 *
 *  @return 返回屏幕内的一个随机点
 */
-(CGPoint)pointWithRandom{
    CGFloat x = arc4random_uniform(kTotalWidth);
    CGFloat y = arc4random_uniform(kTotalHeight);
    return CGPointMake(x, y);
}

/**
 *  随机数方法
 *
 *  @return 返回值用于 UIView的宽度
 */
-(CGFloat)floatWithRandom {
    return arc4random_uniform(400);
}

/**
 *  随机图片方法
 *
 *  @return 返回图片数组里的一个随机图片
 */
-(UIImage *)imgWithRandom {
    NSInteger rand = arc4random_uniform((int)self.imgs.count);
    return self.imgs[rand];
}

/**
 *  方法，返回一个CALayer，自带动画效果
 */
-(void)layerWithWidth:(CGFloat)width center:(CGPoint)center image:(UIImage *)image {
    CALayer *imgV = [[CALayer alloc]init];
    imgV.contents = (__bridge id)(image.CGImage);
    
    // 初始位置，来自外面的随机点
//    imgV.position = center;
    // 初始位置，在屏幕中心
    imgV.position = CGPointMake(kTotalWidth * 0.5, kTotalHeight * 0.5);
    // 当这里设置的 Layer大小为0时，后面的缩放动画无效
    NSInteger origin = arc4random_uniform(5);
    imgV.bounds = CGRectMake(0, 0, origin, origin);
    imgV.opacity = 1.0;
    
    // 生成一个在屏幕之外的随机点
    CGFloat x = arc4random_uniform(kTotalWidth);
    CGFloat y = arc4random_uniform(kTotalHeight);
    
    NSInteger random = arc4random_uniform(8);
    switch (random) {
        case 0:
            x -= kTotalWidth;
            y -= kTotalHeight;
            break;
        case 1:
            //            x -= kTotalWidth;
            y -= kTotalHeight;
            break;
        case 2:
            x += kTotalWidth;
            y -= kTotalHeight;
            break;
        case 3:
            x -= kTotalWidth;
            //            y -= kTotalHeight;
            break;
        case 4:
            x += kTotalWidth;
            //            y -= kTotalHeight;
            break;
        case 5:
            x -= kTotalWidth;
            y += kTotalHeight;
            break;
        case 6:
            //            x -= kTotalWidth;
            y += kTotalHeight;
            break;
        case 7:
            x += kTotalWidth;
            y += kTotalHeight;
            break;
        default:
            break;
    }
    
    CAAnimationGroup *animGroup = [[CAAnimationGroup alloc]init];
    animGroup.duration = arc4random_uniform(20);
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anim1.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim2.toValue = @(width);
    
    animGroup.animations = @[anim2, anim1];
    //    NSLog(@"%@--%@--%@", animGroup, anim1, anim2);
    [imgV addAnimation:animGroup forKey:nil];
    [self.view.layer addSublayer:imgV];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
    NSLog(@"%@--%s", self.class, __func__);
    // 定义 NSTimer或者 CADisplayLink，自动运行
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(layerWithRandom) userInfo:nil repeats:YES];
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(layerWithRandom)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)layerWithRandom {
    for (int i = 0; i < arc4random_uniform(2); i++) {
        CGPoint center = [self pointWithRandom];
        CGFloat width = [self floatWithRandom];
        UIImage *img = [self imgWithRandom];
        [self layerWithWidth:width center:center image:img];
    }
}

@end

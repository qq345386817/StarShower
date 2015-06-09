//
//  ViewController.m
//  流星雨效果m
//
//  Created by 罗培克 on 5/15/15.
//  Copyright (c) 2015 lpk. All rights reserved.
//

#import "ViewController.h"
#import "LPKView.h"

#define kTotalWidth [UIScreen mainScreen].bounds.size.width
#define kTotalHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
/**
 *  图片数组
 */
@property(nonatomic, strong)NSArray *imgs;
/**
 *  <#Description#>
 */
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
                  [UIImage imageNamed:@"spark_magenta"],
                  [UIImage imageNamed:@"spark_yellow"],
                  [UIImage imageNamed:@"spark_red"],
                  [UIImage imageNamed:@"spark_cyan"],
                  [UIImage imageNamed:@"spark_green"],
                  [UIImage imageNamed:@"spark_magenta"]
                  ];
    }
    return _imgs;
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
 *  方法，返回一个UIImageView，自带动画效果
 */
-(LPKView *)imageViewWithWidth:(CGFloat)width center:(CGPoint)center image:(UIImage *)image {
    LPKView *imgV = [[LPKView alloc]init];
    
    // 初始位置，来自外面的随机点
//    imgV.center = center;
    // 初始位置，在屏幕中心
    imgV.center = CGPointMake(kTotalWidth * 0.5, kTotalHeight * 0.5);
    imgV.bounds = CGRectMake(0, 0, 0, 0);
//    imgV.alpha = 0.0;
    imgV.image = image;
    imgV.contentMode = UIViewContentModeScaleToFill;
    
    // 每个图片都相对中心点向外移动，计算移动的x/y比值
//    CGFloat a = center.y / center.x;
//    // x/y方向的增量
//    CGFloat goalX = arc4random_uniform(200);
//    CGFloat goalY = goalX * a;
//    if (center.x > kTotalWidth * 0.5) {
//        goalX = goalX + center.x;
//    } else {
//        goalX = center.x - goalX;
//    }
//    if (center.y > kTotalHeight * 0.5) {
//        goalY = goalY + center.y;
//    } else {
//        goalY = center.y - goalY;
//    }
//    CGPoint goalP = CGPointMake(goalX, goalY);
    
    // 单个图片的动画效果
//    [UIView animateWithDuration:arc4random_uniform(12.0) animations:^{
//        imgV.bounds = CGRectMake(0, 0, width, width);
//        imgV.center = center;
//        imgV.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:arc4random_uniform(12.0) animations:^{
//            imgV.alpha = 0.0;
//            imgV.bounds = CGRectMake(0, 0, width * 0.5, width * 0.5);
//            imgV.center = goalP;
//        } completion:^(BOOL finished) {
//            [imgV removeFromSuperview];
//        }];
//    }];
    [self animateWithimgView:imgV bounds:CGRectMake(0, 0, width, width)];
    
    return imgV;
}

/**
 *  单个图片动画效果：从中心点开始，方向任意，移动到屏幕之外
 */
-(void)animateWithimgView:(UIImageView *)imgV bounds:(CGRect)bounds{
    // 采用圆上取点的方法获取一个屏幕外的随机点
    // 此方法生成的随机点,在 X 轴方向没有数据分布,造成 X 轴方向几乎没有点
//    CGFloat r = sqrt(kTotalHeight * kTotalHeight + kTotalWidth * kTotalWidth) * 0.5;
//    CGFloat x = arc4random_uniform(r);
//    CGFloat y = sqrt(r * r - x * x);
//    x = arc4random_uniform(2) ? x : -x;
//    y = arc4random_uniform(2) ? y : -y;
//    x += kTotalWidth * 0.5;
//    y += kTotalHeight * 0.5;
    
    // 生成一个在屏幕之外的随机点
    // 此方法生成的随机点,分布均匀,效果好
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
    
//    if (y > kTotalHeight * 0.5) {
//        y += kTotalHeight * 0.5;
//    } else {
//        y -= kTotalHeight * 0.5;
//    }
    
    [UIView animateWithDuration:arc4random_uniform(20.0) animations:^{
        imgV.bounds = bounds;
        imgV.center = CGPointMake(x, y);
//        imgV.alpha = 1.0;
    } completion:^(BOOL finished) {
        [imgV removeFromSuperview];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(createViewWithAnimate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    // 单个  LPKView 可以实现 触摸后从父控件移除的效果,但是多个在一起的时候,会互相叠加,造成不能触摸\
    故改为LPKView 的setTouchPoint 方法
//    LPKView *v = [[LPKView alloc]init];
//    [self.view addSubview:v];
//    v.bounds = CGRectMake(0, 0, 100, 100);
//    v.center = self.view.center;
//    v.backgroundColor = [UIColor redColor];
}

-(void)createViewWithAnimate {
    CGPoint center = [self pointWithRandom];
    CGFloat width = [self floatWithRandom];
    UIImage *img = [self imgWithRandom];
    LPKView *imgV = [self imageViewWithWidth:width center:center image:img];
    [self.view addSubview:imgV];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (int i = 0; i < arc4random_uniform(100); i++) {
//        CGPoint center = [self pointWithRandom];
//        CGFloat width = [self floatWithRandom];
//        UIImage *img = [self imgWithRandom];
//        UIImageView *imgV = [self imageViewWithWidth:width center:center image:img];
//        [self.view addSubview:imgV];
//    }
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    for (UIView *sub in self.view.subviews) {
        if ([sub isKindOfClass:[LPKView class]]) {
            LPKView *view = (LPKView *)sub;
            view.touchPoint = point;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

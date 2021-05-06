//
//  SoundWavesLine.m
//  SoundWaves
//
//  Created by mfhj-dz-001-059 on 2021/4/29.
//

#import "SoundWavesLine.h"

@interface SoundWavesLine()<CAAnimationDelegate>

@property(strong, nonatomic) CAShapeLayer *shapeLayer;

/// 声波线颜色
@property(strong, nonatomic) UIColor *lineColor;

/// 启用动画
@property(assign, nonatomic) BOOL animateEnable;

@end

@implementation SoundWavesLine

- (instancetype)initWithLineColor:(UIColor *)lineColor {
    self = [super init];
    if (self) {
        self.lineColor = lineColor;
        [self initialization];
        [self addCustomControl];
    }
    return self;
}

- (void)layoutSubviews {
    self.shapeLayer.frame = self.bounds;
}

- (void)initialization {
    self.backgroundColor = [UIColor redColor];
    self.toValue = 1.f;
    self.beginTime = 0.f;
    if (!self.lineColor) {
        self.lineColor = [UIColor grayColor];
    }
}

- (void)addCustomControl {
    self.shapeLayer = CAShapeLayer.layer;
    self.shapeLayer.anchorPoint = CGPointMake(.5, .5);
    self.shapeLayer.backgroundColor = [self.lineColor CGColor];
    [self.layer addSublayer:self.shapeLayer];
}

- (CABasicAnimation *)getScaleAnimationToValue:(CGFloat)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.duration = 0.2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.autoreverses = YES;
    animation.beginTime = CACurrentMediaTime() + self.beginTime;
    animation.delegate = self;
//    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.animateEnable) {
        [self addAnimate];
    }
}

- (void)addAnimate {
    [self.shapeLayer addAnimation:[self getScaleAnimationToValue:self.toValue] forKey:@"animation"];
}

- (void)beginAnimate {
    if (self.animateEnable) {
        return;
    }
    self.animateEnable = true;
    [self addAnimate];
}

- (void)stopAnimate {
    self.animateEnable = false;
}

@end

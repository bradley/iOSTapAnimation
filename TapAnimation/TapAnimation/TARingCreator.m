//
//  TARingCreator.m
//  TapAnimation
//
//  Created by Bradley Griffith on 8/6/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "TARingCreator.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat RingRadius = 25;
const CGFloat RingPadding = 5; // extra space to prevent the stroke from clipping

@interface TARingCreator()
@property (nonatomic, strong)UIView *superView;
@end

@implementation TARingCreator

- (id)init {
    [NSException raise:@"Wrong init method called."
                format:@"Call initWithSuperView: instead and pass a UIView."];
    return nil;
}

- (id)initWithSuperView:(UIView *)superView {
    self = [super init];
    if (self) {
        _superView = superView;
    }
    return self;
}

- (void)animateRingAtPoint:(CGPoint)point {

    CGFloat size = (RingRadius * 2) + (RingPadding * 2);
    CGFloat adjustedOriginX = point.x - (size / 2);
    CGFloat adjustedOriginY = point.y - (size / 2);
    
    // Create the circle path
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddArc(circlePath, nil, point.x, point.y, RingRadius, 0, 2 * M_PI, YES);
    
    // Create a shape layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 3.0f;
    shapeLayer.bounds = CGRectMake(adjustedOriginX, adjustedOriginY, size, size);
    shapeLayer.anchorPoint = CGPointMake(.5f, .5f); // Center of ring.
    shapeLayer.position = CGPointMake(point.x, point.y);
    shapeLayer.path = circlePath;

    [_superView.layer addSublayer:shapeLayer];
   
    // Release the circle path
    CGPathRelease(circlePath);
    
    [self growShapeLayer:shapeLayer];
}

- (void)growShapeLayer:(CAShapeLayer *)shapeLayer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [shapeLayer valueForKey:@"transform"];
    CATransform3D transform = CATransform3DMakeScale(1.3f, 1.3f, 1.f);
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = 0.05f;
    animation.delegate = self;
    shapeLayer.transform = transform;
    [animation setValue:@"grow" forKey:@"name"];
    [animation setValue:shapeLayer forKey:@"layer"];
    [shapeLayer addAnimation:animation forKey:@"transform"];
}


- (void)fadeOutShapeLayer:(CAShapeLayer *)shapeLayer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [shapeLayer valueForKey:@"opacity"];
    animation.toValue = [NSNumber numberWithFloat:0.f];
    animation.duration = .25f;
    animation.delegate = self;
    shapeLayer.opacity = 0.f;
    [animation setValue:@"fade" forKey:@"name"];
    [animation setValue:shapeLayer forKey:@"layer"];
    [shapeLayer addAnimation:animation forKey:@"opacity"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && [[anim valueForKey:@"name"] isEqual:@"grow"]) {
        // when the grow animation is complete, we fade the layer
        CAShapeLayer* shapeLayer = [anim valueForKey:@"layer"];
        [self fadeOutShapeLayer:shapeLayer];
    }
    else if (flag && [[anim valueForKey:@"name"] isEqual:@"fade"]) {
        // when the fade animation is complete, we remove the layer
        CALayer* layer = [anim valueForKey:@"layer"];
        [layer removeFromSuperlayer];
    }
}
@end

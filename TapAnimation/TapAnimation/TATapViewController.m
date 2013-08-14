//
//  TATapViewController.m
//  TapAnimation
//
//  Created by Bradley Griffith on 8/6/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "TATapViewController.h"
#import "TARingCreator.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat RingRadius = 10;

@interface TATapViewController ()
@property (nonatomic, strong)TARingCreator *ringCreator;
@end

@implementation TATapViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _ringCreator = [[TARingCreator alloc] initWithSuperView:_tapView];
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewTapped:)];
    [tapOnView setNumberOfTapsRequired:1];
    [_tapView addGestureRecognizer:tapOnView];
}

- (void)tapViewTapped:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:_tapView];
    [_ringCreator animateRingAtPoint:location];
}

@end

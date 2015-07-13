//
//  BBDangleCollectionView.m
//  BBDangleCollectionView
//
//  Created by Bryan Boyko on 7/12/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "BBDangleCollectionView.h"

@interface BBDangleCollectionView () <UIGestureRecognizerDelegate, DangleViewDelegate>

@property (nonatomic) NSUInteger numberOfItems;
@property (nonatomic, strong) NSMutableArray *dangleViewsArr;
//@property (nonatomic, strong) NSMutableDictionary *dangleViewsDict;
@property (nonatomic) BOOL bubbaBool;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation BBDangleCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializeVariables];
    }
    return self;
}

- (void)didMoveToSuperview
{
    [self getItemsCount];
    [self retrieveDangleViewsAndSetupForAnimations];
    [self setupSelfForAnimations];
}

- (void)initializeVariables
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.dangleViewsArr = [[NSMutableArray alloc] init];
//    self.dangleViewsDict = [[NSMutableDictionary alloc] init];
}

- (void)getItemsCount
{
    self.numberOfItems = [self.dataSource numberOfItems];
}

- (void)retrieveDangleViewsAndSetupForAnimations
{
    for (NSUInteger i = 0; i < self.numberOfItems; i++) {
        
        BBDangleView *dangleView = [self.dataSource dangleCollectionView:self
                                                      dangleViewForIndex:i];
        dangleView.delegate = self;
        [self addSubview:dangleView];
        [self.dangleViewsArr addObject:dangleView];
//        [self.dangleViewsDict setObject:dangleView forKey:[NSNumber numberWithInteger:i]];
        dangleView.tag = i;
        [self setupViewForAnimation:dangleView];
    }
}

- (void)setupViewForAnimation:(BBDangleView *)view
{
    view.attachment = [[UIAttachmentBehavior alloc] initWithItem:view
                                                      offsetFromCenter:UIOffsetMake(-30, -30)
                                                      attachedToAnchor:CGPointMake(CGRectGetMidX(self.bounds), 50)];
    
    view.attachment.length = self.bubbaBool?60:120;
    view.attachment.damping = 0.1;
    view.attachment.frequency = self.bubbaBool?0.6:0;
    [self.animator addBehavior:view.attachment];
}

- (void)setupSelfForAnimations
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:self.dangleViewsArr];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.dangleViewsArr];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self];
    [self.dangleViewsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BBDangleView *dangleView = (BBDangleView *)obj;
        [dangleView.attachment setAnchorPoint:point];
    }];
}


#pragma mark - dangleViewDelegate

- (void)touchesEndedOnView:(BBDangleView *)view
{
    [self.delegate dangleCollectionView:self
                 didSelectItemWithIndex:view.tag];
    
    if ([view.backgroundColor isEqual:[UIColor redColor]]) {
        view.backgroundColor = [UIColor yellowColor];
    } else {
        view.backgroundColor = [UIColor redColor];
    }
}


@end

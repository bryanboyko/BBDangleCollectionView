//
//  BBDangleView.h
//  BBDangleCollectionView
//
//  Created by Bryan Boyko on 7/12/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DangleViewDelegate;

@interface BBDangleView : UIView

@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong) id<DangleViewDelegate> delegate;

@end


@protocol DangleViewDelegate <NSObject>

- (void)touchesEndedOnView:(BBDangleView *)view;

@end

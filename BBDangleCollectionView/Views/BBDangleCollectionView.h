//
//  BBDangleCollectionView.h
//  BBDangleCollectionView
//
//  Created by Bryan Boyko on 7/12/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDangleView.h"

@protocol BBDangleDataSource;
@protocol BBDangleDelegate;


@interface BBDangleCollectionView : UIView

@property (nonatomic, strong) id<BBDangleDataSource> dataSource;
@property (nonatomic, strong) id<BBDangleDelegate> delegate;

@end




@protocol BBDangleDataSource <NSObject>

- (NSUInteger)numberOfItems;
- (BBDangleView *)dangleCollectionView:(BBDangleCollectionView *)collectionView
                    dangleViewForIndex:(NSUInteger)index;
   
@end


@protocol BBDangleDelegate <NSObject>

- (void)dangleCollectionView:(BBDangleCollectionView *)collectionView
      didSelectItemWithIndex:(NSUInteger)index;

@end
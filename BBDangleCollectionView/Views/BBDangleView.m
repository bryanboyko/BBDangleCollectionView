//
//  BBDangleView.m
//  BBDangleCollectionView
//
//  Created by Bryan Boyko on 7/12/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "BBDangleView.h"

@implementation BBDangleView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate touchesEndedOnView:self];
}

@end

//
//  ViewController.m
//  BBDangleCollectionView
//
//  Created by Bryan Boyko on 7/12/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "ViewController.h"
#import "BBDangleCollectionView.h"

@interface ViewController () <BBDangleDelegate, BBDangleDataSource>

@property (nonatomic, strong) BBDangleCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupItems];
    [self setupCollectionView];
}

- (void)setupItems
{
    self.items = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        NSNumber *num = [[NSNumber alloc] initWithDouble:23];
        [self.items addObject:num];
    }
}

- (void)setupCollectionView
{
    self.collectionView = [[BBDangleCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
}

#pragma mark - BBDangleDataSource

- (NSUInteger)numberOfItems
{
    return self.items.count;
}

- (BBDangleView *)dangleCollectionView:(BBDangleCollectionView *)collectionView
                    dangleViewForIndex:(NSUInteger)index
{
    NSNumber *num = [self.items objectAtIndex:index];
    BBDangleView *dangleView = [[BBDangleView alloc] initWithFrame:CGRectMake((index+1)*25, 0, 50, 50)];
    dangleView.layer.cornerRadius = 10.0f;
    dangleView.layer.borderColor = [UIColor grayColor].CGColor;
    dangleView.layer.borderWidth = 1.0f;
    dangleView.layer.shadowColor = [UIColor blackColor].CGColor;
    dangleView.layer.shadowRadius = 5.0f;
    dangleView.layer.shadowOpacity = 0.8f;
    dangleView.layer.shadowOffset = CGSizeMake(0, 0);
    dangleView.backgroundColor = [UIColor redColor];
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.text = [num stringValue];
    [dangleView addSubview:numLabel];
    return dangleView;
}


#pragma mark - BBDangleDelegate

- (void)dangleCollectionView:(BBDangleCollectionView *)collectionView
      didSelectItemWithIndex:(NSUInteger)index
{

}



@end

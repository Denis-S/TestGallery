//
//  TGModel.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TGModelDelegate;

//////////////////////////////////////////////////////////////
@interface TGModel : NSObject

@property (strong) NSMutableArray *items;
@property (weak) id<TGModelDelegate> delegate;

- (void)loadData;

- (void)fireModelDidFinishLoad;
- (void)fireModelDidFinishLoadWithError:(NSError *)error;

@end


//////////////////////////////////////////////////////////////
@protocol TGModelDelegate <NSObject>

- (void)modelDidFinishLoad:(TGModel *)model;
- (void)model:(TGModel *)model didFinishLoadWithError:(NSError *)error;

@end
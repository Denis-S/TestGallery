//
//  TGGalleryView.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSGalleryViewCell.h"

@protocol DSGalleryViewDataSource, DSGalleryViewDelegate;


////////////////////////////////////////////////////////////////////////////////////////////////////
@interface DSGalleryView : UIScrollView <UIScrollViewDelegate>

@property (weak) id<DSGalleryViewDataSource> dataSource;
@property (weak) id<DSGalleryViewDelegate> galleryDelegate;

@property (assign) NSInteger cellAngle;
@property (assign) CGSize cellSize;

// initialization
- (id)initWithFrame:(CGRect)frame;

// configuring gallery view
- (DSGalleryViewCell *)dequeueReusableCellWithIdentifier:(NSString*)identifier;
- (NSUInteger)numberOfCells;

// accessing cells
- (DSGalleryViewCell *)cellForRowAtIndex:(NSInteger)index;

// reloading
- (void)reloadData;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol DSGalleryViewDataSource <NSObject>

@required
// configuring a gallery view
- (NSInteger)numberOfRowsInGalleryView:(DSGalleryView *)galleryView;
- (DSGalleryViewCell *)galleryView:(DSGalleryView *)galleryView cellForRowAtIndex:(NSInteger)index;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol DSGalleryViewDelegate <NSObject>

@optional
//configuring rows
- (CGSize)galleryViewCellSize:(DSGalleryView *)galleryView;

//managing selections
- (void)galleryView:(DSGalleryView *)galleryView didSelectRowAtIndex:(NSInteger)index;

@end
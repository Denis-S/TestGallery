//
//  TGGalleryViewController.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGGalleryModel.h"
#import "DSGalleryView.h"

@class TGMediaFile;

@interface TGGalleryViewController : UIViewController <TGModelDelegate, DSGalleryViewDataSource, DSGalleryViewDelegate>

// injection properties
@property (strong) NSManagedObjectContext *managedObjectContext;

// model properties
@property (strong) TGGalleryModel *model;

// view properties
@property (strong) DSGalleryView *galleryView;
@property (strong) UIButton *addPhotosButton;

// actions
- (void)addPhotos;
- (void)previewMediaFile:(TGMediaFile *)mediaFile;

@end

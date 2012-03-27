//
//  TGMediaFilesViewController.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaFilesModel.h"
#import "GMGridView.h"

@class TGMediaAlbum;
@class TGMediaFile;

@interface TGMediaFilesViewController : UIViewController <TGModelDelegate, 
GMGridViewDataSource, GMGridViewActionDelegate>

// injection properties
@property (strong) NSManagedObjectContext *managedObjectContext;
@property (strong) TGMediaAlbum *mediaAlbum;

// model properties
@property (strong) TGMediaFilesModel *model;

// view properties
@property (strong) GMGridView *gridView;

// actions
- (void)done;
- (void)previewMediaFile:(TGMediaFile *)mediaFile;

@end

//
//  TGMediaAlbumsViewController.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaAlbumsModel.h"

@class TGMediaAlbum;

@interface TGMediaAlbumsViewController : UIViewController <TGModelDelegate, 
UITableViewDataSource, UITableViewDelegate>

// injection properties
@property (strong) NSManagedObjectContext *managedObjectContext;

// model properties
@property (strong) TGMediaAlbumsModel *model;

// view properties
@property (strong) UITableView *tableView;

// actions
- (void)showMediaAlbum:(TGMediaAlbum *)mediaAlbum;

@end


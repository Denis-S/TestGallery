//
//  TGMediaFilesModel.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGModel.h"

@class TGMediaAlbum;
@class TGMediaFile;

@interface TGMediaFilesModel : TGModel 

@property (strong) NSManagedObjectContext *managedObjectContext;
@property (strong) TGMediaAlbum *mediaAlbum;

//designated initializer
- (id)initWithMediaAlbum:(TGMediaAlbum *)mediaAlbum 
     managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSArray *)mediaFiles;

// handle media selection methods
- (BOOL)isSelectedMediaFile:(TGMediaFile *)mediaFile;
- (void)selectMediaFile:(TGMediaFile *)mediaFile;
- (void)deselectMediaFile:(TGMediaFile *)mediaFile;

@end

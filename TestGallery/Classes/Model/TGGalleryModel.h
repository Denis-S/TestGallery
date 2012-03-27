//
//  TGGalleryModel.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGModel.h"

@interface TGGalleryModel : TGModel {
    ALAssetsLibrary *_assetsLibrary;
}

@property (strong) NSManagedObjectContext *managedObjectContext;

//designated initializer
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSArray *)mediaFiles;

@end

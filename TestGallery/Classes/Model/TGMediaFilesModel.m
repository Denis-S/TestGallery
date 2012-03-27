//
//  TGMediaFilesModel.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaFilesModel.h"
#import "TGAssetsGroupMediaAlbum.h"
#import "TGMediaFile.h"
#import "TGSelectedMediaFile.h"

//////////////////////////////////////////////////////////////
@interface TGMediaFilesModel ()

- (void)_loadAssetsMediaFilesForGroup:(ALAssetsGroup *)group;

@end

//////////////////////////////////////////////////////////////
@implementation TGMediaFilesModel

@synthesize managedObjectContext = _managedObjectContext;
@synthesize mediaAlbum = _mediaAlbum;

#pragma mark - Initialization

- (id)initWithMediaAlbum:(TGMediaAlbum *)mediaAlbum 
    managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [super init];
    if (self) {
        _managedObjectContext = managedObjectContext;
        _mediaAlbum = mediaAlbum;
    }
    return self;
}

#pragma mark - Model Data

- (NSArray *)mediaFiles {
    return self.items;
}

#pragma mark - Model Actions

- (void)loadData {
    assert([self.mediaAlbum isKindOfClass:[TGAssetsGroupMediaAlbum class]]); //only support assets album for now
    
    [self _loadAssetsMediaFilesForGroup:[(TGAssetsGroupMediaAlbum *)self.mediaAlbum assetsGroup]];
}

- (BOOL)isSelectedMediaFile:(TGMediaFile *)mediaFile {
    TGSelectedMediaFile *selectedAsset = [TGSelectedMediaFile findEntityForMediaFile:mediaFile
                                                  inManagedObjectContext:self.managedObjectContext];
    if (selectedAsset) {
        return YES;
    }
    
    return NO;
}

- (void)selectMediaFile:(TGMediaFile *)mediaFile {
    [TGSelectedMediaFile createEntityForMediaFile:mediaFile inManagedObjectContext:self.managedObjectContext];
}

- (void)deselectMediaFile:(TGMediaFile *)mediaFile {
    [TGSelectedMediaFile deleteEntityForMediaFile:mediaFile inManagedObjectContext:self.managedObjectContext];
}

#pragma mark - Private Helpers

- (void)_loadAssetsMediaFilesForGroup:(ALAssetsGroup *)group {    
    [self.items removeAllObjects];
        
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            TGMediaFile *mediaFile = [TGMediaFile mediaFileWithAsset:asset];
            [self.items addObject:mediaFile];
        }
    };
    
    [group setAssetsFilter:[ALAssetsFilter allAssets]];
    [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
    
    [super fireModelDidFinishLoad];
}

@end

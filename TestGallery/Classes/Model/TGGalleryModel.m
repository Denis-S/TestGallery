//
//  TGGalleryModel.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGGalleryModel.h"
#import "TGMediaFile.h"
#import "TGSelectedMediaFile.h"

//////////////////////////////////////////////////////////////
@interface TGGalleryModel ()

- (void)_loadMediaFromAssets;

@end


//////////////////////////////////////////////////////////////
@implementation TGGalleryModel

@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    self = [super init];
    if (self) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        _managedObjectContext = managedObjectContext;
    }
    
    return self;
}

#pragma mark - Model Data

- (NSArray *)mediaFiles {
    return self.items;
}

#pragma mark - Model Actions

- (void)loadData {
    [self _loadMediaFromAssets];
}

#pragma mark - Private Helpers

- (void)_loadMediaFromAssets {        
    [self.items removeAllObjects];
    
    // load selected media for gallery 
    NSArray *selectedMediaFiles = [TGSelectedMediaFile findAllInManagedObjectContext:self.managedObjectContext];
    if ([selectedMediaFiles count] == 0) {
        [super fireModelDidFinishLoad];
        return;
    }
    
    // load assets
    __block NSInteger processingBlocks = 0;
    
    for (TGSelectedMediaFile *selectedMediaFile in selectedMediaFiles) {
        NSURL *url = [NSURL URLWithString:selectedMediaFile.uri];
        ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
            TGMediaFile *mediaFile = [TGMediaFile mediaFileWithAsset:asset];
            [self. items addObject:mediaFile];
            
            if (--processingBlocks == 0) { //check if it is the last block
                [self performSelectorOnMainThread:@selector(fireModelDidFinishLoad) 
                                       withObject:nil 
                                    waitUntilDone:NO];
            }
        };
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
            //TODO handle error, maybe should delete stored file?
            if (--processingBlocks == 0) { //check if it is the last block
                [self performSelectorOnMainThread:@selector(fireModelDidFinishLoad) 
                                       withObject:nil 
                                    waitUntilDone:NO];
            }
        };
        
        [_assetsLibrary assetForURL:url resultBlock:resultBlock failureBlock:failureBlock];
        processingBlocks++;
    }
}

@end

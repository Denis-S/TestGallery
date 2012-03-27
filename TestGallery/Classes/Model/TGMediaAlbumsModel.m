//
//  TGMediaAlbumsModel.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaAlbumsModel.h"
#import "TGMediaAlbum.h"

//////////////////////////////////////////////////////////////
@interface TGMediaAlbumsModel ()

- (void)_loadAlbumsFromAssetsGroups;

@end

//////////////////////////////////////////////////////////////
@implementation TGMediaAlbumsModel

@synthesize groupTypes = _groupTypes;

#pragma mark - Initialization

- (id)init {
    self = [super init];
    if (self) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        _groupTypes = ALAssetsGroupAlbum | ALAssetsGroupSavedPhotos;
    }
    return self;
}

#pragma mark - Model Data

- (NSArray *)mediaAlbums {
    return self.items;
}

#pragma mark - Model Actions

- (void)loadData {
    [self _loadAlbumsFromAssetsGroups];
}

#pragma mark - Private Helpers

- (void)_loadAlbumsFromAssetsGroups {    
    [self.items removeAllObjects];
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            TGMediaAlbum *album = [TGMediaAlbum mediaAlbumWithAssetsGroup:group];
            [self.items addObject:album];
        } else {
            [super performSelectorOnMainThread:@selector(fireModelDidFinishLoad) withObject:nil waitUntilDone:NO];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        [super performSelectorOnMainThread:@selector(fireModelDidFinishLoadWithError:) withObject:error waitUntilDone:NO];
    };
    
    [_assetsLibrary enumerateGroupsWithTypes:self.groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
}

@end

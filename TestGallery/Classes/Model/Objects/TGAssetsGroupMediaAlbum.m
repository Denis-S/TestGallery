//
//  TGAssetsGroupMediaAlbum.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGAssetsGroupMediaAlbum.h"

@implementation TGAssetsGroupMediaAlbum

#pragma mark - Initialization

- (id)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup {
    self = [super init];
    if (self) {
        _assetsGroup = assetsGroup;
        
        _title = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    }
    
    return self;
}


#pragma mark - Public properties

- (ALAssetsGroup *)assetsGroup {
    return _assetsGroup;
}

- (UIImage *)thumbnail {
    return [UIImage imageWithCGImage:[_assetsGroup posterImage]];
}

@end

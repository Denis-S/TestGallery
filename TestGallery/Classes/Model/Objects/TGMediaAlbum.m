//
//  TGMediaAlbum.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaAlbum.h"
#import "TGAssetsGroupMediaAlbum.h"

@implementation TGMediaAlbum

+ (TGMediaAlbum *)mediaAlbumWithAssetsGroup:(ALAssetsGroup *)assetsGroup {
    return [[TGAssetsGroupMediaAlbum alloc] initWithAssetsGroup:assetsGroup];
}

- (NSString *)title {
    return _title;
}

- (UIImage *)thumbnail {
    return _thumbnail;
}

@end

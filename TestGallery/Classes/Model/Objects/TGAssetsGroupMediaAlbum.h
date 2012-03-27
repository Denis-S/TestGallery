//
//  TGAssetsGroupMediaAlbum.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaAlbum.h"

@interface TGAssetsGroupMediaAlbum : TGMediaAlbum {
    ALAssetsGroup *_assetsGroup;
}

@property (readonly) ALAssetsGroup *assetsGroup;

- (id)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup;

@end

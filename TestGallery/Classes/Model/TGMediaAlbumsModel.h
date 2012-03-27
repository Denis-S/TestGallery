//
//  TGMediaAlbumsModel.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGModel.h"

@interface TGMediaAlbumsModel : TGModel {
    ALAssetsLibrary *_assetsLibrary;
}

//assets groups types, default is ALAssetsGroupAlbum | ALAssetsGroupSavedPhotos
@property (readonly) NSInteger groupTypes; 

- (NSArray *)mediaAlbums;

@end

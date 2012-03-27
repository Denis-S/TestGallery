//
//  TGAssetMediaFile.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaFile.h"

@interface TGAssetMediaFile : TGMediaFile {
    ALAsset *_asset;
}

- (id)initWithAsset:(ALAsset *)asset;

@end

//
//  TGAssetMediaFile.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGAssetMediaFile.h"

@interface TGAssetMediaFile ()

- (TGMediaFileType)_mediaFileTypeForAsset:(ALAsset *)asset;

@end

@implementation TGAssetMediaFile

#pragma mark - Initialization

- (id)initWithAsset:(ALAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;

        _type = [self _mediaFileTypeForAsset:asset];
        _date = [asset valueForProperty:ALAssetPropertyDate];
        _uri = [asset.defaultRepresentation.url absoluteString];
    }
    return self;
}


#pragma mark - Public properties

- (UIImage *)thumbnail {
    return [UIImage imageWithCGImage:[_asset thumbnail]];
}

- (UIImage *)fullScreenImage {
    return [UIImage imageWithCGImage:_asset.defaultRepresentation.fullScreenImage];
}


#pragma mark - Private Helpers

- (TGMediaFileType)_mediaFileTypeForAsset:(ALAsset *)asset {
    if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
        return TGMediaFileTypePhoto;
    } else if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
        return TGMediaFileTypeVideo;
    }
    
    return TGMediaFileTypeUndefined;
}

@end

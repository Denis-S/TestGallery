//
//  TGMediaFile.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaFile.h"
#import "TGAssetMediaFile.h"

@implementation TGMediaFile

+ (TGMediaFile *)mediaFileWithAsset:(ALAsset *)asset {
    return [[TGAssetMediaFile alloc] initWithAsset:asset];
}

- (TGMediaFileType)type {
    return _type;
}

- (UIImage *)thumbnail {
    return _thumbnail;
}

- (UIImage *)fullScreenImage {
    return _fullScreenImage;
}

- (NSString *)uri {
    return _uri;
}

- (NSDate *)date {
    return _date;
}

@end

//
//  TGMediaFile.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TGAssetMediaFile;

typedef enum {
    TGMediaFileTypeUndefined = 0,
    TGMediaFileTypePhoto,
    TGMediaFileTypeVideo
} TGMediaFileType;

@interface TGMediaFile : NSObject {
@protected
    TGMediaFileType _type;
    UIImage *_thumbnail;
    UIImage *_fullScreenImage;
    NSString *_uri;
    NSDate *_date;
}

@property (readonly) TGMediaFileType type;
@property (readonly) UIImage *fullScreenImage;
@property (readonly) UIImage *thumbnail;
@property (readonly) NSString *uri;
@property (readonly) NSDate *date;

+ (TGMediaFile *)mediaFileWithAsset:(ALAsset *)asset;

@end

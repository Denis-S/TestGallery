//
//  TGMediaAlbum.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGMediaAlbum : NSObject {
@protected
    NSString *_title;
    UIImage *_thumbnail;
}

@property (readonly) NSString *title;
@property (readonly) UIImage *thumbnail;

+ (TGMediaAlbum *)mediaAlbumWithAssetsGroup:(ALAssetsGroup *)assetsGroup;

@end

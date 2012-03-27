//
//  TGGalleryViewCell.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSGalleryViewCell.h"

@interface TGGalleryViewCell : DSGalleryViewCell

@property (strong) UIImageView *imageView;

+ (CGSize)defaultSize;

@end

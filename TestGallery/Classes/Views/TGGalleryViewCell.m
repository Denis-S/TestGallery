//
//  TGGalleryViewCell.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGGalleryViewCell.h"
#import <QuartzCore/QuartzCore.h>

#define kViewCellSize CGSizeMake(160, 160)

#define kCellCornerRadius 10.0f
#define kCellBorderWidth 4.0f
#define kCellBorderCGColor [[UIColor whiteColor] CGColor]

@implementation TGGalleryViewCell

@synthesize imageView = _imageView;

+ (CGSize)defaultSize {
    return kViewCellSize;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewCellSize.width, kViewCellSize.height)];
        _imageView.backgroundColor = [UIColor whiteColor];
        
        CALayer *imageLayer = _imageView.layer;
        [imageLayer setMasksToBounds:YES];
        [imageLayer setCornerRadius:kCellCornerRadius];
        [imageLayer setBorderWidth:kCellBorderWidth];
        [imageLayer setBorderColor:kCellBorderCGColor];
        
        [self.contentView addSubview:_imageView];
    }
    
    return self;
}

@end

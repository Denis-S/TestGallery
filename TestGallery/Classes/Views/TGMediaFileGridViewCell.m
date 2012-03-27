//
//  TGMediaFileGridViewCell.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaFileGridViewCell.h"

@implementation TGMediaFileGridViewCell

@synthesize imageView = _imageView;
@synthesize footerView = _footerView;

+ (CGSize)defaultSize {
    return CGSizeMake(125, 169);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = [TGMediaFileGridViewCell defaultSize];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        self.contentView = contentView;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.width)];
        _imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imageView];
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, size.width, size.width, size.height - size.width)];
        [self.contentView addSubview:_footerView];
    }
    return self;
}

@end

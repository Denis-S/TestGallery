//
//  TGGalleryViewCell.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DSGalleryViewCell.h"

@implementation DSGalleryViewCell

@synthesize contentView = _contentView;

- (id)initWithReuseIdentifier:(NSString*)reuseIdentifier {
    self = [super init];
    if (self) {
        _reuseIdentifier = reuseIdentifier;
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_contentView];
    }

	return self;
}

- (NSString *)reuseIdentifier {
    return _reuseIdentifier;
}

@end

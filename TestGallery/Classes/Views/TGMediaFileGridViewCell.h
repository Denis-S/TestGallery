//
//  TGMediaFileGridViewCell.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GMGridView.h"

@interface TGMediaFileGridViewCell : GMGridViewCell

+ (CGSize)defaultSize;

@property (strong) UIImageView *imageView;
@property (strong) UIView *footerView;

@end

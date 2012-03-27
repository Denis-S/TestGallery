//
//  TGGalleryViewCell.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSGalleryViewCell : UIView {
    NSString *_reuseIdentifier;
}

@property (readonly) NSString *reuseIdentifier;

@property (strong) UIView *contentView; //use content view to add custom views

// designated initializer
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

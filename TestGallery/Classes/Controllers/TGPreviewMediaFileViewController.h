//
//  TGPreviewMediaFileViewController.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@class TGMediaFile;

@interface TGPreviewMediaFileViewController : UIViewController

// view properties
@property (strong) MPMoviePlayerViewController *moviePlayerVC;

// model properties
@property (strong) TGMediaFile *mediaFile;

@end

//
//  TGPreviewMediaFileViewController.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGPreviewMediaFileViewController.h"
#import "TGMediaFile.h"

@implementation TGPreviewMediaFileViewController

#pragma mark - Properties

@synthesize moviePlayerVC = _moviePlayerVC;

@synthesize mediaFile = _mediaFile;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Preview", @"");
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO add factory for creating appropriate preview controllers
    if (self.mediaFile.type == TGMediaFileTypeVideo) {
        _moviePlayerVC =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.mediaFile.uri]];
        _moviePlayerVC.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [self presentMoviePlayerViewControllerAnimated:_moviePlayerVC];
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.mediaFile.fullScreenImage];
        [self.view addSubview:imageView];
    }
}

@end

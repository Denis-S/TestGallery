//
//  TGGalleryViewController.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGGalleryViewController.h"
#import "DSGalleryView.h"
#import "TGMediaAlbumsViewController.h"
#import "TGMediaFile.h"
#import "TGGalleryViewCell.h"
#import "TGPreviewMediaFileViewController.h"

@implementation TGGalleryViewController

#pragma mark - Properties

@synthesize managedObjectContext = _managedObjectContext;

@synthesize model = _model;

@synthesize galleryView = _galleryView;
@synthesize addPhotosButton = _addPhotosButton;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Gallery",@"");
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //assert injections
    assert(self.managedObjectContext);
    
    // init controller model
    _model = [[TGGalleryModel alloc] initWithManagedObjectContext:self.managedObjectContext];
    _model.delegate = self;
    
    // create view
    _galleryView = [[DSGalleryView alloc] initWithFrame:self.view.bounds];
    _galleryView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _galleryView.backgroundColor = [UIColor darkGrayColor];
    _galleryView.dataSource = self;
    _galleryView.galleryDelegate = self;
    [self.view addSubview:_galleryView];
    
    _addPhotosButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addPhotosButton.frame = CGRectMake(10, 400, 300, 44);
    _addPhotosButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [_addPhotosButton setTitle:NSLocalizedString(@"Add photos from Library", @"") forState:UIControlStateNormal];
    [_addPhotosButton addTarget:self 
                         action:@selector(addPhotos) 
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addPhotosButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // refresh data on each appear
    [self.model loadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    self.galleryView = nil;
    self.addPhotosButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Public Actions

- (void)addPhotos {    
    TGMediaAlbumsViewController *controller = [[TGMediaAlbumsViewController alloc] initWithNibName:nil bundle:nil];
    controller.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)previewMediaFile:(TGMediaFile *)mediaFile {
    assert(mediaFile);
    
    TGPreviewMediaFileViewController *controller = [[TGPreviewMediaFileViewController alloc] initWithNibName:nil bundle:nil];
    controller.mediaFile = mediaFile;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - TGModelDelegate

- (void)modelDidFinishLoad:(TGModel *)model {
    [self.galleryView reloadData];
}

- (void)model:(TGModel *)model didFinishLoadWithError:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                         message:[error localizedDescription] 
                                                        delegate:nil 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
    [errorAlert show];
}


#pragma mark - TGGalleryViewDataSource

- (NSInteger)numberOfRowsInGalleryView:(DSGalleryView *)galleryView {
    return [self.model.mediaFiles count];
}

- (DSGalleryViewCell *)galleryView:(DSGalleryView *)galleryView cellForRowAtIndex:(NSInteger)index {
    assert(index >= 0 && index < [self.model.mediaFiles count]);
    
    static NSString *CellIdentifier = @"GalleryViewCell";
    
    TGGalleryViewCell *cell = (TGGalleryViewCell *)[galleryView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TGGalleryViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    
    TGMediaFile *mediaFile = [self.model.mediaFiles objectAtIndex:index];
    cell.imageView.image = mediaFile.thumbnail;
    
    return cell;
}


#pragma mark - TGGalleryViewDataSource

- (CGSize)galleryViewCellSize:(DSGalleryView *)galleryView {
    return [TGGalleryViewCell defaultSize];
}

- (void)galleryView:(DSGalleryView *)galleryView didSelectRowAtIndex:(NSInteger)index {
    assert(index >= 0 && index < [self.model.mediaFiles count]);
    
    TGMediaFile *mediaFile = [self.model.mediaFiles objectAtIndex:index];
    [self previewMediaFile:mediaFile];
}

@end

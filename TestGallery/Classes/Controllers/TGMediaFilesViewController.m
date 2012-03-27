//
//  TGMediaFilesViewController.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaFilesViewController.h"
#import "TGMediaFileGridViewCell.h"
#import "TGMEdiaAlbum.h"
#import "TGMediaFile.h"
#import "TGPreviewMediaFileViewController.h"
#import "TGSelectedMediaFile.h"

//////////////////////////////////////////////////////////////
@interface TGMediaFilesViewController ()

- (void)_mediaSelectedStateDidChange:(UISwitch *)switchControl;

@end


//////////////////////////////////////////////////////////////
@implementation TGMediaFilesViewController

#pragma mark - Properties

@synthesize managedObjectContext = _managedObjectContext;
@synthesize mediaAlbum = _mediaAlbum;

@synthesize model = _model;

@synthesize gridView = _gridView;


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //assert injections
    assert(self.managedObjectContext);
    assert(self.mediaAlbum);
    
    // set title as album name
    self.title = self.mediaAlbum.title;
    
    // init model
    _model = [[TGMediaFilesModel alloc] initWithMediaAlbum:self.mediaAlbum 
                                      managedObjectContext:self.managedObjectContext];
    _model.delegate = self;
    
    // create view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];         
    self.navigationItem.rightBarButtonItem = doneButton;
    
    _gridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gridView.centerGrid = YES;
    _gridView.itemSpacing = 20;
    _gridView.minEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 0);
    _gridView.actionDelegate = self;
    _gridView.dataSource = self;
    [self.view addSubview:_gridView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.model loadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.gridView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Public Actions

- (void)done {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)previewMediaFile:(TGMediaFile *)mediaFile {
    assert(mediaFile);
    
    TGPreviewMediaFileViewController *controller = [[TGPreviewMediaFileViewController alloc] initWithNibName:nil bundle:nil];
    controller.mediaFile = mediaFile;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - TGModelDelegate

- (void)modelDidFinishLoad:(TGModel *)model {
    [self.gridView reloadData];
}

- (void)model:(TGModel *)model didFinishLoadWithError:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                         message:[error localizedDescription] 
                                                        delegate:nil 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
    [errorAlert show];
}


#pragma mark - GMGridViewDataSource

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView{
    return [self.model.mediaFiles count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return [TGMediaFileGridViewCell defaultSize];
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index {
    assert(index >= 0 && index < [self.model.mediaFiles count]);
    
    TGMediaFileGridViewCell *cell = (TGMediaFileGridViewCell *)[gridView dequeueReusableCell];
    if (!cell) {
        cell = [[TGMediaFileGridViewCell alloc] init];
    }
    
    TGMediaFile *mediaFile = [self.model.mediaFiles objectAtIndex:index];
    cell.imageView.image = mediaFile.thumbnail;
    
    //add switch control
    UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(30, 12, 0, 0)];
    switchControl.tag = index;
    
    [self.model isSelectedMediaFile:mediaFile] ? [switchControl setOn:YES] : [switchControl setOn:NO];
    
    [switchControl addTarget:self 
                      action:@selector(_mediaSelectedStateDidChange:) 
            forControlEvents:UIControlEventValueChanged];
    
    [cell.footerView addSubview:switchControl];

    return cell;
}

#pragma mark - GMGridViewActionDelegate

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)index {
    assert(index >= 0 && index < [self.model.mediaFiles count]);
    
    TGMediaFile *mediaFile = [self.model.mediaFiles objectAtIndex:index];
    [self previewMediaFile:mediaFile];
}

#pragma - Private Actions

- (void)_mediaSelectedStateDidChange:(UISwitch *)switchControl {
    TGMediaFile *mediaFile = [self.model.mediaFiles objectAtIndex:switchControl.tag];
    [switchControl isOn] ? [self.model selectMediaFile:mediaFile] : [self.model deselectMediaFile:mediaFile];
}

@end

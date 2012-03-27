//
//  TGMediaAlbumsViewController.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGMediaAlbumsViewController.h"
#import "TGMediaFilesViewController.h"
#import "TGMediaAlbum.h"

@implementation TGMediaAlbumsViewController

#pragma mark - Properties

@synthesize managedObjectContext = _managedObjectContext;

@synthesize model = _model;

@synthesize tableView = _tableView;


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Select Folder",@"");
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //assert injections
    assert(self.managedObjectContext);
    
    //init model
    _model = [[TGMediaAlbumsModel alloc] init];
    _model.delegate = self;
    
    // create view
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.model loadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Public Actions

- (void)showMediaAlbum:(TGMediaAlbum *)mediaAlbum {
    assert(mediaAlbum);
    
    TGMediaFilesViewController *controller = [[TGMediaFilesViewController alloc] initWithNibName:nil bundle:nil];
    controller.managedObjectContext = self.managedObjectContext;
    controller.mediaAlbum = mediaAlbum;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - TGModelDelegate

- (void)modelDidFinishLoad:(TGModel *)model {
    [self.tableView reloadData];
}

- (void)model:(TGModel *)model didFinishLoadWithError:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                         message:[error localizedDescription] 
                                                        delegate:nil 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
    [errorAlert show];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    assert(section == 0);
    
    return [self.model.mediaAlbums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    assert(indexPath.row >= 0 && indexPath.row < [self.model.mediaAlbums count]);
    
    static NSString *CellIdentifier = @"AlbumCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    TGMediaAlbum *mediaAlbum = [self.model.mediaAlbums objectAtIndex:indexPath.row];
    cell.textLabel.text = mediaAlbum.title;
    cell.imageView.image = mediaAlbum.thumbnail;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    assert(indexPath.row >= 0 && indexPath.row < [self.model.mediaAlbums count]);
    
    TGMediaAlbum *mediaAlbum = [self.model.mediaAlbums objectAtIndex:indexPath.row];
    [self showMediaAlbum:mediaAlbum];
}

@end

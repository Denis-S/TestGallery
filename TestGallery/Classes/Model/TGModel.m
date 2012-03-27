//
//  TGModel.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGModel.h"

@implementation TGModel

@synthesize items = _items;
@synthesize delegate = _delegate;

#pragma mark - Initialization

- (id)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Model Actions

- (void)loadData {
    //nothing to do in a base class
}

#pragma mark - Delegation Helpers

- (void)fireModelDidFinishLoad {
    if ([self.delegate respondsToSelector:@selector(modelDidFinishLoad:)]) {
        [self.delegate modelDidFinishLoad:self];
    }
}

- (void)fireModelDidFinishLoadWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(model:didFinishLoadWithError:)]) {
        [self.delegate model:self didFinishLoadWithError:error];
    }  
}

@end

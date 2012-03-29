//
//  TGGalleryView.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DSGalleryView.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface DSGalleryView () {
    NSMutableDictionary *_queuedCells;
	NSMutableDictionary *_visibleCells;
    
    BOOL _didScrollFirstTime;
    
    NSInteger _firstVisibleCellIndex;
	NSInteger _lastVisibleCellIndex;
}

- (void)_clearVisibleCells;
- (CGRect)_frameForCellAtIndex:(NSInteger)index;
- (NSInteger)_cellIndexAtPoint:(CGPoint)point;
- (NSInteger)_calculateFirstVisibleCell;
- (NSInteger)_calculateLastVisibleCell;

- (void)_queueReusableCells;
- (void)_configureCell:(DSGalleryViewCell *)cell forIndex:(NSInteger)index;
- (void)_displayCellAtIndex:(NSUInteger)index;

- (void)_userDidTap:(UIGestureRecognizer*)sender;

@end

@implementation DSGalleryView

#pragma mark - Notes

//TODO add orientation support

#pragma mark - Properties

@synthesize dataSource = _dataSource;
@synthesize galleryDelegate = _galleryDelegate;

@synthesize cellAngle = _cellAngle;
@synthesize cellSize = _cellSize;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _queuedCells = [[NSMutableDictionary alloc] init];
		_visibleCells = [[NSMutableDictionary alloc] init];
        
        _cellAngle = 15;
        _cellSize = CGSizeMake(160, 160);
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [super setDelegate:self];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_userDidTap:)];
		tapRecognizer.numberOfTapsRequired = 1;
		tapRecognizer.numberOfTouchesRequired = 1;
		[self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews {
	[super layoutSubviews];

}

#pragma mark - Public Methods

// configuring gallery view
- (DSGalleryViewCell *)dequeueReusableCellWithIdentifier:(NSString*)identifier {
    if (!identifier) {
        return nil;
    }
    
    NSMutableSet *cells = [_queuedCells objectForKey:identifier];
    DSGalleryViewCell *cell = [cells anyObject];
    if (cell) {
        [cells removeObject:cell];
        [_queuedCells setObject:cells forKey:identifier];
    }
    
    return cell;
}

- (NSUInteger)numberOfCells {
    return [self.dataSource numberOfRowsInGalleryView:self];
}

// accessing cells
- (DSGalleryViewCell *)cellForRowAtIndex:(NSInteger)index {
    DSGalleryViewCell *cell = [_visibleCells objectForKey:[NSNumber numberWithInteger:index]];
	if ( !cell ) {
		cell = [self.dataSource galleryView:self cellForRowAtIndex:index];
	}
	return cell;
}

// reloading
- (void)reloadData {
    [self _clearVisibleCells];

	_firstVisibleCellIndex = 0;
	_lastVisibleCellIndex = 0;
	_didScrollFirstTime = YES;

    self.contentSize = CGSizeZero; //reset content size
    
    // calculate and set scroll view content size
    NSInteger numberOfRows = [self numberOfCells];

    if (numberOfRows > 0) {
        self.cellSize = [self.galleryDelegate galleryViewCellSize:self];
        
        CGFloat tmpOffset = 30; //TODO calculate offset depending on top of the first transformed cell
        CGFloat contentHeight = numberOfRows * self.cellSize.height;
        self.contentSize = CGSizeMake(self.contentSize.width, contentHeight + (2 * tmpOffset));
        self.contentOffset = CGPointMake(0, -tmpOffset);
        
        [self scrollViewDidScroll:self];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
	NSInteger currentFirstVisibleCell = [self _calculateFirstVisibleCell];
	NSInteger currentLastVisibleCell = [self _calculateLastVisibleCell];
	
    if (_firstVisibleCellIndex != currentFirstVisibleCell || _lastVisibleCellIndex != currentLastVisibleCell || _didScrollFirstTime) {
		_didScrollFirstTime = NO;
		_firstVisibleCellIndex = currentFirstVisibleCell;
		_lastVisibleCellIndex = currentLastVisibleCell;
		
        [self _queueReusableCells];
		
        for (NSInteger index = _firstVisibleCellIndex; index <= _lastVisibleCellIndex; index++) {
			[self _displayCellAtIndex:index];
		}
        
        for (NSInteger index = _firstVisibleCellIndex; index <= _lastVisibleCellIndex; index++) {
            DSGalleryViewCell *cell = [_visibleCells objectForKey:[NSNumber numberWithInteger:index]];
            if (cell) {
                CGRect cellFrame = [self _frameForCellAtIndex:index];
                if (!CGRectEqualToRect(cell.frame, cellFrame)) {
                    cell.frame = cellFrame;
                    [self _configureCell:cell forIndex:index]; //apply cell transformations
                }
            }
        }
	}
}

#pragma mark - UITapGestureRecognizer

- (void)_userDidTap:(UIGestureRecognizer*)sender {
	if ( sender.state == UIGestureRecognizerStateRecognized ) {        
		CGPoint location = [sender locationInView:self];
		NSArray *viewKeys = [_visibleCells allKeys];
        
		for (NSNumber *key in viewKeys) {
			UIView *view = [_visibleCells objectForKey:key];
			if ( [view pointInside:[self convertPoint:location toView:view] withEvent:nil] ) {
				NSUInteger index = [key unsignedIntegerValue];
                if ([self.galleryDelegate respondsToSelector:@selector(galleryView:didSelectRowAtIndex:)]) {
                    [self.galleryDelegate galleryView:self didSelectRowAtIndex:index];
                }
			}
		}
	}
}

#pragma mark - Private Methods

- (void)_queueReusableCells {
	NSArray *visibleCellKeys = [_visibleCells allKeys];
	for (NSNumber *key in visibleCellKeys) {
		NSInteger cellIndex = [key integerValue];
		if (cellIndex < _firstVisibleCellIndex || cellIndex > _lastVisibleCellIndex) {
			DSGalleryViewCell *cell = [_visibleCells objectForKey:key];
			if (cell) {
				[_visibleCells removeObjectForKey:key];
                
				NSMutableSet *queuedCells = [_queuedCells objectForKey:cell.reuseIdentifier];
				if (!queuedCells) {
					queuedCells = [[NSMutableSet alloc] init];
				}
				[queuedCells addObject:cell];
				[cell removeFromSuperview];
				[_queuedCells setObject:queuedCells forKey:cell.reuseIdentifier];
			}
		}
	}
}

- (void)_clearVisibleCells {
    // clear view
    NSArray *visibleCellsKeys = [_visibleCells allKeys];
	for (NSNumber *key in visibleCellsKeys) {
		UIView *view = [_visibleCells objectForKey:key];
		[view removeFromSuperview];
	}
    
    //clear data
	[_visibleCells removeAllObjects];
	[_queuedCells removeAllObjects];
}

- (CGRect)_frameForCellAtIndex:(NSInteger)index {
	return CGRectMake(self.bounds.size.width / 2 - self.cellSize.width / 2, self.cellSize.height * index, self.cellSize.width, self.cellSize.height);
}

- (void)_configureCell:(DSGalleryViewCell *)cell forIndex:(NSInteger)index {
    cell.contentView.transform = CGAffineTransformMakeRotation(degreesToRadian(index % 2 ? - self.cellAngle : + self.cellAngle));
}

- (void)_displayCellAtIndex:(NSUInteger)index {
    DSGalleryViewCell *cell = [self cellForRowAtIndex:index];
	if (cell) {
		[self addSubview:cell];
		[_visibleCells setObject:cell forKey:[NSNumber numberWithInteger:index]];
	}
}

- (NSInteger)_cellIndexAtPoint:(CGPoint)point {
	NSInteger row = floor(point.y / self.cellSize.height);
	row = MAX(row, 0);
	row = MIN(row, [self numberOfCells] - 1);
	
    return row;
}

- (NSInteger)_calculateFirstVisibleCell {
    return [self _cellIndexAtPoint:self.contentOffset];
}

- (NSInteger)_calculateLastVisibleCell {
    CGFloat contentOffsetX = self.contentOffset.x + self.bounds.size.width -1;
	CGFloat contentOffsetY = self.contentOffset.y + self.bounds.size.height -1;
	return [self _cellIndexAtPoint:CGPointMake(contentOffsetX, contentOffsetY)];
}

@end

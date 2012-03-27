//
//  TGSelectedMediaFile.h
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class TGMediaFile;

//////////////////////////////////////////////////////////////
@interface TGSelectedMediaFile : NSManagedObject

@property (strong) NSString *uri;
@property (strong) NSDate *date;

@end


//////////////////////////////////////////////////////////////
@interface TGSelectedMediaFile (ActiveRecord)

// creates new entity
+ (TGSelectedMediaFile *)createEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

// creates new entity with appropriate values for the specified media file
+ (TGSelectedMediaFile *)createEntityForMediaFile:(TGMediaFile *)mediaFile 
                    inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

// deletes entity entity for media file if entity exist
+ (void)deleteEntityForMediaFile:(TGMediaFile *)mediaFile 
      inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

// return all stored entities
+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

// search entity for the specified asset
+ (TGSelectedMediaFile *)findEntityForMediaFile:(TGMediaFile *)mediaFile  
                    inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

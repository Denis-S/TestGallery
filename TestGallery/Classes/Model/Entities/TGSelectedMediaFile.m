//
//  TGSelectedMediaFile.m
//  TestGallery
//
//  Created by Denis Shalagin on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TGSelectedMediaFile.h"
#import "TGMediaFile.h"

#define kEntityName @"TGSelectedMediaFile"

//////////////////////////////////////////////////////////////
@implementation TGSelectedMediaFile

@dynamic uri;
@dynamic date;

@end


//////////////////////////////////////////////////////////////
@implementation TGSelectedMediaFile (ActiveRecord)

+ (TGSelectedMediaFile *)createEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    return [NSEntityDescription insertNewObjectForEntityForName:kEntityName 
                                         inManagedObjectContext:managedObjectContext];
}

+ (TGSelectedMediaFile *)createEntityForMediaFile:(TGMediaFile *)mediaFile 
                    inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    TGSelectedMediaFile *entity = [self createEntityInManagedObjectContext:managedObjectContext];
    entity.uri = mediaFile.uri;
    entity.date = mediaFile.date;
    [managedObjectContext save:nil]; //TODO handle error
    
    return entity;
}

+ (void)deleteEntityForMediaFile:(TGMediaFile *)mediaFile 
      inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    TGSelectedMediaFile *entity = [TGSelectedMediaFile findEntityForMediaFile:mediaFile 
                                                       inManagedObjectContext:managedObjectContext];
    if (entity) {
        [managedObjectContext deleteObject:entity];
    }
    [managedObjectContext save:nil]; //TODO handle error
}

+ (NSArray *)findAllInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:kEntityName 
                                                         inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [request setSortDescriptors:sortDescriptors];
        
    NSArray *result = [managedObjectContext executeFetchRequest:request error:nil]; //TODO handle error
    return result;
}

+ (TGSelectedMediaFile *)findEntityForMediaFile:(TGMediaFile *)mediaFile  
                inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:kEntityName 
                                                         inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uri = %@", mediaFile.uri];
    [request setPredicate:predicate];
    
    NSArray *result = [managedObjectContext executeFetchRequest:request error:nil]; //TODO handle error
    if (!result || [result count] == 0) {
        return nil;
    }
    
    return [result objectAtIndex:0];
}

@end

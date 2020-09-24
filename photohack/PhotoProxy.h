#include <Photos/Photos.h>

@interface PhotoProxy : NSObject

//
// Static methods to interogate photos library schema/metadata
//

// Dump the database entity name to PH* class mapping
+ (NSDictionary*) entityToClass;

//
// Working with an individual (potentially non-default) photos library
//

// Open the *.photoslibrary package at the given path
+ (PhotoProxy*) fromPath:(NSString*)path;
// Extract adjustment dictionaries for a set of UUIDs in the photos library=
- (void) dumpAdjustments:(NSArray*)uuids;

@end

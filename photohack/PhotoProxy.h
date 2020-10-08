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
// Fetches assets matching the provided UUIDs
- (NSArray*) fetchAssets:(NSArray*)uuids;

// Returns a mapping of provided UUID values to adjustment dictionaries
- (NSDictionary*) fetchAdjustments:(NSArray*)uuids;
// Looks up adjustments for the provided asset
- (NSDictionary*) adjustments:(PHAsset*)asset;

// Write potentially adjusted JPEGs in a directory, each named by UUID
- (void) exportJPEGs:(NSArray*)uuids toDir:(NSString*)path;

@end

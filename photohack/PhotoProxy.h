#include <Photos/Photos.h>

@interface PhotoProxy : NSObject

// Dump the database entity name to PH* class mapping
+ (NSDictionary*) entityToClass;

+ (PhotoProxy*) fromPath:(NSString*)path;

- (void) dumpAdjustments:(NSArray*)uuids;

@end

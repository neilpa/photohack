#import "PhotoProxy.h"
#import "objc/message.h"

// Avoid all the warnings for dyanmically calling private methods
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation PhotoProxy {
    NSString *path;
    PHPhotoLibrary *lib;
}

+ (NSDictionary*) entityToClass {
    return [PHPhotoLibrary.self performSelector:@selector(PHObjectClassesByEntityName)];
}

+ (PhotoProxy*)fromPath:(NSString*)path {
    PhotoProxy* proxy = [[PhotoProxy alloc] init];
    proxy->path = path;

    // uncaught exception 'NSInternalInconsistencyException', reason: 'Requesting different library while in single library mode'
    [PHPhotoLibrary.self performSelector:@selector(enableMultiLibraryMode)];
        proxy->lib = ((id (*)(id, SEL, id, unsigned short))objc_msgSend)
        ([PHPhotoLibrary alloc], @selector(initWithPhotoLibraryURL:type:), [NSURL fileURLWithPath:path], 0);
    
    // HACK: This seems to work for detecting failures to load the library
    // TODO: Try the `uuid` property
    if (nil == [proxy->lib performSelector:@selector(albumRootFolderObjectID)]) {
        return nil;
    }
    
    return proxy;
}

#define dump(fmt, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:fmt, ##__VA_ARGS__])

- (void)dumpAdjustments:(NSArray*)uuids {
    NSArray *assets = ((id (*)(id, SEL, id, id))objc_msgSend)(self->lib, @selector(fetchPHObjectsForUUIDs:entityName:), uuids, @"Asset");
    
    [assets enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        // id url = [asset performSelector:@selector(mainFileURL)];
        [asset performSelector:@selector(fetchPropertySetsIfNeeded)];

        NSDictionary *metadata = [asset performSelector:@selector(adjustmentsDebugMetadata)];
        dump(@"adjustments: %@", uuids[idx]);
        if (metadata == nil) {
            dump(@"  <none>");
            return;
        }

        id composition = [metadata objectForKey:@"composition"];
        if (composition == nil) {
            dump(@"  <no-composition>");
            return;
        }
        
        NSDictionary* adjustments = [composition contents];
        dump(@"  %@", adjustments);
    }];

}


@end

#pragma clang diagnostic pop

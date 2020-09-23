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
    //    (lldb) po dict
    //    {
    //        Album = PHAssetCollection;
    //        Asset = PHAsset;
    //        CloudSharedAlbum = PHCloudSharedAlbum;
    //        DetectedFace = PHFace;
    //        DetectedFaceGroup = PHFaceGroup;
    //        FaceCrop = PHFaceCrop;
    //        FetchingAlbum = PHAssetCollection;
    //        Folder = PHCollectionList;
    //        GenericAsset = PHAsset;
    //        ImportSession = PHImportSession;
    //        Keyword = PHKeyword;
    //        LegacyFaceAlbum = PHAssetCollection;
    //        Memory = PHMemory;
    //        Moment = PHMoment;
    //        MomentList = PHMomentList;
    //        MomentShare = PHMomentShare;
    //        MomentShareParticipant = PHMomentShareParticipant;
    //        Person = PHPerson;
    //        PhotoStreamAlbum = PHAssetCollection;
    //        PhotosHighlight = PHPhotosHighlight;
    //        ProjectAlbum = PHProject;
    //        Question = PHQuestion;
    //        Suggestion = PHSuggestion;
    //    }
}

+ (PhotoProxy*)fromPath:(NSString*)path {
    // uncaught exception 'NSInternalInconsistencyException', reason: 'Requesting different library while in single library mode'
    [PHPhotoLibrary.self performSelector:@selector(enableMultiLibraryMode)];
    
    PhotoProxy* proxy = [[PhotoProxy alloc] init];
    proxy->path = path;
    proxy->lib = ((id (*)(id, SEL, id, unsigned short))objc_msgSend)
        ([PHPhotoLibrary alloc], @selector(initWithPhotoLibraryURL:type:), [NSURL fileURLWithPath:path], 0);
    
    return proxy;
}

#define dump(fmt, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:fmt, ##__VA_ARGS__])

- (void)dumpAdjustments:(NSArray*)uuids {
    NSArray *assets = ((id (*)(id, SEL, id, id))objc_msgSend)(self->lib, @selector(fetchPHObjectsForUUIDs:entityName:), uuids, @"Asset");
    
    [assets enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        // id url = [asset performSelector:@selector(mainFileURL)];
        [asset performSelector:@selector(fetchPropertySetsIfNeeded)];

        NSDictionary *adjustments = [asset performSelector:@selector(adjustmentsDebugMetadata)];
        dump(@"adjustments: %@", uuids[idx]);
        if (adjustments == nil) {
            dump(@"  <none>");
            return;
        }

        // Path to the NU* files `PrivateFrameworks/NeutrinoCore/`
        [adjustments enumerateKeysAndObjectsUsingBlock:^(NSString *key, id val, BOOL *stop) {
            dump(@"  %@ = %@", key, [val debugDescription]);
        }];
    }];
    //    composition = <NUGenericComposition:0x100457b60 id=me.neilpa.photohack:PhotosComposition~1.0 mediaType=Unknown contents={
    //      raw = <NUGenericAdjustment:0x100458080> id=me.neilpa.photohack:RAW~1.0 settings={
    //      auto = 0;
    //      enabled = 1;
    //      inputDecoderVersion = 8;
    //  },
    //      cropStraighten = <NUGenericAdjustment:0x1004582e0> id=me.neilpa.photohack:CropStraighten~1.0 settings={
    //      angle = "-0";
    //      auto = 0;
    //      constraintHeight = 0;
    //      constraintWidth = 0;
    //      enabled = 1;
    //      height = 988;
    //      width = 1482;
    //      xOrigin = 2342;
    //      yOrigin = 1127;
    //  },
    //      orientation = <NUGenericAdjustment:0x100458610> id=me.neilpa.photohack:Orientation~1.0 settings={
    //      value = 1;
    //  },

}


@end

#pragma clang diagnostic pop

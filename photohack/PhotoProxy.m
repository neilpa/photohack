#import "PhotoProxy.h"
#import "objc/message.h"

// Avoid all the warnings for dyanmically calling private methods
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

#define dump(fmt, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:fmt, ##__VA_ARGS__])

// Convert the composition, adjustment, and settings schemas to plain dictionaries.
NSDictionary* resolveSchema(id composition);
NSDictionary* resolveSetting(id setting);

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
    if (nil == [proxy->lib performSelector:@selector(uuid)]) {
        return nil;
    }
    
    return proxy;
}

- (NSDictionary*)fetchAdjustments:(NSArray*)uuids {
    NSArray *assets = ((id (*)(id, SEL, id, id))objc_msgSend)(self->lib, @selector(fetchPHObjectsForUUIDs:entityName:), uuids, @"Asset");

    NSMutableDictionary* results = [NSMutableDictionary dictionaryWithCapacity:uuids.count];

    [assets enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        // id url = [asset performSelector:@selector(mainFileURL)];
        [asset performSelector:@selector(fetchPropertySetsIfNeeded)];
        
        NSMutableDictionary* adjustments = [NSMutableDictionary dictionary];
        results[[uuids[idx] UUIDString]] = adjustments;

        NSDictionary *metadata = [asset performSelector:@selector(adjustmentsDebugMetadata)];
        if (metadata == nil) {
            return;
        }
        id composition = metadata[@"composition"];
        if (composition == nil) {
            return;
        }
        [[composition contents] enumerateKeysAndObjectsUsingBlock:^(NSString *key, id adjustment, BOOL *stop) {
            adjustments[key] = [adjustment settings];
        }];

        // To dump the full schema for all the adjustments
        //NSError* err;
        //NSData* json = [NSJSONSerialization dataWithJSONObject:resolveSchema(composition) options:NSJSONWritingPrettyPrinted|NSJSONWritingSortedKeys error:&err];
        //dump([[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding]);
    }];
    
    return [results copy];
}

@end

// TODO: Align with json-schema.org?
NSDictionary* resolveSchema(id composition) {
    NSMutableDictionary *schema = [NSMutableDictionary dictionary];

    id compSchema = [composition performSelector:@selector(schema)];
    for (NSString *key in [compSchema contents]) {
        id adjSchema = ((id (*)(id, SEL, id))objc_msgSend)(compSchema, @selector(modelForProperty:), key);
        if (![adjSchema respondsToSelector:@selector(settings)]) {
            continue; // NUSourceSchema
        }

        NSMutableDictionary *settings = [NSMutableDictionary dictionary];
        for (NSString *skey in [adjSchema settings]) {
            settings[skey] = resolveSetting([adjSchema settings][skey]);
        }
        schema[key] = [settings copy];
    }
    
    return schema;
}

NSDictionary* resolveSetting(id setting) {
    NSString *type = [setting className];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if ([[setting attributes] count] > 0) {
        dict[@"attributes"] = [setting attributes];
    }

    if ([@"NUBoolSetting" isEqualToString:type]) {
        dict[@"type"] = @"bool";

    } else if ([@"NUNumberSetting" isEqualToString:type]) {
        dict[@"type"] = @"number";
        dict[@"min"] = [setting performSelector:@selector(minimumValue)];
        dict[@"max"] = [setting performSelector:@selector(maximumValue)];

    } else if ([@"NUEnumSetting" isEqualToString:type]) {
        dict[@"type"] = @"enum";
        dict[@"values"] = [setting values];

    } else if ([@"NUOpaqueSetting" isEqualToString:type]) {
        dict[@"type"] = @"opaque";

    } else if ([@"NUArraySetting" isEqualToString:type]) {
        dict[@"type"] = @"array";
        dict[@"content"] = resolveSetting([setting performSelector:@selector(content)]);

    } else if ([@"NUCompoundSetting" isEqualToString:type]) {
        dict[@"type"] = @"array";
        NSDictionary *props = [setting properties];
        NSMutableDictionary *propDict = [NSMutableDictionary dictionary];
        for (NSString *key in props) {
            propDict[key] = resolveSetting(props[key]);
        }
        dict[@"properties"] = propDict;

    } else {
        NSLog(@"unknown setting class: %@", type);
    }
    
    return [dict copy];
}

#pragma clang diagnostic pop

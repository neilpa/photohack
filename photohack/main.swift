import Foundation

import Photos

if CommandLine.arguments.count < 3 {
    print("usage: photoproxy <*.photoslibrary> <cmd> [<arg>...]")
    print("\t<cmd> is one of `adjustments|jpegs`")
    exit(1)
}

// Embedding the Info.plist isn't sufficient to access the photos library and will still crash with the
// following message:
//
//  photohack[18242:3469015] [access] This app has crashed because it attempted to access privacy-sensitive
//  data without a usage description.  The app's Info.plist must contain an NSPhotoLibraryUsageDescription
//  key with a string value explaining to the user how the app uses this data.
//
// Extracting and writing alongside the executable seems to work and avoids having to copy an extra file.
// TODO: This may cause issues if not placed in a user-writeable location.
do {
    let b = Bundle.main
    let plist = CFBundleCopyInfoDictionaryForURL(b.executableURL! as CFURL) as NSDictionary
    let url = URL.init(fileURLWithPath: "Info.plist", relativeTo: b.resourceURL)
    try plist.write(to: url)
} catch {
    print("Failed to extract plist \(error)")
    exit(2)
}

let sem = DispatchSemaphore(value: 0);
PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus) in
    switch status {
    case .authorized:
        sem.signal();
    default:
        print("Need photo library access");
        exit(2)
    }
})
sem.wait();


let dbPath = CommandLine.arguments[1]
let proxy = PhotoProxy.fromPath(dbPath)
if proxy == nil {
    print("Failed to load photos library: \(dbPath)")
    exit(2)
}

let cmd = CommandLine.arguments[2]
switch cmd {

case "adjustments": // <UUID>...
    let uuids = CommandLine.arguments.dropFirst(3).map { UUID(uuidString: $0)! }
    
    let adjustments = proxy!.fetchAdjustments(uuids)
    let json = try JSONSerialization.data(withJSONObject: adjustments!, options: .prettyPrinted)
    print(String(data: json, encoding: .utf8)!)

case "jpegs": // <DIR> <UUID>...
    let dir = CommandLine.arguments[3];
    let uuids = CommandLine.arguments.dropFirst(4).map { UUID(uuidString: $0)! }
    proxy!.exportJPEGs(uuids, toDir: dir)

default:
    print("Invalid command: \(cmd)")
}

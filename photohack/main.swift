import Foundation
import Photos

if CommandLine.arguments.count < 3 {
    print("usage: photoproxy [photoslib] [UUID]...")
    exit(1)
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

print(PhotoProxy.entityToClass() as AnyObject)

let proxy = PhotoProxy.fromPath(CommandLine.arguments[1])!
let uuids = CommandLine.arguments.dropFirst(2).map { UUID(uuidString: $0)! };

proxy.dumpAdjustments(uuids)

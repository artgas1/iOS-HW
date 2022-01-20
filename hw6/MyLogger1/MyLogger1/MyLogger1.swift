import Foundation

public struct MyLogger1 {
    public static func log(s: String) {
        print("MyLogger1 from framework \(Date()): \(s)")
    }
}

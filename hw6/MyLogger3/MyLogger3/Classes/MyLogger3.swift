import Foundation

public struct MyLogger3 {
    public static func log(s: String) {
        print("MyLogger3 from pod \(Date()): \(s)")
    }
}


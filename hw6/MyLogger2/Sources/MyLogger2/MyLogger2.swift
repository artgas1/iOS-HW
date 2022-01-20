import Foundation

public struct MyLogger2 {
    public static func log(s: String) {
        print("MyLogger2 from package \(Date()): \(s)")
    }
}

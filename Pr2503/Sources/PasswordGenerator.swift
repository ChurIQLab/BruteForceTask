import Foundation

final class PasswordGenerator {
    static func generatePassword(lenght: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)

        var password = ""
        for _ in 0..<lenght {
            let randomIndex = Int(arc4random_uniform(allowedCharsCount))
            let randomChar = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomIndex)]
            password.append(randomChar)
        }
        return password
    }
}

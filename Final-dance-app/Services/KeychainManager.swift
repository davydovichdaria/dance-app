import UIKit

class KeychainManager {
    
    static func save(password: Data, account: String) throws -> String {
        
        let query: [CFString: Any] = [
            
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        
        print("Saved")
        return "Saved"
    }
    
    static func getPassword(for account: String) throws -> Data? {
        
        let query: [CFString: Any] = [
            
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        
        return result as? Data
    }
}

extension KeychainManager {
    enum KeychainError: Error {
        
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }
}

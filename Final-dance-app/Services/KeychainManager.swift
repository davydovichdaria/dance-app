import UIKit

class KeychainManager {
    
    static func save(password: Data, account: String) throws -> String {
        
        let query: [CFString: Any] = [
            
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: password //для передачи данных сохраняемого элемента
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
        // Attempted read for an item that does not exist.
        case itemNotFound
        
        // Attempted save to override an existing item.
        // Use update instead of save to update existing items
        case duplicateItem
        
        // A read of an item in any format other than Data
        case invalidItemFormat
        
        // Any operation result status than errSecSuccess
        case unexpectedStatus(OSStatus)
    }
}

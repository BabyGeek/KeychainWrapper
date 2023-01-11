//
//  KeychainOperations.swift
//  
//
//  Created by Paul Oggero on 11/01/2023.
//

import Foundation

internal class KeychainOperations: NSObject {
    /// Check we have an existing keychain `item`
    /// - Parameter account: String type with the name of the item to checl
    /// - Throws: `KeychainWrapperError` type that is equal to `.keychainCreatingError` if the keychain could not create
    /// - Returns: Boolean type with the answer of existing item or not
    static func exists(account: String) throws -> Bool {
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: false
        ] as NSDictionary, nil)
        
        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw KeychainWrapperError.keychainCreatingError
        }
    }
    
    /// Add an item to keychain
    /// - Parameters:
    ///   - value: Data type value to add in the keychain
    ///   - account: String type account name for the keychain item
    /// - Throws: `KeychainWrapperError` type that is equal to `.operationError` if the operation failed to add
    internal static func add(value: Data, account: String) throws {
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecReturnData: value
        ] as NSDictionary, nil)
        
        guard status == errSecSuccess else { throw KeychainWrapperError.operationError }
    }
    
    /// Update an item into the keychain
    /// - Parameters:
    ///   - value: Data type value to update in the keychain
    ///   - account: String type account name for the keychain item
    /// - Throws: `KeychainWrapperError` type that is equal to `.operationError` if the operation failed to update
    internal static func update(value: Data, account: String) throws {
        let status = SecItemUpdate([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
        ] as NSDictionary, [
            kSecValueData: value
        ] as NSDictionary)
        
        guard status == errSecSuccess else { throw KeychainWrapperError.operationError }
    }
    
    /// Retrieve an item in the keychain
    /// - Parameter account: String type account name for the keychain item
    /// - Throws: `keychainWrapperError` type that is equal to `.operationError` if the operation failed to retrieve
    /// - Returns: Data if the item found else nil for the data retrieved in keychain
    internal static func retrieve(account: String) throws -> Data? {
        var result: AnyObject?
        
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true
        ] as NSDictionary, &result)
        
        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainWrapperError.keychainCreatingError
        }
    }
    
    /// Delete a single keychain item
    /// - Parameter account: String type for the account name of the keychain item
    /// - Throws: `KeychainWrapperError` type that is equal to `.operationError` if the operation failed to delete
    internal static func delete(account: String) throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service
        ] as NSDictionary)
        
        guard status == errSecSuccess else { throw KeychainWrapperError.operationError }
    }
    
    /// Delete all keychain saved items for the app
    /// - Throws: `KeychainWrapperError` type that is equal to `.operationError` if the operation failed to delete all
    internal static func deleteAll() throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword
        ] as NSDictionary)
        
        guard status == errSecSuccess else { throw KeychainWrapperError.operationError }
    }
}

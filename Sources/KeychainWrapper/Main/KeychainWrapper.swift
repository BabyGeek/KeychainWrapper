//
//  KeychainOperations.swift
//
//
//  Created by Paul Oggero on 11/01/2023.
//
//    MIT License
//
//    Copyright (c) 2023 MrSniikyz
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation

public struct KeychainWrapper {
    /// Store a keychain item
    /// - Parameters:
    ///   - value: Data type to store in the keychain
    ///   - account: String type account name for the keychain item
    public static func set(value: Data, account: String) throws {
        if try KeychainOperations.exists(account: account) {
            try KeychainOperations.update(value: value, account: account)
        } else {
            try KeychainOperations.add(value: value, account: account)
        }
    }
    
    /// Retrieve a keychain in Data type
    /// - Parameter account: String type of the account name to retrieve keychain
    /// - Returns: Data type for the stored item or nil if not found
    public static func get(account: String) throws -> Data? {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.retrieve(account: account)
        } else {
            throw KeychainWrapperError.operationError
        }
    }
    
    
    /// Delete a single keychain item
    /// - Parameter account: String type account name for the keychain item
    public static func delete(account: String) throws {
        if try KeychainOperations.exists(account: account) {
            try KeychainOperations.delete(account: account)
        } else {
            throw KeychainWrapperError.operationError
        }
    }
    
    /// Delete all keychain items
    public static func deleteAll() throws {
        try KeychainOperations.deleteAll()
    }
}

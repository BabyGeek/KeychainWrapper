//
//  KeychainConstans.swift
//  
//
//  Created by Paul Oggero on 11/01/2023.
//

internal let service: String = "SwiftKeychainWrapperSecretService"

public enum KeychainWrapperError: Error {
    case keychainCreatingError, operationError
}


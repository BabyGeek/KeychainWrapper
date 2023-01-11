import XCTest
@testable import KeychainWrapper

final class KeychainWrapperTests: XCTestCase {
    let testKey = "primitiveValueTestKey"
    let testString: String = "testValue"
    
    func testRetrieveEmptyKeychainShouldThrowError() throws {
        do {
            let _ = try KeychainWrapper.get(account: testKey)
        } catch {
            XCTAssertEqual(error as? KeychainWrapperError, .operationError)
        }
    }
    
    func testDeleteEmptyKeychainShouldThrowError() throws {
        do {
            let _ = try KeychainWrapper.delete(account: testKey)
        } catch {
            XCTAssertEqual(error as? KeychainWrapperError, .operationError)
        }
    }
    
    func testSaveString() throws {
        guard let data = testString.data(using: .utf8) else {
            XCTFail("Could not convert string to data using UTF8")
            return
        }
        
        do {
            try KeychainWrapper.set(value: data, account: testKey)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Failed to set value")
        }
    }
    
    func testRetrieveString() throws {
        try testSaveString()
        
        guard let data = try KeychainWrapper.get(account: testKey) else {
            XCTFail("Could not retrieve keychain")
            return
        }
        
        XCTAssertEqual(String(data: data, encoding: .utf8), testString)
    }
    
    func testRetrieveErrorString() throws {
        do {
            let _ = try KeychainWrapper.get(account: testKey)
        } catch {
            XCTAssertEqual(error as? KeychainWrapperError, .operationError)
        }
    }
    
    func testDeleteString() throws {
        try testSaveString()
        
        do {
            try KeychainWrapper.delete(account: testKey)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Failed to delete value")
        }
    }
    
    func testDeleteAll() throws {
        try testSaveString()
        
        do {
            try KeychainWrapper.deleteAll()
            XCTAssertTrue(true)
        } catch {
            XCTFail("Failed to delete all")
        }
    }
}

# SwiftKeychainWrapper
Wrapper for using Keychain in Swift

---

## Installation 

You can install by using the github URL in your SPM

You can also clone the repo into your project and link it to your target dependences

### SPM TUTORIAL TODO

---

## Usage

In this version of the package you can store credentials.

### Import the package where you need it

```Swift
import KeychainWrapper
```

You can then try to get the credential on the concerned account

```Swift
let credentials = try? KeychainWrapper.get(account: "<YOUR_ACCOUNT_KEY>")
```
You can also store new credentials, it will automatically update the values if the account already exists, value must have a `Data` type

```Swift
try KeychainWrapper.set(value: credentialsData, account: "<YOUR_ACCOUNT_KEY>")
```

And finally you can delete the account credentials

```Swift
try KeychainWrapper.delete(account: "<YOUR_ACCOUNT_KEY>")
```

You can also delete all the credentials saved on any account on the device

```Swift
try KeychainWrapper.deleteAll()
```

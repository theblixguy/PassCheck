# PassCheck

## What is Passcheck?

PassCheck is a free app that allows you to check how strong and secure your existing passwords are, by calculating how much time it would take an average computer to crack it.

It also checks if your passwords have been compromised i.e found in a data breach.

If you discover you're using an insecure password, the app allows you to generate a strong and secure password!

### How data breach discovery works:

1. When you input your password, PassCheck calculates its SHA-1 hash.
2. It passes the first 5 digits of the hash to the PwnedPasswords API, which returns a list of hash suffixes with the same first 5 digits (i.e prefix), and the breach count.
3. Passcheck combines each of the suffixes with the prefix and checks if the final hash is identical to the password's hash, warns you if it is.

This way, your entire password (i.e its hash) is never sent, only a small portion of it, which helps keep your password anonymous.

## Compile and run requirements

1. iOS 9+ SDK
2. Swift 4
3. Xcode 9
4. Cocoapods
5. iPhone 4S+ or Simulator

![BarcodeScanner](https://github.com/Marceeelll/SandboxWolf/blob/master/Media/banner.png)

# SandboxWolf

[![CI Status](https://img.shields.io/travis/Marcel/SandboxWolf.svg?style=flat)](https://travis-ci.org/Marcel/SandboxWolf)
[![Version](https://img.shields.io/cocoapods/v/SandboxWolf.svg?style=flat)](https://cocoapods.org/pods/SandboxWolf)
[![License](https://img.shields.io/cocoapods/l/SandboxWolf.svg?style=flat)](https://cocoapods.org/pods/SandboxWolf)
[![Platform](https://img.shields.io/cocoapods/p/SandboxWolf.svg?style=flat)](https://cocoapods.org/pods/SandboxWolf)

## Description

**SandboxWolf** is a simple tool to access your App Sandbox within your application. You can easiyl move/edit/rename files. Also between your AppGroup.

- [x] Move File
- [x] Delete File
- [x] Renaming of files
- [ ] Move Directory
- [ ] Delete Directory
- [ ] Sending and Receiving via AirDrop

## Problem To Solve

When downloading the container via the "Devices and Simulators" menu in Xcode it is only possible to download the container of the sandbox. You cant reach the files stored in the AppGroup with a tool like Open Sim to access e.g. your Core Data database. With SandboxWolf you can move files to a position where you can download them - which helps a lot while debugging.

## Table of Contents

<img src="https://github.com/Marceeelll/SandboxWolf/blob/master/Media/sandboxwolf-icon.png" alt="BarcodeScanner Icon" width="190" height="190" align="right" />

* [Description](#description)
* [Problem To Solve](#ProblemToSolve)
* [Example](#example)
* [Requirements](#requirements)
* [Installation](#installation)
* [Author](#author)
* [Contributing](#contributing)
* [License](#license)

## Example

[Example Video on Vimeo](https://vimeo.com/user108331732/review/421907816/0165ca9d89)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```Swift
let vctrl = SandboxManagerViewController(roots: [
    .sandbox,
    .appGroup(applicationGroupIdentifier: "your-appgroup-id")
])
self.present(vctrl, animated: true)
```

Keep in mind that `SandboxManagerViewController` subclasses the `UINavigationController` and therefore can’t be pushed to another `UINavigationController`.

## Requirements

iOS 13

## Installation

SandboxWolf is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SandboxWolf'
```

## Author

Marcel, hagmann.marcel@yahoo.com

## License

SandboxWolf is available under the MIT license. See the LICENSE file for more info.

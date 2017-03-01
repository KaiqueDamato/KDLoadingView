# KDLoadingView

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![Xcode 8.0+](https://img.shields.io/badge/Xcode-8.0+-blue.svg?style=flat)](https://developer.apple.com/swift/)
[![pod v1.0.0](https://img.shields.io/badge/pod-v1.0.0-blue.svg)](https://cocoapods.org)

A beautiful loading indicator inspired by material design. 🤘🏻

# Demo

![alt tag](http://i.giphy.com/l44QxkFEfyVgnCl0I.gif)

# Usage

There are a few properties you may change:

| Property         | Description                                                      | Type    | Default Value |
|:-----------------|:-----------------------------------------------------------------|:--------|:--------------|
| firstColor       | The initial color of the loading                                 | UIColor | UIColor.black |
| secondColor      | The second color of the loading                                  | UIColor | nil           |
| thirdColor       | The third color of the loading                                   | UIColor | nil           |
| duration         | The duration of the loading animation                            | CGFloat | 3             | 
| lineWidth        | The width of the line                                            | CGFloat | 1             |
| hidesWhenStopped | Indicates if the loading must be hidden when the animation stops | Bool    | false         |

All properties are ***IBInspectable*** so you can just drag and drop a new view, change the class and make all the configurations that you need in the Storyboard.

I wish you a funny and happy coding. 🚀

obs: you can set up to three colors in the loading but feel free to set just one or two if you like. 😄

## Author

Kaique Pantosi D'amato, kaiquedamato@icloud.com. 🤓

## License

KDLoadingView is available under the MIT license. See the [License](https://github.com/KaiqueDamato/KDLoadingView/blob/master/LICENSE) file for more info.

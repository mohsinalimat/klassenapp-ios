# SparrowKit

It is library for projects [SPPermission](https://github.com/IvanVorobei/SPPermission) & [SPStorkController](https://github.com/IvanVorobei/SPStorkController). Also library have many useful extenshions and classes. Some fitures I am describe here

- [Integration](#integration)
- [Extenshions](#extenshions)
    - [UIView](#uiview)
    - [UIViewController](#uiviewcontroller)
    - [UIButton](#uibutton)
    - [UIImageView](#uiimageview)
    - [UILabel](#uilabel)
    - [UITableView](#uitableview)
    - [UIColor](#uicolor)
    - [String](#string)


## Integration
Drop in `Source/Sparrow` folder to your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`

Or via CocoaPods:
```ruby
pod 'SparrowKit'
```

and import library in class:
```swift
import SparrowKit
```

## Extenshions
I am describe some fitures, not all. See classes in `Source/sparrow` for find more information

### UIView

Set paralax for view:
```swift
let view = UIView()
view.setParalax(amount: 10)
```

Set paralax for view:
```swift
let image: UIImage = view.convertToImage()
```

Set deep shadow:
```swift
view.setDeepShadow()
```

```swift
view.removeShadow()
```

Animate corner radius:
```swift
view.addCornerRadiusAnimation(to: 10, duration: 0.3)
```

Max rounding view: 
```swift
view.round()
```

### UIViewController

Wrap controller to navigation controller:
```swift
let controller = UIViewController()
let nav = controller.wrapToNavigationController()
```

Dismiss keyborad now:
```swift
controller.dismissKeyboard()
```

Save image or video to gallery:
```swift
controller.save(image: UIImage())
controller.saveVideo(url: "https://youtu.be/1mDdX7fQRv4")
```

Set navigation title for `small` or `large` style:
```swift
controller.setNavigationTitle("Title", style: .large)
```

Safe area for controller:
```swift
let _ = controller.safeArea.top
let _ = controller.safeArea.bottom
```

Set navigation title color:
```swift
controller.navigationTitleColor = UIColor.black
```

### UIButton

```swift
var button = UIButton()
button.target {
	print("Touch up inside")
}
```

Func `showText` show title animatable in button frame:
```swift
var button = UIButton()
button.showText("Alert")
```

Func `setAnimatableText` set new title for button animatable:
```swift
var button = UIButton()
button.setAnimatableText("New Title")
```

### UIImageView

Func `setNativeStyle` set background and border from apple way style:
```swift
let imageView = UIImageView()
imageView.setNativeStyle()
```

### UILabel

Func `setShadowOffsetForLetters` set shadow for letters:
```swift
let label = UILabel()
label.text = "Text"
label.setShadowOffsetForLetters()
```

### UITableView

```swift
let tableView = UITableView()
let _ = tableView.isEmpty
let _ = tableView.isEmpty(section: 0)
let _ = tableView.lastSection
let _ = tableView.lastSectionWithRows // last not empty section
let _ = tableView.firstSectionWithRows // first not empty section

```

### UIColor

Support HEX for create `UIColor`:
```swift
UIColor.init(hex: "#000000")
```

### String 

```swift
let _ = "ivanvorobei@icloud.com".isEmail
```

```swift
let _ = "ivanvorobei@icloud.com".isLink
```

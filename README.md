UI7Kit
======

UI7Kit is a GUI toolkit which can backport flat-style UIKit from iOS7 to iOS5/iOS6. Additionally, UI7Kit can also be used to patch legacy UIKit to UI7Kit in runtime.

NOTE: This project is not mature yet and is being refined. You may come across some bugs or unexpected behaviors for complex real-world product.

Goal
----
- Import flat-style iOS7 theme to work on iOS5/6 (Except status bar and blur effect).
- Patch the classic UIKit to UI7Kit in runtime. (Renew your legacy app just in a line!)
- 100% UIKit compatibility.

Fundraising and aim for 1.0
---------------------------
- [www.bountysource.com/fundraisers/445-ui7kit-1-0](https://www.bountysource.com/fundraisers/445-ui7kit-1-0)

- Except picker view, all of the UI-prefixed controls with basic options should look like iOS7 things, under iOS6.
- Picker view should be imitated, but as similar as possible.
- Tint color and background color should work just as they would in iOS7.
- Both interface builder and code should work.
- All of Interface builder settings should be read, unless it is technically available.


How to use
----------
Case 1: Dynamic patch (Mostly recommended)

    #import <UI7Kit/UI7Kit.h>
    [UI7Kit patchIfNeeded]; // in main.m, before UIApplicationMain()

Case 2: Partial usage

: Use UI7<class> instead of UI<class>.
: ex) UI7NavigationController, instead of UINavigationController

Case 3: Partial dynamic patch

    #import <UI7Kit/UI7Kit.h>
    [UI7<class> patchIfNeeded]; // ex) [UI7TableView patch];

Example
-------
Example with current code. (0.7.4)

The phones on the left most column of the screenshot are iOS7, and the phones on the middle and right columns are iOS5 or iOS6.

![Current status](https://raw.github.com/youknowone/UI7Kit/master/UI7Kit.png).

- [Quick video of 0.0.16 test app](http://www.youtube.com/watch?v=xVA5MAbUW44)
- [Step by step video of 0.2 - QRQR](http://www.youtube.com/watch?v=M2P1Um20py4)

Contact methods
---------------

- Leave a github issue. [New issue](https://github.com/youknowone/UI7Kit/issues/new).
- Email: Address is in LICENSE or git log.
- IRC: Visit irc://irc.freenode.org/#youknowone for instant message. (You need an IRC client)

How to run test app
-------------------
Download source code

    # Copy and paste this lines
    git clone git://github.com/youknowone/UI7Kit.git
    cd UI7Kit
    pod install
    open UI7Kit.xcworkspace # You should open xcwordspace

If you don't have cocoapods, visit http://www.cocoapods.org or follow steps below:

    # At first, install Commoand Line Tools from XCode->Preferences->Downloads.
    sudo gem install cocoapods # May takes long time
    pod setup # Do not sudo here

Run test app now.

How to update
-------------
Update source code and cocoapods

    git pull # if you edited code, 'git fetch origin && git rebase origin/master'
    pod update
    open UI7Kit.xcworkspace # You should open xcwordspace

If you have any problems with missing methods, `pod update` usually solves the problem.


How to install to my project
----------------------------

If you don't have cocoapods, visit http://www.cocoapods.org or follow steps below:

    # Install Commoand Line Tools in XCode->Preferences->Downloads first.
    sudo gem install cocoapods
    pod setup # Do not sudo here

If you have Podfile, add 'UI7Kit'. Or follow steps below:

    # Copy and paste this lines
    echo "platform :ios, '5.0'" > Podfile
    echo "pod 'UI7Kit'" >> Podfile
    pod install
    open *.xcworkspace

This command will generate or edit `YourProject.xcworkspace`.
Open this instead of your original `YourProject.xcodeproj`.


Apps using UI7Kit
-----------------

- QRQR: [https://itunes.apple.com/app/id444076697](https://itunes.apple.com/app/id444076697)
- MAFOR Marine Forecast Decoder: [https://itunes.apple.com/app/id674865491](https://itunes.apple.com/app/id674865491)
- TouchMusic: [https://itunes.apple.com/app/id677386346](https://itunes.apple.com/app/id677386346)
- Slader: [https://itunes.apple.com/app/id579962583](https://itunes.apple.com/app/id579962583)


How to install one or two components
------------------------------------

Follow the above for installing CocoaPods, but instead make your app Podfile look like this:

    pod 'UI7Kit/UI7Slider'

#### Individual components reference

    pod 'UI7Kit/UI7ActionSheet'
    pod 'UI7Kit/UI7AlertView'
    pod 'UI7Kit/UI7BarButtonItem'
    pod 'UI7Kit/UI7Button'
    pod 'UI7Kit/UI7Color'
    pod 'UI7Kit/UI7Font'
    pod 'UI7Kit/UI7Font'
    pod 'UI7Kit/UI7NavigationBar'
    pod 'UI7Kit/UI7NavigationController'
    pod 'UI7Kit/UI7PickerView'
    pod 'UI7Kit/UI7ProgressView'
    pod 'UI7Kit/UI7SegmentedControl'
    pod 'UI7Kit/UI7Slider'
    pod 'UI7Kit/UI7Stepper'
    pod 'UI7Kit/UI7TabBar'
    pod 'UI7Kit/UI7TabBarController'
    pod 'UI7Kit/UI7TabBarItem'
    pod 'UI7Kit/UI7TableView'
    pod 'UI7Kit/UI7TableViewCell'
    pod 'UI7Kit/UI7TextField'
    pod 'UI7Kit/UI7Toolbar'
    pod 'UI7Kit/UI7View'
    pod 'UI7Kit/UI7ViewController'

#### Special case for Switches (pick one)

    pod 'UI7Kit/UI7Switch/SevenSwitch'  # use SevenSwitch (default)
    pod 'UI7Kit/UI7Switch/KLSwitch'     # use KLSwitch
    pod 'UI7Kit/UI7Switch/MBSwitch'     # use MBSwitch


Do you like this project?
-------------------------

If this project was enjoyable for you to use, or if it was helpful, a tip would be greatly appreciated. Thank you ;)

[![Gittip donate button](http://badgr.co/gittip/youknowone.png)](https://www.gittip.com/youknowone/ "Donate weekly to this project using Gittip")
[![Paypal donate button](http://badgr.co/paypal/donate.png?bg=%23007aff)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=YZGSUCRH3Q478&item_name=UI7Kit%20support "One time donation to this project using Paypal")


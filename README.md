UI7Kit
======

UI7Kit is a GUI toolkit to implement iOS7 look & feel UIKit under iOS5/iOS6. It is also supported that patching UIKit to UI7Kit in runtime.

NOTE: This project is very immature and under progressing. This is not available for real product yet.

Goal
----
- Full-featured copy of UIKit for iOS7 look & feel (Except status bar).
- Patch the classic UIKit to UI7Kit in runtime to reduce code rewriting for legacy codes.
- 100% UIKit compatibility.

How to use
----------
Case 1: Dynamic patch

    #import <UI7Kit/UI7Kit.h>
    UI7KitPatchAll(NO); // in main.m, before UIApplicationMain()

Case 2: Partial usage: Use UI7<class> instead of UI<class>.
ex) UI7NavigationController, instead of UINavigationController

Case 3: Partial patch

    #import <UI7Kit/UI7Kit.h>
    [UI7<class> patch]; // ex) [UI7TableView patch];

Example
-------
![Current status](https://raw.github.com/youknowone/UI7Kit/master/UI7Kit.png).


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


How to install to my project
----------------------------
NOTE: This project is very premature yet.

If you don't have cocoapods, visit http://www.cocoapods.org or follow steps below:

    # Install Commoand Line Tools in XCode->Preferences->Downloads first.
    sudo gem install cocoapods
    pod setup # Do not sudo here

If you have Podfile, add 'UI7Kit'. Or follow steps below:

    # Copy and paste this lines
    echo "platform :ios" > Podfile
    echo "pod 'UI7Kit'" >> Podfile
    pod install
    open *.xcworkspace

This command will generate or edit `YourProject.xcworkspace`.
Open this instead of your original `YourProject.xcodeproj`.

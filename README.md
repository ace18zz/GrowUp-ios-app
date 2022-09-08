
# Grow Up - ios app for couples

My dissertation 2021–22 for the University of Bath as a postgraduate student in computer science.

The aim of this app is to help couples/individuals best understand and change harmful behaviours and habits in their relationships to improve relationship satisfaction/quality through enhanced communication and reward mechanism principles.


## Installation Instructions

you can use Xcode to install Grow Up on your iOS device using just your Apple ID.

All you need to do is:

- Install Xcode
- Download the Grow Up for iOS Source Code or git clone https://github.com/ace18zz/GrowUp-ios-app.git
- Open "Grow Up.xcworkspace" in Xcode
- Go to Xcode's Preferences > Accounts and add your Apple ID
- In Xcode's sidebar select "Grow Up" and go to General > Identity. Append a word at the end of the Bundle Identifier e.g. com.Grow Up.*name* so it's unique. Select your Apple ID in Signing > Team
- Connect your iPad or iPhone using USB and select it in Xcode's Product menu > Destination
- Press CMD+R or Product > Run to install Grow Up (on iPhone 13 pro)
- If you install using a free (non-developer) account, make sure to rebuild Grow Up every 7 days, otherwise, it will quit at launch when your certificate expires
Contact me if you need help.

Also to make sure everything work perfectly, please install Cocoapods as well.

What you need to do :

step 1
```bash
 sudo gem install cocoapods
```
 step 2
```bash
 pod setup --verbose
``` 

If you want to know more, you can visit this website：
https://guides.cocoapods.org/
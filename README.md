# iOS-GuideBlocks

This is a shared open source repository for GuideBlocks that can be used in iOS Apps.
You can use any of these GuideBlocks here in your App in Conjunction with the Contextual iOS SDK and an account at https://dashboard.contextu.al

## Using GuideBlocks

GuideBlocks save developer time by giving engagement components back to your Product Team and not creating jobs on the product roadmap. This allows you to **Code Once, Run Anywhere, Anytime and for Any Users**. and then let your Product Team launch, target, customize the appearance of the widget. When would you do this?

- onboarding and feature announcements
- promotions, offers or inApp marketing
- system announcements
- running different surveys

There are two ways to use GuideBlocks:

### 1. Make use of these public GuideBlocks

0. you have an account on the Contextual Dashboard and you've added the iOS SDK, you've added the **app_key** into your App and tested a simple Guide in your App.
1. using Swift Package Manager add [iOS-GuideBlocks](https://github.com/GuideBlocks-org/iOS-GuideBlocks/blob/confetti/Sources/iOS-GuideBlocks) to your Package Dependencies
2. add `import iOS_GuideBlocks`
3. for the GuideBlock you wish to use, then add `Contextual.sharedInstance().registerGuideBlock(FancyAnnouncementGuide(), forKey: "FancyAnnouncement")`
4. build and run!


### 2. Make your own App elements into private GuideBlocks

Simply wrap your existing code elements into a GuideBlock, even if they are deeply embedded, your product team can launch from the Contextual Dashboard.

See the following examples:

[AppFieldEdit](https://github.com/contextu-al/AirBnB-iOS/tree/main/airbnb-main/airbnb-main/Components/CustomGuideBlocks/AppFieldEdit)

[AdhocRowInsertion](https://github.com/contextu-al/AirBnB-iOS/tree/main/airbnb-main/airbnb-main/Components/CustomGuideBlocks/AdhocRowInsertion)
 

## Contributing Guideblocks to this repo

You can contribute to https://guideblocks.org by wrapping a code element that would be useful for others to use. The process is:

1. Get an account at [https://dashboard.contextu.al](https://dashboard.contextu.al), you will need this to test your new GuideBlock.
2. Clone this repo
3. Create a new branch with your GuideBlock name
4. Add your code: maybe it is yours or maybe it is some public available source on the internet. Isolate the functional elements.
5. [Wrap your code following these instructions](https://github.com/GuideBlocks-org#how-do-i-make-a-guideblock)
6. Test it out with a sample app in and the Contextual Dashboard. Push this sammple app to a public repo or use the [AirBnB Sample](https://github.com/contextu-al/AirBnB-iOS)
7. Create a GuideBlock.yaml in the directory of the each GuideBlock inside the iOS-GuideBlocks repo - see the template below. Be sure to add the sample app repo/branch that you have used into the GuideBlock.yaml 
8. Create a README.md in the root directory to tell users how to use the GuideBlock (mapping parameters and adding to the extensibility section of the Dashboard) 
9. Commit, Push and create a PR.
10. Sit back, relax, have a bubble tea and wait for approval!


### Sample GuideBlock.yaml

```
Title: Confetti
Author: Marc Stroebel
Email: support@contextu.al
TestApp: https://github.com/contextu-al/AirBnB-iOS
TestAppBranch: confetti
Description: Launch confetti to targeted users at any time with this low-code GuideBlock
Acknowledgements: https://github.com/simibac/ConfettiSwiftUI
Screenshot: https://github.com/GuideBlocks-org/iOS-GuideBlocks/blob/main/Sources/iOS-GuideBlocks/Confetti/confetti-guideblock.png 
Video: https://vimeo.com/907653617/7384df8a67
Extensibility: {
  "guideBlockKey": "Confetti"
}
```
 

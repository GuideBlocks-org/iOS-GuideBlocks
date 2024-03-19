## Using Simple Tip GuideBlock

In this example, we show how to make a Simple Tip. It's a simple example to get you started with Contextual Extensibility without needing to hard-code your changes every time you want to update the tip.

1. Create an account at [Contextual Dashboard](https://dashboard.contextu.al/ "Contextual Dashboard").
2. Install the Contextual SDK following the instructions for IOS or Android.
3. Add `import GuideBlocks` usually in your AppDelegate.swift
4. Copy-Paste the instantiation of the Guide Component AFTER the Contextual SDK registration. e.g `Contextual.sharedInstance().registerGuideBlock(SimpleTipGuideController(), forKey: "SimpleTip")`
5. Build your App and Run it on a phone or simulator
6. Go to the Dashboard and create a guide:
 * Use this [video]( https://vimeo.com/863886653#t=0m58s "Another Guide Creation How-to") to see the steps
 * choose a screenshot that you have taken of your app while in Preview Mode and 
 * pick one of the “Standard” Contextual Announcement Templates.
 * Preview the Simple Tip on your Phone - it should look similar to the template
7. Now go to the Extensibility section in the sidebar and paste in the JSON as in the GuideBlock.yaml file.
 * Match the name in the JSON to the name of your wrapper in the code

 <img src="SimpleTip.png" alt="Adding your Extra JSON" width="200"/>

8. If you are still in Preview Mode, then you should see the standard Tip will change to Simple Tip
9. Change the Title and Content and buttons. Play around with it and see the results.
10. Save the guide and show to your Product Team, once you release this version of the App they can launch Simple Tip to whoever they want, whenever they want.


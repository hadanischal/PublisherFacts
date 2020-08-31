# PublisherFacts
## Requirements:
* iOS 12.2+
* Xcode 11.6
* Swift 5.2

## Objective:
This proof of concept app which consumes a REST service and displays photos with headings and descriptions to demonstrate some aspect of clean architecture using  MVVM pattern, dependency injection, **SOLID principles** , loose coupling, **unit testing** and some of the best practices used in modern iOS programming using `Swift`.

## Specification:
* This project was intended as proof of concept app which consumes a REST service and displays photos with headings and descriptions. 
* The demo uses the [Feeds API](https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json) which returns information in a JSON format.
* Implemented Unit test for business logic.
* The feed contains a title and a list of rows.
* Use Collection View to display the content.
* CollectionViewCell size is dynamic and which should vary based on the image size.
* Restrict the image to go to outside of the device width if image is having a larger width then your device.
* Loads the images lazily and Don’t download them all at once, but only as needed.
* Refresh function
* Each image having title at the bottom of the image.
* For iphone & iPad (portrait)- When click on collection view image, navigate to detail page having title on navigation bar with image as banner and description at the bottom of the banner image.
* For iphone & iPad (landscape)- When click on collection view image, navigate to detail page having title on navigation bar with image on the left hand side of the screen and description at the right hand side of the screen (ratio size of the screen between image and description is 30:70).
* Note - Should not block UI when loading the data from the json feed.


## Installation

- Xcode **11.6**(required)
- Clean `/DerivedData` folder if any
- Run the pod install `pod install`
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`SwiftLint`** - [realm/SwiftLint](https://github.com/realm/SwiftLint) A tool to enforce Swift style and conventions. 

## Technical notes:
- MVVM - My preferred architecture.
    - MVVM stands for “Model View ViewModel”
    - It’s a software architecture often used by Apple developers to replace MVC. Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
- Models hold application data. They’re usually structs or simple classes.
- Views display visual elements and controls on the screen. They’re typically - subclasses of UIView.
- View models transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

![Alt text](/README/MVVM.jpeg?raw=true)

## Screenshot:
![Screen Shot 1](/README/screenshot1.png?raw=true)


 #### App Demo


 ![](/README/demo.gif "")

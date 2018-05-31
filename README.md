iOS Proficiency Exercise (Banking)
Overview
The purpose of this exercise is to assess candidate developer’s iOS coding knowledge and style. The exercise involves build a “proof of concept” app which consumes a REST service and displays photos with headings and descriptions. The exercise will be evaluated on coding style, understanding of programming concepts, choice of techniques, and also by the developer’s process, as indicated by the trail of git commits.
       
Specification
Create a universal iOS app which:
1. Ingests a json feed from   https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json  
2. You can use a third party json parser to parse this if desired.  
3. The feed contains a title and a list of rows  
4. Use Collection View to display the content. Making sure the CollectionViewCell size is dynamic and which should vary based on the image size.
5. Restrict the image to go to outside of the device width if image is having a larger width then your device.
6. Loads the images lazily  
7. Don’t download them all at once, but only as needed
8. Refresh function
9. Each image having title at the bottom of the image.
10. For iphone & iPad (portrait)- When click on collection view image, navigate to detail page having title on navigation bar with image as banner and description at the bottom of the banner image.
11. For iphone & iPad (landscape)- When click on collection view image, navigate to detail page having title on navigation bar with image on the left hand side of the screen and description at the right hand side of the screen (ratio size of the screen between image and description is 30:70).
     Note - Should not block UI when loading the data from the json feed.
    

Guidelines
1. Use Git to manage the source code. A clear Git history showing your process is required.  
2. Scrolling the collection view should be smooth, even as images are downloading and getting added to the cells.  
3. App should support both iPhone and iPad (in both orientations).  
4. If threading is considered - Do no spawn threads manually by using performSelectorOnBackgroundThread, use GCD queues instead.
5. Use auto layout while designing the screen.
6. Comment your code where necessary.  
7. Try to polish your code and the apps functionality as much as possible.  
8. Commit your changes to git in small chunks with meaningful comments  
9. Do not use any singletons in your submission  
     
Additional Requirements
1. Supports all iOS versions from the latest back to iOS8
      

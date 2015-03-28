# ASCIImage-Xojo
Draw on Graphics / Create Image with ASCII art

##Useful links

* ASCIImage reference site: [asciimage.org](http://asciimage.org)
* Original blog post presenting ASCIImage: [Replacing Photoshop with NSString](http://cocoamine.net/blog/2015/03/20/replacing-photoshop-with-nsstring/)
* Original GitHub project in ObjectiveC: [ASCIImage](http://github.com/cparnot/ASCIImage)
* Slides from the presentation of ASCIImage at NSConference 7: [ASCCImage slides and editor](http://cocoamine.net/blog/2015/03/21/asciimage-slides-and-editor/)
* ASCIImage Super Studio: [source on Github](https://github.com/mz2/ASCIImage-Super-Studio)
* For ASCII art lovers: [MonoDraw](http://monodraw.helftone.com) (not affiliated with ASCIImage; just an awesome app that I like)

## Documentation

Adapted to Xojo from the following file [README.md](https://github.com/cparnot/ASCIImage/blob/master/README.md)

#### Characters and Pixels

An image is defined by an array of strings, where each string represents a row. Here is an example:

    Dim str() As String = Array(_
    "· · · 1 2 · · · · · ",_
    "· · · A # # · · · · ",_
    "· · · · # # # · · · ",_
    "· · · · · # # # · · ",_
    "· · · · · · 9 # 3 · ",_
    "· · · · · · 8 # 4 · ",_
    "· · · · · # # # · · ",_
    "· · · · # # # · · · ",_
    "· · · 7 # # · · · · ",_
    "· · · 6 5 · · · · · ")

In this documentation, I'll just represent it as follows:

    · · · 1 2 · · · · · 
    · · · A # # · · · · 
    · · · · # # # · · · 
    · · · · · # # # · · 
    · · · · · · 9 # 3 · 
    · · · · · · 8 # 4 · 
    · · · · · # # # · · 
    · · · · # # # · · · 
    · · · 7 # # · · · · 
    · · · 6 5 · · · · · 
  


Whitespace is ignored. The 2 representations below are thus equivalent. It should be clear why using extra whitespace is recommended: it really helps make the content appear at the right aspect ratio.

    · · · 1 2 · · · · ·          ···12·····
    · · · A # # · · · ·          ···A##····
    · · · · # # # · · ·          ····###···
    · · · · · # # # · ·          ·····###··
    · · · · · · 9 # 3 ·          ······9#3·
    · · · · · · 8 # 4 ·          ······8#4·
    · · · · · # # # · ·          ·····###··
    · · · · # # # · · ·          ····###···
    · · · 7 # # · · · ·          ···7##····
    · · · 6 5 · · · · ·          ···65·····

Each row should have the same number of non-whitespace character or else you get nothing but a mysterious console log.  These representations are invalid:

    ! ! I N V A L I D !             N O # G O O D ! 
    · ····1 2 · · · · ·               1 2           
    · · · A # # · · · ·               A # #         
    · · · · # # # · · ·                 # # #       
    · · · · · # # # · ·                   # # #     
    · · · · · · 9 # 3 ·                     9 # 3   
    · · · · · · 8 # 4 ·                     8 # 4   
    · · · · · # # # · ·                   # # #     
    · · · · # # # · · ·                 # # #       
    · · · 7 # # · · · ·               7 # #         
    · · · 6 5 · · · · ·               6 5           


#### Special Characters

While all non-whitespace characters count as part of the pixel grid, most characters are passive. Only the following characters are considered as part of shapes:

    1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P
    Q R S T U V W X Y Z a b c d e f g h i j k l m n p
    q r s t u v w x y z

Note that the O (zero) and o (lowercase letter O) are ignored. The current implementation does not ignore the uppercase letter O. Any of those 3 things could be considered a bug, but that's just the way I thought it would be best. Maybe I'll regret it. Probably not.

All the other characters are ignored when it comes time to extract shapes from the grid of characters.

All the following representations are thus equivalent. The '#' signs in those examples are very useful as a guide for the eyes, and I use them all the time (@ works well too). But they can also be used for evil obfuscation! Bad!


    · 1 2 · · · · ·        · 1 2 · · · · ·         · 1 2 · · · · ·        # 1 2 # # # # # 
    · A # # · · · ·        · A @ @ · · · ·         · A · · · · · ·        # A # # # # # # 
    · · # # # · · ·        · · @ @ @ · · ·         · · · · · · · ·        # # # # # # # # 
    · · · # # # · ·        · · · @ @ @ · ·         · · · · · · · ·        # # # # # # # # 
    · · · · 9 # 3 ·        · · · · 9 @ 3 ·         · · · · 9 · 3 ·        # # # # 9 # 3 # 
    · · · · 8 # 4 ·        · · · · 8 @ 4 ·         · · · · 8 · 4 ·        # # # # 8 # 4 # 
    · · · # # # · ·        · · · @ @ @ · ·         · · · · · · · ·        # # # # # # # # 
    · · # # # · · ·        · · @ @ @ · · ·         · · · · · · · ·        # # # # # # # # 
    · 7 # # · · · ·        · 7 @ @ · · · ·         · 7 · · · · · ·        # 7 # # # # # # 
    · 6 5 · · · · ·        · 6 5 · · · · ·         · 6 5 · · · · ·        # 6 5 # # # # # 


#### Bezier Paths

Before being rendered into an Image, the ASCII grid is transformed into a series of Object2D. The next sections describe the different types of Bezier paths that may be created.

#### Polygons

The simplest use of the above characters is to draw polygons using the famous 'connect-the-numbers' technique. Each polygon is defined by a series of sequential characters, and a new polygon is started as soon as you skip a character in the above list. So the first polygon could be defined by the series '123456', the next shape with '89ABCDEF', the next with 'HIJKLMNOP', etc. For polygons, each character can only be used once (or never). If you run out of characters, you are probably abusing ASCIImage!

Here is an example with 3 polygons, defined with the series [1,2,3,4,5,6,7,8,9,A], then [C,D,E] and finally [G,H,I,J,K,L]. Note that the characters B and F were skipped to separate the three polygons. The second example next to it is equivalent, but the last polygon uses the series [a,b,c,d,e,f] for no good reason (but also no bad reason).

    · · · · · · · · C · · E         · · · · · · · · C · · E 
    · · · 1 2 · · · · · · ·         · · · 1 2 · · · · · · · 
    · · · A · · · · · · · ·         · · · A · · · · · · · · 
    · · · · · · · · · · · D         · · · · · · · · · · · D 
    G · H · · · · · · · · ·         a · b · · · · · · · · · 
    · · · · · · 9 · 3 · · ·         · · · · · · 9 · 3 · · · 
    · · I J · · 8 · 4 · · ·         · · c d · · 8 · 4 · · · 
    L · · K · · · · · · · ·         f · · e · · · · · · · · 
    · · · · · · · · · · · ·         · · · · · · · · · · · · 
    · · · 7 · · · · · · · ·         · · · 7 · · · · · · · · 
    · · · 6 5 · · · · · · ·         · · · 6 5 · · · · · · · 
    · · · · · · · · · · · ·         · · · · · · · · · · · · 

#### Single points

When a polygon is composed of just 1 character, it is made into a square filling out the corresponding point. The following representation contains 5 separate points.

    · · 1 · · · · · · 5 · T 
    · · · · 3 · · · · · · · 
    · · · · · · · · · · 7 · 
    · · · · · · · · · · · · 

#### Lines

When a character is used exactly twice, the corresponding shape will be a line joining the two points (center to center, with square ends, which will fill the pixels exactly when using a 1-point width for drawing). Since such characters are used more than once, they cannot be part of a polygon, and there is no need to skip characters between a line and any other shape. Here is an example with 3 lines and a triangle. Note how we don't skip any character (but we could).

    · · 1 # # # # # # 1 6 · 
    · · · · · · · · · · # · 
    · · · · 2 · 3 · · · # · 
    · · · · · 4 · · · · # · 
    · · · · · · · · · · # · 
    · · 5 # # # # # # 5 6 · 


#### Ellipses

When a character is used three or more time, the corresponding shape will be an ellipse defined by the largest rectangles that include all the points. All the following representations will produce the same 11-point-diameter circle:

    · · · 1 1 1 1 1 · · ·      · · · · · 1 · · · · ·      · · · · · 1 · · · · ·    
    · · 1 · · · · · 1 · ·      · · · · · · · · · · ·      · · · · · · · · · · ·    
    · 1 · · · · · · · 1 ·      · · · · · · · · · · ·      · · · · · · · · · · ·    
    1 · · · · · · · · · 1      · · · · · · · · · · ·      · · · · · · · · · · ·    
    1 · · · · · · · · · 1      · · · · · · · · · · ·      · · · · · · · · · · ·    
    1 · · · · · · · · · 1      1 · · · · · · · · · 1      · · · · · · · · · · ·    
    1 · · · · · · · · · 1      · · · · · · · · · · ·      · · · · · · · · · · ·    
    1 · · · · · · · · · 1      · · · · · · · · · · ·      · · · · · · · · · · ·    
    · 1 · · · · · · · 1 ·      · · · · · · · · · · ·      · · · · · · · · · · ·    
    · · 1 · · · · · 1 · ·      · · · · · · · · · · ·      · · · · · · · · · · ·    
    · · · 1 1 1 1 1 · · ·      · · · · · 1 · · · · ·      1 · · · · · · · · · 1    



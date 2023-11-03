# Ignis

![IMG_1997](https://github.com/heidischultz/Ignis/assets/99668295/a3d18457-84ab-47a7-a0c1-1661f5c432f8)



Ignis is a mobile app designed to assist people detect and track wildfires while promoting fire safety. By acting as a centralized hub, Ignis notifies users of potential wildfire threats to their home. Additionally, Ignis offers a fire plan feature that provides a secure space for families and loved ones to collaborate on fire safety planning. Ignis uses a physics-driven algorithm that issues a percentage chance on whether an address will be impacted, helping users make informed decisions quickly. Ignis provides customized information on fire risks and safety measures based on the user's location.


## Fire Prediction Algorithm 
*(Ignis1/Erra/Views/Components /PredictionAlgorithm .swift)*

- isWithinCircle (function) iterates through each fire's latitude and longitude in the old fire dataset (2 hours old) and draws a circle with a 2mi radius around it.
 - Then the same function searches for any coordinate in the new fire dataset that falls within the defined 2mi interaction threshold
 - If there is another fire within the interaction threshold, the distance between the two fires is returned. If there is no change in the movement of a fire, 0.0 is returned
 
 - Next, a line is "drawn" from the old fire location to the new fire location. This line then continues past the new fire location by 50 miles
 - A cone is then made with a radius of 20 mi and height of 50 mi
 - If the address falls within that cone, then a percentage risk is assigned based of how far the address is from the tip of the cone.
 
 
 **DISCLAIMER**
 I have been constantly tweaking my code and adding new features, so as of now, the calculation of percentage risk has some bugs. However, I plan on continuing to improve/fix my code
 


## Built With

* [Swift/SwiftUI](https://www.swift.org/) - Backend/Frontend Language
* [Python](https://www.python.org/) - Backend language
* [NASA FIRMS API](https://firms.modaps.eosdis.nasa.gov/api/) - Wildfire data source 
* [MapKit](https://developer.apple.com/documentation/mapkit/) - Map Framework
* [Firebase Firestore](https://firebase.google.com/docs/firestore) - Cloud database used for storing user info/authentication
* [Firebase Realtime](https://firebase.google.com/docs/database) - Cloud realtime database used for storing API data
* [Google Cloud Functions](https://cloud.google.com/functions#) - Cloud functions used for deploying/scheduling reoccurring API call  


## Contributors 

Kush Mirchandani - UI and geocoding help

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc








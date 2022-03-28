### How to change map providers.

##### free available map providers
http://www.strasis.com/documentation/limelight-xe/reference/tile-map-servers 

you can add most of maps here. but i personaly like for [ArcGIS Online Maps] and [Carto Base Maps]

you just need to copy one of URL and paste it to ***urlTemplate*** of lib\maps\map_and_navigation.dart

if you use Carto base maps. remember to remove **'{s}'** of the URL

##### Map box

-  Sign in to https://studio.mapbox.com/ and open mapbox studio

-  click on **create a map in studuio** button

   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/1.png" alt="alt text" width="600"/>

-  click on **new style** button
 
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/create%20new%20mbs.png" alt="alt text" width="600"/>

-  choose a template **and click on **cutomize** button
  
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/create%20new%20mbs%20customize%20btn.png" alt="alt text" width="600"/>

-  cutomize and change colors as you wish and **publish** the map
  
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/edit.png" alt="alt text" width="200"/>

-  click on **share** button 
 
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/sharebtn.png" alt="alt text" width="600"/>

-  select **third party** and **carto**
  
-  <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/thirdparty.png" alt="alt text" width="600"/>
  
-  finally copy integration url and past to urlTemplate of lib\maps\map_and_navigation.dart 


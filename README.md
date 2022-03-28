<img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/Screenshot_2022-03-28-12-24-08-578_com.example.speedo_meter.jpg" alt="alt text" width="600"/>

<img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/Screenshot_2022-03-28-20-06-30-341_com.example.speedo_meter.jpg" alt="alt text" width="600"/>



### How to change map providers.

##### free available map providers
http://www.strasis.com/documentation/limelight-xe/reference/tile-map-servers 

you can add most of the maps here. but i personally like for [ArcGIS Online Maps] and [Carto Base Maps]

you just need to copy one of the URL and paste it to ***urlTemplate*** of lib\maps\map_and_navigation.dart

<img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/map%20providers%20url.png" alt="alt text" width="600"/>

if you use Carto base maps. remember to remove the **'{s}'** of the URL



##### Map box

-  Sign in to https://studio.mapbox.com/ and open mapbox studio

-  click on the **create a map in studuio** button

   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/1.png" alt="alt text" width="600"/>

-  click on the **new style** button
 
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/create%20new%20mbs.png" alt="alt text" width="600"/>

-  choose a template **and click on the **cutomize** button
  
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/create%20new%20mbs%20customize%20btn.png" alt="alt text" width="600"/>

-  cutomize and change colors as you wish and **publish** the map
  
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/edit.png" alt="alt text" width="200"/>

-  click on the **share** button 
 
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/sharebtn.png" alt="alt text" width="600"/>

-  select **third party** and **carto**
  
-  <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/thirdparty.png" alt="alt text" width="600"/>
  
-  finally copy the integration url and past to the urlTemplate of lib\maps\map_and_navigation.dart 
   <img src="https://raw.githubusercontent.com/CodeFoxLk/flutter_car_dashboard/main/images/map%20providers%20url.png" alt="alt text" width="600"/>


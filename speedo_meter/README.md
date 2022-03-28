### How to change map providers.

##### free available map providers
	http://www.strasis.com/documentation/limelight-xe/reference/tile-map-servers 

you can add most of maps here. but i personaly like for [ArcGIS Online Maps] and [Carto Base Maps]

you just need to copy one of URL and paste it to ***urlTemplate*** of lib\maps\map_and_navigation.dart


##### Map box

-  Sign in to https://studio.mapbox.com/ and open mapbox studio
-  click on **create a map in studuio** button
-  click on **new style** button
- ** choose a template **and click on **cutomize** button
- cutomize and change colors as you wish and **publish** map
-  click on **share** button
-  select **third party** and **carto**
-  finally copy integration url and past to urlTemplate of lib\maps\map_and_navigation.dart 


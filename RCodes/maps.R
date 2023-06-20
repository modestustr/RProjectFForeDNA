# Load Libraries
library(leaflet)
library(htmltools)

# Set Icons or Bay and Gulf
bay<- "outputs/bay.png"
gulf<-"outputs/gulf.png"
gulfIcon<-icons(iconUrl = gulf, iconWidth = 25)
bayIcon<-icons(iconUrl = bay, iconWidth = 25)
# Create the leaflet maps
map1 <- leaflet() %>%
  addTiles() %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon ) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318,lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=27.28513, lng=-97.66367, popup="Riviera Fishing Pier, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 


map2 <- leaflet() %>%
  addTiles() %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=27.28513, lng=-97.66367, popup="Riviera Fishing Pier, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 


map3 <- leaflet() %>%
  addTiles() %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=27.28513, lng=-97.66367, popup="Riviera Fishing Pier, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 


map4 <- leaflet() %>%
  addTiles() %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 


myCss <- "
div.divTableForMap {
  border: 1px solid #1C6EA4;
  background-color: #EEEEEE;
  width: 100%;
  text-align: left;
  border-collapse: collapse;
}
.divTable.divTableForMap .divTableCell, .divTable.divTableForMap .divTableHead {
  padding: 3px 2px;
}
.divTable.divTableForMap .divTableBody .divTableCell {
  font-size: 14px;
  font-weight: bold;
}
.divTable.divTableForMap .divTableRow:nth-child(even) {
  background: #D0E4F5;
}
.divTable.divTableForMap .divTableCell:nth-child(even) {
  background: #D0E4F5;
}
.divTable.divTableForMap .divTableHeading {
  background: #1C6EA4;
  background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
  background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
  background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
  border-bottom: 2px solid #444444;
}
.divTable.divTableForMap .divTableHeading .divTableHead {
  font-size: 15px;
  font-weight: bold;
  color: #FFFFFF;
  text-align: center;
  border-left: 2px solid #D0E4F5;
}
.divTable.divTableForMap .divTableHeading .divTableHead:first-child {
  border-left: none;
}

.divTableForMap .tableFootStyle {
  font-size: 14px;
}
.divTableForMap .tableFootStyle .links {
  text-align: right;
}
.divTableForMap .tableFootStyle .links a {
  display: inline-block;
  background: #1C6EA4;
  color: #FFFFFF;
  padding: 2px 8px;
  border-radius: 5px;
}
.divTableForMap.outerTableFooter {
  border-top: none;
}
.divTableForMap.outerTableFooter .tableFootStyle {
  padding: 3px 5px; 
}
.divTable { display: table; }
.divTableRow { display: table-row; }
.divTableHeading { display: table-header-group; }
.divTableCell, .divTableHead { display: table-cell; }
.divTableFoot { display: table-footer-group; }
.divTableBody { display: table-row-group; }
"

myTable <- tagList(div(
  class = "divTable divTableForMap",
  div(class = "divTableHeading",
      div(class = "divTableRow",
          div(class = "divTableHead", "head1")
      )
  ),
  div(class = "divTableBody",
      div(class = "divTableRow",
          div(class = "divTableCell", "cell1_1")
      )
  )
)
)

myTable
browsable(myTable)

myHtml <- HTML(
  tagList(
    tags$style(HTML(myCss)),
    myTable
  )
)


# Combine the maps
combined_map1 <- tagList(
  div(
    style = "float: right; width: 100%;",
    h2("Map Set 1", style="font-style: italic; font-size: 14pt")
  ),
  div(
    style = "float: left; width: 50%;",map1,
    h2("Halodule wrightii", style="font-style: italic; font-size: 14pt")
  ),
 
  div(
    style = "float: right; width: 50%;", map2,
    h2("Halophila engelmannii", style="font-style: italic; font-size: 14pt")
  )
)
combined_map2 <- tagList(
  div(
    style = "float: right; width: 100%;",
    h2("Map Set 2", style="font-style: italic; font-size: 14pt")
  ),
   div(
    style = "float: right; width: 50%;",
    map3,
    h2("Ruppia maritima", style="font-style: italic; font-size: 14pt")
  ),
  div(
    style = "float: right; width: 50%;",
    map4,
    h2("Thalassia testudinum", style="font-style: italic; font-size: 14pt" )
  ),
  div(
    style = "float:left; width: 100%;",
      h2("B: Bay, G: Gulf", style="font-style: bold; font-size: 10pt; text-align:right" )
  )
)

# Display the combined map
browsable(combined_map1)
browsable(combined_map2)




#Halodule wrightii
leaflet() %>%
  addTiles()  %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=27.28513, lng=-97.66367, popup="Riviera Fishing Pier, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 


#Halophila engelmannii
leaflet() %>%
  addTiles()  %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=27.28513, lng=-97.66367, popup="Riviera Fishing Pier, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 

 
#Ruppia maritima
leaflet() %>%
  addTiles()  %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=27.28513, lng=-97.66367, popup="Riviera Fishing Pier, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 


# Thalassia testudinum
leaflet() %>%
  addTiles()  %>%
  addMarkers(lat=26.24075, lng=-97.18523, popup="End of the Road, South Padre Island ",icon = gulfIcon) %>%
  addMarkers(lat=26.07782, lng=-97.1703, popup="Pier 19, South Padre Island ",icon = bayIcon) %>%
  addMarkers(lat=29.98792, lng=-93.8456, popup="Lower Neches Wildlife Management Area ",icon = bayIcon) %>%
  addMarkers(lat=29.66663, lng=-94.07528, popup="McFaddin National Wildlife Refuge ",icon = gulfIcon) %>%
  addMarkers(lat=29.33783, lng=-94.77792, popup="Seawolf Park, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=29.52882, lng=-94.77605, popup="Candy Abshier Wildlife Management Area, Smith Point ",icon = bayIcon) %>%
  addMarkers(lat=28.935318, lng=-95.290632, popup="Surfside Jetty and Beach, Galveston ",icon = gulfIcon) %>%
  addMarkers(lat=28.59398, lng=-95.97748, popup="Red Drum Pier, Matagorda ",icon = gulfIcon) %>%
  addMarkers(lat=28.40818, lng=-96.7168, popup="Beach Front Pavilion, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=28.69922, lng=-96.21773, popup="Palacios Bay Pier, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.66795, lng=-97.39105, popup="Mustang Island State Park ",icon = gulfIcon) %>%
  addMarkers(lat=28.44477, lng=-96.40257, popup="Port O'Connor Jetty, Matagorda ",icon = bayIcon) %>%
  addMarkers(lat=27.82772, lng=-97.05312, popup="Port Aransas Jetty ",icon = gulfIcon) %>%
  addMarkers(lat=27.42455, lng=-97.29755, popup="Malaquite Campground ",icon = gulfIcon) %>%
  addMarkers(lat=27.81538, lng=-97.39105, popup="Lexington Pier, Corpus Christi Bay ",icon = bayIcon) %>%
  addMarkers(lat=26.54765, lng=-97.41782, popup="Port Mansfield, Laguna Madre ",icon = bayIcon) %>%
  addMarkers(lat=28.12527, lng=-96.97965, popup="Goose Island State Park ",icon = bayIcon) 

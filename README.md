# Architecture
Architecture emplyed in this test is the classical 3 layers (View, Domain and Data). 

## View Layer

## Domain Layer

## Data Layer
Data layer is responsible for fetching data from any source (Network, DDBB, Files, UserDefaults, Keychain, ...), outside of this layer, nobody know the origin of data. This layer is implemented in XCode project folder called __DataLayer__
##### APIService
Inside datalayer exists a bunch of components dedicated to handle data depending on its source, for instance, APIService is responsible for fetching data from a REST service you can find its implementation under __DataLayer/APIService__ XCode project folder. 




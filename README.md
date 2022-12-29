# App Overview

The app consists in list of Marvell characteres and its associated detail view, presented once user taps on the character:

| List view      | Detail view |
| ----------- | ----------- |
| ![image](https://user-images.githubusercontent.com/4647295/209925551-34a711f9-98cf-48f7-9929-537ca3cb9e23.png)      | ![image](https://user-images.githubusercontent.com/4647295/209933050-257b1e4b-1383-4ab8-ab6b-10ea781ab7aa.png)     |


# Architecture
_An architecture is a way of oranizing code, in a way that would be easier to understand and create new functionality by a team_

Architecture emplyed in this app is the classical 3 layers (View, Domain and Data). 

## View Layer
View layer is where are implemented the app UI and its presentation logic. Each scene (screen), under __ViewLayer/Contollers__, is implemented by a stack of three components: View, Presenter, Interactor and Coordinator.

![image](https://user-images.githubusercontent.com/4647295/209935891-e61bc712-ab3d-4191-9d18-712a5248464d.png)

**View**. This is the UI implementation of the screen. Only presents data and collectc events from user. Depending on the view complexity, it could be organized in a tree view for encapsulating and reusing subviews.

**Presenter**. Is responsible for handling all presentation logic, it provides data ready to present to View component. When it needs data to be cooked to view, request this data to Interactor. 

**Interactor**. It contanains all the data necessary for this screen, ready or not ready, to be presented. When not ready, presenter will handle that.

**Coordinator**. _Any scene does not know, which is its next (or previous) scene. This helps a lot for reusing scenes_. Responsible of handling scene navigation it is coordinator. It has implemented the logic for knowing which is the next scene to present. 


## Domain Layer
Domain layer is quite hard to deffine. It would be what is neither View nor Data layer component. For instance, if the app had implmented a Sequencer it would be placed in that folder. A Sequencer is a pattern that implements the app start up sequence, by using NSOperations.


## Data Layer
Data layer is responsible for fetching data from any source (Network, DDBB, Files, UserDefaults, Keychain, ...), outside of this layer, nobody know the origin of data. This layer is implemented in XCode project folder called __DataLayer__
##### APIService
Inside datalayer exists a bunch of components dedicated to handle data depending on its source, for instance, APIService is responsible for fetching data from a REST service you can find its implementation under __DataLayer/APIService__ XCode project folder. 


# External libreries

No external library has been used, based on my experience on legacy projects and yearly iOS new updates. I prefer, as much as I can, not depend on them. Beacuse, even when they are very usefull today, they could be a stone in the app bag in a few years (e.g. Mantle, Material, Argo, ...). If the use of a library can be bypassed by implementing an extension, the extension would be my first choice. 

_That means that I do not use external libraries? NO._  

There are times that you can not avoid them, for instance, if you want to implement a calentar month view. It has no sense to implement that, you could yous a library such as JTAppleCalendar.

There are also others, with a lot of years of maintenance and with a high reputation, such as Realm or Firebase among others, that are very usefulls, and I would not dude in included them when the project requires.


# Quality

As much as I can, I try to test every line of code that I write by implementing a unit test complment in a mirrored file structucture under __Test__ folder.

![image](https://user-images.githubusercontent.com/4647295/209940633-78c0b6a6-f898-44cb-88b9-9291aa7f4467.png)

Basically I implement the unit tests by using dependency injection and injecting mock compoments for forcing the desired test objective.

**View** components are the very least components tested, due its implementation are very hard to test. The architecture implemented helps to minimize this problem by moving all the presentation logic to **Presenter** component which is fully tested.



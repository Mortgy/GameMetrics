# Game Metrics
### Dependancies (Swift Packages)
- SENetwork

### Architecture & Pattern 
**MVVM-C** is the pattern used in this project, it helps to make code more **testable**, besides separating **UI** from the **business logic**

#### Why using MVVM-C ?

Coordinator helps to separate viewControllers navigation flow to avoid coupling
so as result of using coordinator we could navigation from any view controller to another view controller and the coordinator would handle the navigation part.

![Architecture & Pattern](https://github.com/mortgy/GameMetrics/blob/master/images/architecture.jpg?raw=true)

### What Scenes we got ?

#### The app consists of 3 main Scenses / Modules

- **HomeViewController** responsible for games listing & search
- **FavoritesViewController** responsible for listing favorited items
- **DetailViewController** responsible for showing the game details

**HomeViewController**  & **FavoritesViewController** are using **GameCollectionView** component which changing the data just by changing the data source AKA **ViewModel**

### File Structure
#### App 
* AppDelegate
* Environments Configuration

#### Services ( i/o )
*  Network ( Endpoints / Configuration / ApiServices )
* Caching **Interface**, **DiskCacheManager** and **MemoryCacheManager**  

#### Scenes
* LaunchScreen
* Home Module
* Favorites Module
* Details Module

#### Extensions
* Additional features Base classes

#### Shared - Classes shared across the app
* CustomViews 
* **Components**
* Coordinator
* Protocols
* Models

#### Assets
* Images
* Fonts
* Color sets

![File Structure](https://github.com/mortgy/GameMetrics/blob/master/images/file-structure.jpg?raw=true)

### What are shared Components ?
- I've written **components** structure to guarantee the code reusability.
- **Components** contains it's **Base implementation class**.
- **Components** relay on **Protocols** defining the **View Model** structure to implemented differently.
- **Components** must relay on same **Model** structure.

### Caching
- I've written 2 caching methods **Memory Caching** and **Disk Caching**
- **Memory Caching** is serializing and caching **small**  **values** / **references**
- **Disk Caching** serializes and caching **big data** , such as **backend responses** / **images**.
- **images** are getting cached on disk with a hashed value for the **URL** of the image.

### Offline first approach
- **Offline first**  is caching only the **first page** and at same time, the actual **request** is sent, when data is loaded it **replaces** the first page items.

we could cache all pages but it could result a bad practices as the app is relaying on regularly updating content.

### Build Schemes

- **Build Configuration** provide 3 different configuration for api **Base URL** ( Staging - development - production ).

### Future Improvements

- **Unit Test** coverage could be increased.
- **Caching** handle **cache size** and **limit** as well as set **expiration** for caches.

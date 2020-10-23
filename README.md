# SpotifyAlbums

# SpotifyAlbums
App created to display Spotify album releases. :)

### Running Tests
To run the tests on Xcode, select the SpotifyAlbums target and device, and click on the Test option or press ⌘+U

### Building App
There is no third party dependencies on this app, just press ⌘+R

### App Structure
Design - Helpers and wrappers related to the UI elements  
Transformer - Helpers for date transform  
Storage - Local simulation of user state  
Provider - Handles token  
Extensions - Extensions created to facilitate the encapsulate common functionality  
Factory - Create and handle view controllers  
Models - Codable Model objects  
Service - API services and helpers  
View - ViewControllers, ViewModels and TableViewCells  


*Test files and folders are organised in the same pattern of the production files and folders

### Design/Architecture
This project adopts MVVM and can be extended to use Coordinators/Routers.  
In order to make the business logic testable, the viewModels and Services are accessed via Protocol with mocks included on the test target.

## Author
* **Ricardo Hurla** - [Portfolio](https://rihurla.com)  -  [BitBucket](https://bitbucket.org/rihurla/)  -  [Github](https://github.com/rihurla)

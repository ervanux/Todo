# Todo

## Implementation:

### Description:

* Please check `highleveldesign.svg` file which located in root dir of project. It contains high level design of the project, layer definations, component names, data flows.
* I followed common `MVC` with `UseCase pattern`, `Repository pattern`, `Factory pattern` and ofcourse `SOLID`.
* As a datasource, CoreData used but it designed scaleble so not that hard to extend with any other data source like `Realm`, `Remote data sources`..
* As requested, there is no ThirdPary, no test implementation, basic UI, SwiftUI, only Storyboard.

### Desicions:
- `MVC`: I dont have a special reason and it is not that important. It is a small app. The main target was speration of concern for each layer and making app scaleble. 
So I support the architecture with design patterns.
- `UseCase Pattern`: It is responsible for business layer. Since the app has not much busines logic, this pattern is used like a proxy between presentation and data layer. 
- `Repository Pattern`: It was important to keep as much as abstracted the data layer since this kind of apps need multiple data sources.
- `Core Data over Realm`: Because I don't have much experience.

### Missing Features:
* Paging
* Better error handling
* In code documentation

## Project:

We would like you to build a simple "to-do" app which consists of tasks in list and task detail in detail screen.

### Requirements:

* A task should consist of a title and details
* Tasks' titles should be shown in a list
* Tasks can be deleted in listing screen
* To see the detail of a task, a user should be able to navigate to detail screen
* A user should be able to save, delete and update a task in detail screen

### Technical Requirements:

* Feel free to use any architecture or design pattern
* Do not use any reactive paradigm (SwiftUI, RxSwift etc.) 
* You can build the user interface with XIBs or Storyboards
* Do not try to build a fancy UI
* Keep code as clean as possible
* For the local storage, you should use Realm or CoreData
* Git usage will be evaluated
* A README.md which shortly describes technical details/decisions
* We do not expect to see any UI or unit tests
* There should not be any necessity to use a third party framework (other than Realm, if you chose it)

### Submission:

After completing the assignment, create a pull request to `main` branch.
Then please send an email to the People Department with the link of the GitHub repo.


# SFR3Recipes

## Requirements
  - macOS 13
  - Xcode beta 8
  - iOS 17

## Instructions
Other than updating code signing, the app should build and run without any additional steps.

## Notes

### Behavior
The app has two tabs, 'Search' and 'My recipes', both of which display a list of recipe titles + images:
  - The 'Search' tab triggers a keyword search on submit and displays the results. Upon scrolling to the penultimate list item, the app will attempt to fetch the next page of results and continue scrolling
  - The 'My recipes' tab displays any recipes that have been saved to local storage (using SwiftData for local storage management)
  - Also note: tapping a list item (from either tab) will navigate to the recipe detail view, where the recipe can be added to or removed from the list of favorites (i.e., recipes stored in SwiftData)
    
    ![Simulator Screen Recording - iPhone 14 - 2023-11-04 at 17 00 12](https://github.com/reschneebaum/sfr3-recipes/assets/13072781/2cb1e893-89b6-467d-9598-92ac0eb480f1)

    
### Architecture
The app more or less follows the MVVM pattern, with one notable exception due to working with SwiftUI and SwiftData:
  - because the shared model context is an environment object managed by SwiftUI views, and because a SwiftData `Query` must be owned by a SwiftUI view, some of the local storage is managed by the views rather than being fully encapsulated by a particular view model or service
  - while I could have forced a closer adherence to MVVM by e.g., manually fetching SwiftData models rather than using a `Query`, I ultimately decided it was preferable to follow native SwiftUI/SwiftData patterns rather than enforce some arbitrary architecture
  - note, though, that this does make unit testing local storage more complicated than it would be otherwise

## Future improvements
  1. add UITests
  2. add unit test coverage for SwiftData handling
  3. add filtering + sorting
  4. cache images and use custom caching image view rather than relying on `AsyncImage` and redownloading images constantly
  5. break Networking/Core into its own Swift package


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
  - The 'Search' tab triggers a keyword search on submit and displays the results

    ![Simulator Screenshot - iPhone 14 - 2023-11-03 at 16 49 36](https://github.com/reschneebaum/sfr3-recipes/assets/13072781/5929f6e1-a754-413f-99ce-549b84436018) ![Simulator Screenshot - iPhone 14 - 2023-11-03 at 16 48 52](https://github.com/reschneebaum/sfr3-recipes/assets/13072781/7de9bf03-694a-473c-912e-b013b01ff7ed)

    - On scrolling to the penultimate list item, it will attempt to fetch the next page of results and continue scrolling
   
  - The 'My recipes' tab displays any recipes that have been saved to local storage (using SwiftData for local storage management)
    
    ![Simulator Screenshot - iPhone 14 - 2023-11-03 at 16 49 43](https://github.com/reschneebaum/sfr3-recipes/assets/13072781/03b2f90b-1453-4a55-ac90-d227dbea4013)

  - Tapping a list item (from either tab) will navigate to the recipe detail view, where the recipe can be added to or removed from the list of favorites (i.e., recipes stored in SwiftData)
    
    ![Simulator Screenshot - iPhone 14 - 2023-11-03 at 16 50 05](https://github.com/reschneebaum/sfr3-recipes/assets/13072781/19eb2621-6348-4693-9b8a-39ef61ba5668)

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

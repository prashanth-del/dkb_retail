## Getting started

This is a project where we maintain all common UI components.

## Rules

#### 1. Naming:

   - All Components' name must start with `Ui`
     - eg: `UiButton`, `UiText`
   - The naming of the widgets must be as generic as possible.
   - The name of the file should be same as the component it holds. 
     - eg: If the component is `UiButton`, then the file name is `ui_button.dart` 

   - Naming of color variables:
     - Color name suffixed with last two hex codes.
       - eg: Consider color `#2F394E`, this is a shade of blue. Then the variable will be named as: \n
         ```dart
         const Color blue4E = Color(0xFF2F394E);
         ```
       - If there arise any conflict between color suffix, then add last 3 hex codes.

#### 2. Theming: 

   - Care must be taken to minimize the usage of Inline theming.
   - All common themes must be declared in the ThemeData class before calling it in any UIComponents.
   - Avoid calling Colors directly from its declaration. Instead it should come from the colorScheme or from the declaration in ThemeData.
   - If additional colors that are not supported by default by the ThemeData are required, then use **extensions** in ThemeData to define these colors.
   - The Default ThemeData for the app is defined in `default_appearance.dart` file.
   - The file and structure are defined in such a way that in future we can define multiple themes, or dark themes, without any hassle. We can also fetch theme from server if the requirement comes.
       
#### 3. Handling variations:

   - If there are multiple variations for a component, then const constructors has to be utilized to define them.
   - eg: Consider `UiText` which has medium, semiBold, bold. Then the code must be in the following structure.

     ```dart
     class UiText {
        final String text;
        final FontWeight? fontWeight;
        final double? fontSize;

        const UiText(
        this.text, {
        this.fontWeight,
        this.fontSize,
        });

        const UiText.medium(
        this.text, {
        this.fontSize,
        }) : fontWeight = FontWeight.w600;

        const UiText.semiBold(
        this.text, {
        this.fontSize,
        }) : fontWeight = FontWeight.w700;

        const UiText.bold(
        this.text, {
        this.fontSize,
        }) : fontWeight = FontWeight.w800;
     }
     ```
     
   - If variation is not achievable by constructors, use `enum`

#### 4. Folder Structure:

- There will will be a toplevel `src` folder. Inside `src`: 
   - `styles` will contain all the themes, spacing, borders, fontSize declarations, etc. which deals with the arrangement and look of the widgets.
   - `components` will contain all the reusable components.
      - Creating a new component.
        1. A single component which requires multiple files to achieve its functionality should be kept under a folder.  
        Eg: Say datatable has multiple files to achieve the functionality. Then we add datatable and its files in a datatable folder inside (`components/datatable`).
        2. If say, ui_button doesn’t  have multiple files, then we can add ui_button.dart directly inside components folder.
        3. After that export your components from `lib/components.dart` file.
   - `channel` will contain the method channel implementations.
   - `network` will contain commont http clients and network related utils.
   - `utils` will contain helper functions like `string_formatters.dart` and it also holds extension helpers.

#### 5. Importing components

Inorder to import a component, you can either import the `components.dart` file, or `db_uicomponents.dart` file.  
Similarly there are `styles.dart`, `utils.dart`, etc. which contains their respective imports.  
If you import `db_uicomponents.dart` file, it will by default contains all the exports. 

#### 6. Testing your components.

For usage examples, refer the app in `/example` folder.  

In order to test and develop your components, or any functionality that is being added to the db_uicomponents project, utilize the **example app** (example/lib/main.dart) that is present in the project. 

Inside the `main.dart` file there is a `components` list, add your component and its label there, it will add it to the listview and you can preview.  
Usage rule:  
Ideally for one component, create a component_page inside the `src` folder, and add that page in the components list.  
Eg: Testing ui_card.  
Create a `ui_card_page.dart` inside the `src` folder, and add all your codes related to the ui_cards inside the file. The file ideally contains the usage example, so the other developer can easily come and refer the usage and utilize the component. [Example code is available in the repo]

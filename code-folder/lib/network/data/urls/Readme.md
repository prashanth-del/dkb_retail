## Passing baseUrl

### Taking build
`flutter build apk --dart-define=BASE_URL="api.doha.app/"`

### Running in local
`flutter run --dart-define=BASE_URL="api.doha.app/"`

## Rules to declare urls

- Each module will have its on dart file. eg: For account modules we maintain `account_url.dart`. 
- Define all the module specific urls in the respective file.
- Calling the url in the data layer
    - Eg: `AcccountUrl.getEndpoint`

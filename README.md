# latin_one
Coffee order app

## Overview
Intuitive  coffee order app
![nothing](./nothing) 

## Build
### Requirements
1. Install Flutter >= 3.24 from [Official Webpage](https://docs.flutter.dev/get-started/install)
2. Set up Firebase project
    * You create Firebase project from [Firebase Console](https://console.firebase.google.com/)
    * Activate Firebase Cloud Firestore and Firebase FireAuth
3. Set up Firebase CLI from [here](https://firebase.google.com/docs/cli)
    * Example (follow the above page)
        ```bash
        curl -sL https://firebase.tools | bash
        firebase login
        dart pub global activate flutterfire_cli
        ```

### Setup
1. Clone this repository
    ```bash
    git clone https://github.com/miyake13000/latin_one.git && cd latin_one
    ```
2. Setup Firebase
    ```bash
    flutterfire configure
    ```
3. Build
    ```bash
    flutter run
    ```

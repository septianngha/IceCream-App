# ICE CREAM APP
##### Ice Cream App is an iOS application created by implementing Firebase as the database used. This application displays ice cream data that has been inputted in Firebase, more precisely in Firestore. 
##### The data can be selected by clicking on the row table, then after the Add button is clicked, the selected data will enter and be saved to Firestore. In addition, there is a feature for editing data that has been added and also a feature for deleting data. 
##### Another implementation is the use of Email and Password as Authentication to be able to enter the application.

[![Build Status](https://img.shields.io/badge/iOS-000000?style=flat&logo=ios&logoColor=white)]()
#
## Features

##### ✎ Authentication using Email and Password
##### ✎ Register and Login Account for Authentication
##### ✎ Add ice cream app transaction data to local device or add to Firestore
##### ✎ Edit transaction data and update data in Firestore
##### ✎ Delete selected transaction data
##### ✎ Display ice cream product data and transaction data that has been added to the Application
##### ✎ Logout feature from the Application Home Page


#
## Tech

##### To build this application, the technologies used are:

![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white) ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white) ![Firebase](https://img.shields.io/badge/firebase-a08021?style=for-the-badge&logo=firebase&logoColor=ffcd34)

- Swift - The main technology used is swift
- Ruby - Using Ruby for cocoapods implementation as a third-party library
- Cocoapods Firebase - Using Firebase to store and manipulate the application database
- Using Swift Package Dependencies IQKeyboardManagerSwift - To add animation to text
- Using TableView to display ice cream product data and transaction data
- Implementing Custom Table Cell to be displayed on TableView
- Using MVC Design Model to organize application files
- Implementing CRUD on applications with Firebase
- Using NotificationCenter to reload the table when dismiss view is used
- Adding scrollToBottom function to display the latest table row data placed at the bottom after being added

#
## Installation

##### Installation can be done by following these step:
1. Download the project zip file or clone the project
2. Open Firebase and create a new project
3. Then select iOS
4. Enter the Bundle ID and Application Name (See the Bundle ID in the application, change the bundle name if necessary)
5. Download the config file, GoogleService-Info.plist then move it into the project in Xcode
6. Reopen Firebase and go to Authentication
7. In the Sign-in-method section, select Add New Provider then select enable on Provider Email/Password
8. Exit to the Firebase page and go to Firestore Database
9. Open the Rules section
10. Change the Rules to:
    ```
    service cloud.firestore { 
        match /databases/{database}/documents { 
            match /{document=**} { 
                allow read, write: if request.auth != null; 
            } 
        }
    }
11. Then open the Data section and create a new collection in Firestore
12. The name of the collection is "products" and the attributes in it are 
    ```
    DocumentID, click Auto-ID
    name: String, 
    price: Number, 
    imageURL: String
13. Input the value in the collection, this collection data will be the product data that will be displayed in the application
14. Open Xcode and run the application

#
## Screenshoot App
![Background-Ice Cream App 1](https://github.com/user-attachments/assets/48db489d-d455-4132-ae88-e6304355a7fa)
![Background-Ice Cream App 2](https://github.com/user-attachments/assets/0fa26b2f-f1f7-485d-b540-6f193e8f6d89)
#
<div align="center">
Septian Nugraha
</div>

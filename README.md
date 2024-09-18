# Happ
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

An event planning app aimed at simplifying event planning and management while making it easy to track both events and invitations :)

## Why

## Platforms
- iOS
- Android

## Tech used
- Main language used on the backend: Go
- Frontend framework: Flutter
- API: Graphql
- Search engine: Meilisearch
- Main database: Planetscale (MySQL)
- Authentication: Firebase Auth
- Maps: Mapbox
- Containerization: Docker
- All other cloud: AWS (AWS EC2, AWS S3, AWS KMS, and AWS Parameter Store)

## Features
- ### Feeds
  Happ has 3 different feeds:
    - ### invitations from friends
      Shows only the invitations from friends.
    - ### Other invitations:
      Shows the invitations that did not come from friends.
    - ### Events:
      Shows events where your attendance has been confirmed.
- ### Event information
  Every event provides information including:
    - Date and time
    - Pictures
    - Description
    - Location
    - Host list
    - Guest list
- ### Notifications
  You are notified when:
    - A user adds you as a friend
    - You receive an invitation to an event
    - An event is approaching
- ### Ticketing system
  A secure ticketing system that uses unique QR codes with encoded AES256 strings which can be scanned by hosts to verify authenticity.
- ### RSVP system
  When invited, the user receives a notification of the invitation. When the app is opened, the user can see the invitation in one of the two invitation feeds. The user can either accept or reject the invitation.
- ### Friendships
  A friendship system for two reasons:
  - A dedicated list to see invitations from friends
  - Adding friends to an event in an easier way
- ### Profiles
  Each user has a profile which includes the following information:
  - Name
  - Username
  - Profile picture
  
  On top of that, when you see your profile you can see a list of your friends and another list of the people who added you as a friend, however when another person is viewing your profile or vice versa then only a list of mutual friends is shown. 
- ### User search
  A search engine for looking for people.

## Pictures
<div style="text-align: center;">

  <img src="https://github.com/user-attachments/assets/483c9458-307a-4b9d-941e-83c845259843" alt="Screenshot 1" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  
  <img src="https://github.com/user-attachments/assets/dd509012-064d-46bf-801e-43fd547f697d" alt="Screenshot 2" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  
  <img src="https://github.com/user-attachments/assets/55ed17c0-eda7-47aa-888b-ec9b700d2493" alt="Screenshot 3" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  
  <img src="https://github.com/user-attachments/assets/680c70db-9501-499d-abf9-ef4fbc98b59e" alt="Screenshot 4" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  
  <img src="https://github.com/user-attachments/assets/bef9a7cc-dac1-43a7-a1c7-438dc7be805b" alt="Screenshot 5" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  
  <img src="https://github.com/user-attachments/assets/57a71036-263b-46ec-8d10-5b4ae158c8a7" alt="Screenshot 6" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />
  
  <img src="https://github.com/user-attachments/assets/0573a254-de01-48c5-ac51-aa64def4801d" alt="Screenshot 7" width="200" style="max-width: 100%; height: auto; display: inline-block; margin: 5px;" />

</div>






  

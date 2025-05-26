# Clean Architecture
Clean Architecture is a software architecture that helps us make scalable application. This type of application can <br>
easily be maintained without facing too many errors. You can add new functionality to your application easily without <br> 
your application completely.

Clean architecture depends on various layers. These layers have ranking systems. A lower level system cannot directly <br>
access data from a higher level system. We have-
- **Data layer:** This layer communications with our database system.
- **Domain layer:** This layer communicates with the sever/REST api
- **Presentation layer:** This layer only communicates with our UI

The speciality of clean architecture is that it separates business logic from our UI.

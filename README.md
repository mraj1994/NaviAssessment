# NaviAssessment
Code assessment for Navi. Contains closed pull request list with pagination.

To Run Clone the repo and refresh Packages as SPM is used for third party libraries(SDWebImage and ALamofire) after opening project, then run the application.

Expected View:-

1: On launch you should see loading content message.
2: After successfull api call you should see list of closed pull request for URL "https://api.github.com/repos/apple/swift/pulls" 
3: If failed then you should see the error pop up, which asks user to relaunch the app to reload as there is no reload logic if API fails.



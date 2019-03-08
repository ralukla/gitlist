# gitlist

A sample app to show github trending list

The main idea of the project is to list trending projects on Github and when tap on one of them, show their details.

While doing research I noticed that Github doesn't have a REST API call that returns the trending projects.

I thought of calculate the list myself. But the best and correct solution would be to create a server that makes the calls to Github REST API and creates the list. Such a server exists and it's called: github-trending-api created by huchenme.

I am giving credit to: https://github.com/huchenme/github-trending-api

The app doesn't have a complicate design. The elements can be reuse with ease.

Elements:

Segmented control: 

The user can choose between Today, This Week or This month to reload the list of trending projects.

Search: 

The user can search in the title, username and description.

Details: 

The user can tap on one of the project to see a page of details.



[![Codemagic build status](https://api.codemagic.io/apps/5e85577308224b15f61e62f9/5e87aa6e64e0bd399fe67ffb/status_badge.svg)](https://codemagic.io/apps/5e85577308224b15f61e62f9/5e87aa6e64e0bd399fe67ffb/latest_build)

# Server Monitor [WORK IN PROGRESS]

[Available URL](sync-server-web-staging.codemagic.app)

This a server manager. It allows to turn on, off and watch the stats from a particular server. The server data is given by the host in this case Google Clodud Services. In order to make this work the user needs to create an account and put the values from the server so it can be reach by the API.

Mobile Screenshots

![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/m1.png)
![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/m2.png)
![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/m3.png)

Web-App Screenshots

![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/w1.png)
![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/w2.png)
![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/w3.png)

## Architecture

The architecture as can be seen uin the image below has an API made with Go that connects to the SDKs from Google so it can retrive the data from the server and it also has a mobile app that lets the user watch the stats retrive by the API and control the state of the server. The mobile app also makes use of Firestore to save the user configuration data and Firebase Auth to manage the user access.

![alt text](https://raw.githubusercontent.com/merRen22/server-stats-monitor/master/artworks/details.png)

# Weather App

This app is designed to allow the user to select any location, either by inputting it manually or using their phone's GPS. The user can then swap to the forecast screen to view the weather forecast at that location, as well as the time in that timezone. The app will show a list of forecasts for each specific day, and then a detailed forecast if the user selects a certain day, displaying a detailed description and accompanying background image. Any locations the user adds is saved to a database, so they can easily switch between them at will. The user can also delete any saved locations if they so chose. The app also has a toggleable dark mode.

## Demonstration Video

The following is a video demonstration of the app in use and an explanation of the codebase:
[https://youtu.be/Oplk2sqE9T4](https://youtu.be/Oplk2sqE9T4)

## Step 1: Open Flutter

This app uses Flutter, so you must have Flutter installed to run it. You also need an IDE to use Flutter - if you don't already have one, you can use VSCode. You will also need to install Git. The following link has easy-to-follow instructions for setting up VSCode, Github, and Flutter:
[Flutter quick setup instructions](https://docs.flutter.dev/install/quick)
(You can stop once you reach the "test drive flutter" section.)

## Step 2: Clone the Github Repository

Note that you do *not* need to sign into a Github account to perform these steps.

1. Open a terminal or command prompt. On windows, you can press the windows hotkey, type "command", and select the first option that appears.

2. Navigate in the terminal to the directory you wish to clone the project to using the CD command, like so:
  ```bash
  cd ~/Documents/Projects
  ```

3. Clone the repository (copy and paste this into your terminal)
  ```bash
  git clone https://github.com/shackfu1/cs492-weather-app.git
  ```

## Step 3: Deploy the app

1. Navigate to the new repository
  ```bash
   cd cs492-weather-app
  ```
2. Run the app
  ```bash
   flutter run
  ```
If you have a phone connected, flutter should automatically run the app on that device. If not, you may have to specify in the command the name of the device you wish to run the app on, using the -d perameter. If you don't have a phone, you can also run it on the web by adding -d chrome.

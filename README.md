[English](./README.md) | [Korean](./README_KO.md)

## Padong

![IMG](./assets/logo/PADONG_L.png)

Padong is a community platform that resolves information inequality among students in college life in the US.  Padong provides successful college life know-how through questions and answers to senior students who have experienced and felt directly, not formal information provided by schools. Also, you can use many functions with Padong by integrating functions of fragmented services that are useful for college life.

For example,

* Ask if your class schedule is doable to "[Reddit](https://www.reddit.com/)"
* Search the location of a building with your classroom in "Google Map"
* Purchase a used calculator in "[used marketplace page in Facebook](https://www.facebook.com/groups/199456403537988/)"
* Search evaluations of professors in "[Rate My Professors](https://www.ratemyprofessors.com/)"
* Look up classes and make a timetable at "[Courseoff](https://courseoff.com/)"

Without having to use such fragmented services, Padong provides such all functions above in one application.

## Motivation
**Padong's Golden Circle**

> **Why**
> Each person has his or her own goodness and beauty.
>
> **How**
> Connect each goodness, each beauty, its own wave together.
>
> **What**
> Make the world more beautiful.

Colleges in the US offer programs that new students can adapt to school life through orientation, advisor and etc, but the most helpful thing in practice is the senior students who have experienced and felt school life or classes in person. I've seen many cases where first-year students who just entered the U.S. university failed due to insufficient information and eventually dropped out due to class schedules that they couldn't handle. However, I was able to learn about the class of the professor who teaches well with the help of the Korean student council and have been successful academically because I could judge whether the lecture schedule is too much or not. Based on my experience, I came up with a platform called "Padong," which will connect experienced seniors to students who are having a hard time adjusting to school life.

## Screenshots
Include logo/demo screenshot etc.

## Tech/framework used
- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)

## Features
What makes your project stand out?

## Installation
#### Prerequisite

* Git: If you have not installed Git, you click [Git](https://git-scm.com/downloads) and install it.

#### Install Padong

To run Padong, two requirements below are needed to be installed.

* [Android Studio](https://developer.android.com/studio)
* [Flutter SDK](https://flutter.dev/docs/get-started/install)

##### Install Android Studio

1. Click the Android Studio link above, download and install.
2. Run Android Studio and install Flutter plugin.

   1. Launch **Android Studio application**.
   2. If you just installed Android Studio, Choose **Configure -> Plugins**.
      * If you are not the case, Choose **File -> Settings -> Plugins**.
   3. Search **Flutter** Plugin and install it.
   4. Restart **Android Studio application**.

##### Install Flutter SDK

1. Download Flutter SDK from Git repository:

   ```bash
   git clone https://github.com/flutter/flutter.git -b stable
   ```

2. Update your path

   * Windows

     1. From the Start search bar, enter ‘env’ and select **Edit environment variables for your account**.
     2. Under **User variables** check if there is an entry called **Path**:
        - If the entry exists, append the full path to `flutter\bin` using `;` as a separator from existing values.
        - If the entry doesn’t exist, create a new user variable named `Path` with the full path to `flutter\bin` as its value.

   * Mac

     1. Determine the directory where you placed the Flutter SDK. You need this in Step 3.

     2. Open (or create) the `rc` file for your shell. Typing `echo $SHELL` in your Terminal tells you which shell you’re using. If you’re using Bash, edit `$HOME/.bash_profile` or `$HOME/.bashrc`. If you’re using Z shell, edit `$HOME/.zshrc`. If you’re using a different shell, the file path and filename will be different on your machine.

     3. Add the following line and change `[PATH_TO_FLUTTER_GIT_DIRECTORY]` to be the path where you cloned Flutter’s git repo:

        ```bash
        export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
        ```

     4. Run `source $HOME/.<rc file>` to refresh the current window, or open a new terminal window to automatically source the file.

     5. Verify that the `flutter/bin` directory is now in your PATH by running:

        ```bash
        echo $PATH
        ```

        Verify that the `flutter` command is available by running:

        ```bash
        which flutter
        ```

3. Run flutter doctor.

   ```bash
   flutter doctor
   ```

##### Clone and run Padong

1. Open a terminal and clone Padong project and open it in **Android Studio application**:

   ```bash
   git clone https://github.com/padong4284/padong-flutter.git
   ```

2. In Padong project directory, download dependencies by typing following command:

   ```bash
   flutter pub get
   ```

3. Run **Android Studio**, click **open an existing project** and open Padong's project directory.

4. In **Android Studio**, click **File -> Settings -> Languages & Frameworks** and set **Flutter SDK path** as Flutter SDK directory you have cloned.

5. On **top bar in Android Studio**, select virtual device you would like to use and run by clicking **run icon**
   **Or** build by clicking **build -> Flutter -> build APK or build IOS** and move the build output to your smart phone and install it.

## How to use?

If people like your project they’ll want to learn how they can use it. To do so include step by step guide to use your project.

## Copyright

Copyright (C) 2021-2021 Taejun Jang \<<padong4284@gmail.com>\> - All Rights Reserved.

PADONG can not be copied and/or distributed without the express permission of Taejun Jang, Daewoong Ko, Hyunsik Kim, Seongbin Hong
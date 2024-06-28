# TRACTIAN CHALLENGE MOBILE

Develop a mobile application in Flutter to visualize the Assets and Components of Companies in a tree view format.

## Index

1. [Requirements](#requirements)
2. [Instalation](#instalation)
3. [Configuration](#configuration)
4. [Usage](#usage)
5. [Prototype](#prototype)
6. [Demonstration](#demonstration)
7. [Project Structure](#project-structure)

## Requirements

To run this project, you will need to install [Git](https://git-scm.com/downloads), [Android Studio](https://developer.android.com/studio/install?hl=pt-br), and [Flutter](https://docs.flutter.dev/get-started/install) on your machine. You can use Android Studio IDE to view the project or use another IDE of your choice, such as [VSCode](https://code.visualstudio.com/download).

Para rodar esse projeto você precisará instalar o [Git](https://git-scm.com/downloads), [Android Studio](https://developer.android.com/studio/install?hl=pt-br) e o [Flutter](https://docs.flutter.dev/get-started/install) na sua máquina. Você pode usar a IDE do Android Studio para visualizar o projeto ou usar outra IDE de sua preferência, como [VSCode](https://code.visualstudio.com/download).

## Instalation

To install the project, open File Explorer and create a folder in the directory of your choice, navigate to that folder, open the terminal, and run the following command:

```bash
$ git clone http://github.com/zarref-semog/tractian-challenge.git
```

Open Android Studio and follow these [steps](https://developer.android.com/studio/run/managing-avds?hl=pt-br).

## Configuration

In the project folder, open the terminal and run the following command:
```bash
$ flutter doctor
```

To accept the Android license, run:

```bash
$ flutter doctor --android-licenses
```

Check again if everything is correct:

```bash
$ flutter doctor
```

With this, your environment will be ready to run the application.

## Usage

Open Android Studio. Select the option More Actions->Virtual Device Manager and start the virtual device. When the device is ready, open the terminal in the project folder and run the following command:

```bash
$ flutter pub get
```
This will install all project dependencies.

Next, run ```flutter run``` to start the project:

```bash
$ flutter run
```

## Prototype

[Prototype Link](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&t=3g9gWmzy26ibYRyT-1)

## Demonstration

[Video Link](https://youtu.be/KDt6Vs-RKYY)

## Project Structure

```bash
tractian-challenge
├── android
├── ios
├── images
├── lib
│   ├── api
│   ├── components
│   ├── models
│   ├── screens
│   ├── main.dart
│   ├── router_generator.dart
├── pubspec.lock
├── pubspec.yaml
```

- The android and ios directories contain the necessary files to run the application on their respective operating systems.

- The images directory contains the images used in the application.
  > Any file within images should be added to the pubspec.yaml file under assets..

- The lib directory contains the subdirectories models (models), screens (screens), api (JSON file), components (custom widgets)..

- The lib directory contains the router_generator (route generator) and main.dart files.
  
- The pubspec.yml and pubspec-lock files contain assets, settings, and other project dependencies.

Developed by [Murilo Gomes Ferraz](https://github.com/zarref-semog)

# Flutter - Materials and source code for **JediPixels** course 
> # Mastering Flutter: Multi-Platform Apps with Shared Codebase 

### Multi-Project Flutter Development with Shared Codebase ###

Have you ever needed to build multiple **Flutter applications**—for **phones, tablets, and web**—that serve different purposes but share a **common, reusable codebase**? If so, this course is for you!

In this course, you'll develop **three projects**:
1. **A shared codebase** containing reusable logic and widgets
2. **Users App** (for phones, tablets, and web)
3. **Products App** (for phones, tablets, and web)

You'll start by **analyzing common features** across applications and designing a **modular shared codebase** to maximize reusability. Then, you'll build the **Users App**, which retrieves data from a RESTful API and implements:
* **Adaptive UI** for phones, tablets, and web
* **Split-screen layout** for tablets and web
* **Dark & light mode**
* **Navigation between list and detail pages**
* **Search functionality** to filter data

Next, you'll develop the **Products App**, which mirrors the Users App's functionality but fetches data from a different RESTful API—demonstrating how multiple applications can seamlessly share the same codebase.
By the end of this course, you'll have mastered the **patterns and best practices** for building **enterprise-level, large-scale Flutter applications** that efficiently **share logic and UI components** across multiple projects.

## First App: Shared package
The Shared package holds all of the common reusable codebase, and widgets to be accessed by individual Flutter projects. This package will be accessed by two separate Flutter projects, the users and the products applications.

## Second App: Users projects
The Users Flutter project is a completely separate iOS, Android, and Web application that will access and utilize the shared package, reusable codebase.

## Third App: Products projects
The Products Flutter project is a completely separate iOS, Android, and Web application that will access and utilize the shared package reusable codebase.

# bigOFit (Workout Application for Friends)

***Please excuse the lack of documentation. I have tried to document more for those viewing it on Github.  However, because I wrote this program by myself, I didn't have a big need for documentating all functions and classes.***

***This is an app that is currently in development.  When last tested, there were multiple bugs (scrolling on rightmost screen in active workout, some PRs were inconsistently recorded, etc.).  I am currently working to fix these bugs.  However, it is safe to download it into XCode to get an idea of what the app looks like.***

I made this app using SwiftUI for my friends to use while they're working out.  The purpose is for them to be able to perform live workouts that keeps track of their repitions and weight for each exercise.  

The layout of the application follows the traditional "tabbed-view" similar to apps like Instagram and Twitter.  This proivdes the user with the ease to view/create anything they want.  However, there are parts of the application (like the active workout feature) that completely deviates from this traditional tabbed view.

Currently, I have implemented the following features:
- Scheduling workouts (notifications still not implemented)
- Create custom exercises to use in workout routines
- Create custom workout routines
- Active workouts where the user can perform live workouts (currently buggy with scrolling)
- Profile page that tracks all workouts completed, all exercises completed, and personal records

Aside from these features, I am planning on adding:
- Groups where users can perform workouts together
- Connect the app to a firebase database to use

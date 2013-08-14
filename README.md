Animate Rings where the User Taps
======

This app is pretty straightfoward. When the user taps within a 
designated area, we show an animated ring that grows quickly
before disappearing from the view.

## How it works

When a tap is detected, using a basic UIGestureRecognizer,
we pass the location of the tap to a class responsible for
creating, animating, and removing a ring on that location 
within the superview.

When animateRingAtPoint: method is called, we create a path
on which to draw the circle and pass this to a shapelayer. 
After the shapelayer is added to the superview's layer, it is
animated so that it briefly expands before disappearing. After
disappearing it is removed from the superview.
# BiliScaleMode

a Bilinear filter for HaxeFlixel scale mode
also added a simple sharpen filter
base on an issue 
https://github.com/HaxeFlixel/flixel/issues/1817
Warning: this modifed scale.x and scale.y in BaseScaleMode. maybe you should check if you used these 2 variable to prevent disaster
integrate it by following this dev
https://github.com/HaxeFlixel/flixel/pull/1826/files
Also screen will shift to unknown distance under extream scale ratio (somewhere under original 13% resolution)
I don't know why. maybe It's related to how openfl handle shader. Tbh I don't know GLSL at all, I just trying to replicate the code.
also hope that next openfl version won't break shader again 

Remember to rewrite the Code because I'm not good at it and it looks ugly as f

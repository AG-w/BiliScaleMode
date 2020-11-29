# BiliScaleMode

a Bilinear filter for HaxeFlixel scale mode
also added a simple sharpen filter

Warning: this will modify Scale.x and Scale.y. you also need to edit flixel code to prevent disater

Also screen will shift to unknown distance under extream scale ratio (somewhere under original 13% resolution)
I don't know why. maybe It's related to how openfl handle shader. Tbh I don't know GLSL at all, I just trying to replicate the code. 

Remember to rewrite the Code because I'm not good at it and it looks ugly as f

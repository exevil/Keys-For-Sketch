![](https://d26dzxoao6i3hh.cloudfront.net/items/0A302N0R3T3u051W0o1S/Image%202017-06-21%20at%201.13.19%20PM.png)

<br />
<img src="https://d26dzxoao6i3hh.cloudfront.net/items/0z1f0k2Y0T182m343E1M/Group%202.svg" width="90" align="left">

# Keys For Sketch

<br />
Keys is a full-featured shortcut manager for Sketch. Integrated directly to Preferences window it helps you to customize shortcuts easily.
<br />
<br />

1. [Installation](#installation)
1. [Features](#features)
1. [FAQ](#faq)
1. [Support Project](#support-project)

## Installation
Keys installation is way the same as any other plugin but it requires you to restart Sketch afterwards.

[![](https://d26dzxoao6i3hh.cloudfront.net/items/0x1V0z2p0P29120B170h/Group%207.svg)](https://github.com/exevil/Keys-For-Sketch/releases/latest)

## Features
* Easy menu shortcuts customization
* Single-character shortcuts customization (like Pencil or Vector) 
* Shortcut conflicts resolving
* Support of any third-party plugins
* Preferences window integration
* Intuitive lightning fast UI
* Supporting of the modern Sketch v45 Plugin Updating System

## FAQ
#### — Where can I see the changelog?
On the [Releases](https://github.com/exevil/Keys-For-Sketch/releases) page.

#### — How to restore default Sketch shortcuts?
Use «Restore Default Shortcuts...» command from plugin menu. *It should remove any user shortcut data includinge one that defined directly in System Preferences.*

#### — How Keys will affect a custom shortcuts I defined earlier in System Preferences?
Since Keys are using default system storage for shortcuts it shouldn't affect without additional user actions like «Restore Default Shortcuts...» command from plugin menu.

#### — Can't see my Keys shortcuts in System Preferences. Is something wrong?
Since System Preferences caches shortcut values from storage once upon startup you need to completely relaunch it to get updated shortcut data there.

#### — What happens with my custom shortcuts if I remove Keys?
Nothing because all your shortcuts were defined in System Preferences.

#### — I removed Keys and my custom shortcuts manually from System Preferences, but tools with single-character shortcuts (like Pencil or Vector) are still using previously defined values. How to reset it to defaults too?
Since Sketch manages single character shortcuts by itself, you should delete `keyBindings.plist` from `~/Library/Application Support/com.bohemiancoding.sketch3/` folder and restart Sketch to return default tools shortcuts.

#### — My issue isn't listed here. What now?
Please check the [open issues list](https://github.com/exevil/Keys-For-Sketch/issues) and feel free to create a new one if you don't see your problem there.

## Support Project
I spent a lot of time to make this project real so any feedback or donation is really matters. It's wonderful to see that things you do are really making people's lives easier.

[![](https://d26dzxoao6i3hh.cloudfront.net/items/3N0T3k1i3k2X3Z3f2g3v/Group%209.svg)](https://www.paypal.me/exevil/5)

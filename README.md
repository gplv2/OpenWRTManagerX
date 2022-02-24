# OpenWRT Manager

A Mobile App for viewing your OpenWRT devices information.

<!--   ([![OpenWRTManager on Google Play](https://lh3.googleusercontent.com/cjsqrWQKJQp9RFO7-hJ9AfpKzbUb_Y84vXfjlP0iRHBvladwAfXih984olktDhPnFqyZ0nu9A5jvFwOEQPXzv7hr3ce3QVsLN8kQ2Ao=s0)](https://play.google.com/store/apps/details?id=com.hg.openwrtmanager)) -->

## This is pretty much a dev sandbox ! - but works most of the times

I forked it from the original source - I like the idea - I don't like the way some stuff is made in the orginal repo

The whole flutter / dart / studio framework is quite a headache to setup and make it work , version hell , config hell

The original source is not structured well , I'm still not happy on how I modified it .  Dart is pretty new to me .  My largest issue with how it was made is that for each action, the app does a re-login into the routers whole it's recording the auth cookie , but seemingly not taking advantage of the session it has in theory.   This might not be a big deal, but it is when you need to venture outside of the json-rpc calls , for example cgi-bin exec calls like retrieving the kernel/syslog output from your openWRT.

I'm just experimenting with dart api client here .  I renamed the android project and removed the forked link as it has nothing to do with the android play package, with the original code nor do I really care on design differences in opinion and/or I am not really planning to make pull requests.

Currently supports [OpenWRT](https://openwrt.org/) version 19.07 or 21.02 with [Luci](https://openwrt.org/packages/pkgdata/luci) installed.

## Development Setup
Install the Flutter SDK for your system.
Install Android Studio for your system.

Install/configure a whole bunch of crap like gradle / flutter (upgrade) studio.   Delete your app caches.  It's terrible spending hours in getting an IDEA / framework setup and it's not my first rodeo, I do find dart interesting to play with and flutter is kinda cool with the hot reloads

Use `flutter doctor` to see steps required for your system.

## Debugging
See available emulators  (create them first in studio !!!)
`flutter emulators`

Launch emulator
`flutter emulators --launch your_emulator_id`

Run program on the emulator
`flutter run`

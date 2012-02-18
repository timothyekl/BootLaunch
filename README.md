# BootLaunch - an iOS startup app

BootLaunch was written as a proof-of-concept that it is possible to launch an
app when booting an iOS device. It uses the `voip` key in its information plist
to notify the system that it should start on boot, then tracks its own launch
times and displays the most recent.

## Start on boot?

In the vast majority of cases, iOS apps do not start with the system, and there
is no way to make them do so. One exception is made, for VOIP-enabled apps to
establish connections and begin listening for incoming calls; all apps with the
appropriate plist keys are launched on system startup, then backgrounded
without user interaction. This behavior is [documented by Apple][appledoc].

## How can I test this?

Clone this repository, then install the app onto your own iDevice running iOS 5
or better. (In theory, later versions of iOS 4 work, but I haven't tested on
them.) Once installed, launch the app once to verify it shows the current time
as its boot time. Now reboot your phone. Once rebooted, reopen the app within a
few seconds of booting up; you should notice that the time has changed, but
that it is no longer as current as it was: the app was started by the system
before you had a chance to interact with it (or even with Springboard) at all.

## Is this code licensed?

Why, yes. It's under the BSD 2-clause license:

Copyright (c) 2012, Tim Ekl
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[appledoc]: https://developer.apple.com/library/ios/#documentation/General/Reference/InfoPlistKeyReference/Articles/iPhoneOSKeys.html#//apple_ref/doc/uid/TP40009252-SW1

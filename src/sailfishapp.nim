# Copyright (c) 2015, Andrew Penkrat
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import os

when defined boostable:
    import nimQml
    {.passC: staticExec("pkg-config --cflags qdeclarative5-boostable").}
    {.passL: staticExec("pkg-config --libs qdeclarative5-boostable").}
    {.passC: staticExec("pkg-config --cflags Qt5Core").}
    {.passL: staticExec("pkg-config --libs Qt5Core").}

    proc qApplication*(argc: var cint, argv: cstringArray): QApplication {.
        cdecl, importcpp: "MDeclarativeCache::qApplication(@)", header: "<MDeclarativeCache>".}

    proc application*(): QGuiApplication =
        var c: cint = 0
        var v = cast[cstringArray](alloc(0))
        var qapp = qApplication(c, v)
        return newQGuiApplication()

    proc createView*(): QQuickView =
        discard

# Get fully-qualified path to a file in the data directory
proc pathTo*(filename: string): string =
    let exePath = getAppFilename()

    # '/usr/bin/<appname>' -> '/usr/share/<appname>'
    return joinPath(ParDir, "share", exePath.extractFilename, filename)

# Very simple interface: Uses "qml/<appname>.qml" as QML entry point
proc main(): int =
    discard


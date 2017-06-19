#!/bin/sh

# Clean
rm -fr qt-darwin.app
rm -fr Frameworks
rm -fr PlugIns
rm -fr Resources

# Build
qmake CONFIG+=release
make
macdeployqt qt-darwin.app -qmldir=./qml -executable=qt-darwin.app/Contents/MacOS/qt-darwin

# Take what we need
mv -f qt-darwin.app/Contents/Frameworks .
mv -f qt-darwin.app/Contents/PlugIns .

mkdir Resources
mv -f qt-darwin.app/Contents/Resources/qml Resources/ 

# modify run-time path for library searching
install_name_tool -add_rpath @loader_path/../../Frameworks PlugIns/platforms/libqcocoa.dylib

# Packaging
tar -zcvf library.tgz Frameworks PlugIns Resources

# Clean
rm -fr Frameworks
rm -fr PlugIns
rm -fr Resources
rm -fr qt-darwin.app
rm -fr qrc_qml.cpp
rm -fr Makefile
rm -fr main.o
rm -fr qrc_qml.o

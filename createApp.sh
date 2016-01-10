cd $1
dub build

mkdir $1.app
mkdir $1.app/Contents
mkdir $1.app/Contents/MacOS
mkdir $1.app/Contents/Frameworks

cp $1 $1.app/Contents/MacOS

cp -r ../dsfml-lib/Frameworks/* $1.app/Contents/Frameworks/
cp -r res $1.app/Contents/MacOS/res
cp ../dsfml-lib/lib/libdsfmlc-*.2.dylib $1.app/Contents/Frameworks/

mv $1.app ..

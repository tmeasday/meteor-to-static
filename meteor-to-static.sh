#!/bin/bash -

# random port
PORT=3434
BUILD_DIR=/tmp/build

# clean old build
rm -rf "$BUILD_DIR"

# fake out mongo URL so it doesn't start mongo :)
MONGO_URL=mongodb://foo/bar meteor --production --port $PORT &
METEOR_PID=$!

sleep 10

# First grab the files
wget -p localhost:$PORT -nH -P "$BUILD_DIR"
kill $METEOR_PID

# now move the CSS file
for f in "$BUILD_DIR/*.css*"
do
  mv $f "`echo $f | sed s/\?.*//`"
done

# now copy the public directory
cp -r public/* "$BUILD_DIR/"
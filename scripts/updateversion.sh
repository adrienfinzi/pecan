#!/bin/bash

VERSION="1.2"
DATE=`date +"%Y-%m-%d"`

UPDATE_REQUIRE="yes"
UPDATE_COLLATE="yes"

for d in `find . -name DESCRIPTION -print`; do
  DIR=`dirname $d`

  echo "Modifying $d"
  echo "Version: $VERSION"
  echo "Date: $DATE"
  sed -i -e "s/^Version: .*$/Version: $VERSION/" -e "s/^Date: .*$/Date: $DATE/" $d

  if [ "$UPDATE_REQUIRE" == "yes" ]; then
    REQUIRE=`grep -h 'require[\s]*(' $DIR/R/* | sed -e 's/.*require[\s]*(\([^)]*\)).*/\1 /' | sort -u`
    echo "Require: $REQUIRE"
    sed -i -e "s/^Require: .*/Require: $REQUIRE/" $d
  fi

  if [ "$UPDATE_COLLATE" == "yes" ]; then
    COLLATE=$( echo `ls -1 $DIR/R` )
    echo "Collate: $COLLATE"
    sed -i -e "s/^Collate: .*/Collate: $COLLATE/" $d
  fi

  echo ""
done

find . -name "* *" -type d -exec rename "s/ /_/g" {} \;    # do the directories first
find . -name "* *" -type f -exec rename "s/ /_/g" {} \;

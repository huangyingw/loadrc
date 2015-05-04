#!/usr/bin/perl
find . -type f -name \*.java -exec perl -0777 -i.bak -pe 's/\@Test\n\s+public/\@Test\n  \@Ignore\n  public/igs' {} +
find . -type f -name \*.java -exec perl -0777 -i.bak -pe 's/import org.junit.Test;/import org.junit.Ignore;\nimport org.junit.Test;/igs' {} +

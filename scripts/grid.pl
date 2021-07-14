#!/usr/bin/perl -W

use strict;

my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos";

open(my $fh, '<', $photos_file) or die "Could not find any photos $!";

while (my $p = <$fh>) {
    chomp $p;
    print "$p\n"
}

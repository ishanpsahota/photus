#!/usr/bin/perl -w

use strict;
use CGI qw(:all);
my $query = new CGI();

my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $pending_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";

my $decision = $query->param('allow');
my $img = $query->param('image')

print $query->header ( );

open(PENDING, "+<$pending_file") or die "$!";
open(PHOTOS, ">$photos_file") or die "Not able to connect with grid.";

while(PENDING) {
    my $line = $_ if /^$img/;
    print $myline;
    if($line eq 1) {
        
        $line =~ s/$img/\n/;

        last;
    }
}
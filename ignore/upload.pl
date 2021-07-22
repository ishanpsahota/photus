#!/usr/bin/perl -W

use strict;

use CGI qw(:all);

my $query = new CGI();

my $file = $query->param('image');

my $dir = "/home/stud1034/apacheSSL/cgi-bin/photos";

$file=~m/^.*(\\|\/)(.*)/;
 
 my $name = $2;

open(LOCAL, ">$dir/$name") or print "error";
my $file_handle = $query->upload('image');

while(<$file_handle>) {               
    print LOCAL $_;
}



 close($file_handle);                        
 close(LOCAL);                    
 print $q->header();
 print "<p> File upload successful. Go <a href='/grid.shtml'> back </a> to grid.";
#!/usr/bin/perl -w

use strict;
use CGI qw(:all);
my $query = new CGI();

my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $pending_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";

my $decision = $query->param('allow');
my $img = $query->param('image');

print "Content-type: text/html\n\n";
# print $query->header ( );

open(PENDINGFILE, "+<$pending_file") or die "$!";
open(PHOTOS, ">>$photos_file") or die "Not able to connect with grid.";

while(PENDINGFILE) {
    my $line = $_ if /^$img/;
    print $line;
    if($line eq 1) {
        if($decision == 'true') {
            $line =~ s/$img/\n/;            
            print PHOTOS "$img\n";
            close PHOTOS;
            close PENDINGFILE;
            print $query->header ( );
            print "Changes done.";
            last;
        }

        if($decision == 'false') {
            $line =~ s/$img/""/;        
            close PHOTOS;
            close PENDINGFILE;
            last;
        }
        
    }
}

print $query->header ( );
print "<p> File review done. Go <a href='/admin/grid-manager.shtml'> back </a> to the grid manager.";




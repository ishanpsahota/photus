#!/usr/bin/perl -W

use strict;

use CGI qw(:all);

my $query = new CGI();

my $img = "https://images.unsplash.com/photo-1536329583941-14287ec6fc4e?ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";

my $pending_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $image_approval = 'true';

open (my $upload, "+<$pending_file") or die "$!";

while(my $i = <$upload>) {
    if($i =~ /$img\n/) {
        if($image_approval eq 'true') {
            print "File accepted.\n";
            OPEN(my $photos, ">>", $photos_file) or die "Can't save the changes!\n";
            print $photos  "$img\n";
            close $photos;
            $i =~ s/$img\n/""/;
            close $upload;
            last;
        }

        if($image_approval eq 'false') {
            print "File rejected.\n";
            $i =~ s/$img\n/""/;
            close $upload;
            last;
        }
    }
}


print "File review done. Go <a href='/admin/grid-manager.shtml'> back </a> to Grid Manager.";

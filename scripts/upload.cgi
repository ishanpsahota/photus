#!/usr/bin/perl -W

use strict;

use CGI qw(:all);

my $query = new CGI();

my $file = $query->param('image_input');

if ( !$file )
{
print $query->header ( );
print "There was a problem uploading your photo (try a smaller file).";
exit;
}
my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $dir = "/home/stud1034/apacheSSL/htdocs/uploads";
my $safe_filename_characters = "a-zA-Z0-9_.-";

$file =~ s/[^$safe_filename_characters]//g;

if ( $file =~ /^([$safe_filename_characters]+)$/ )
{
$file = $1;
}
else
{
die "Filename contains invalid characters"
}


my $file_handle = $query->upload('image_input');
open ( UPLOADFILE, ">$dir/$file" ) or die "$!";


while ( <$file_handle> )
{
print UPLOADFILE;
}

close UPLOADFILE;

open (my $file_g, ">>", $photos_file) || die "Could not open file: $!\n";
print $file_g  "/uploads/$file\n";
close $file_g;


close($file_handle);                                       
print $query->header ( );
print "<p> Uploaded file sent for review. Go <a href='/grid.shtml'> back </a> to the grid and check again later!.";

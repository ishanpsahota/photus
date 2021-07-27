#!/usr/bin/perl -W

use strict;

use CGI qw(:all);

my $query = CGI->new;
use File::Copy;
my $file = $query->param('image_input');

my $newname = "";

print "Content-type: text/html\n\n";

if ( !$file )
{
print $query->header ( );
print "There was a problem uploading your photo (try a smaller file).";
exit;
}
# my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $dir = "/home/stud1034/apacheSSL/htdocs/pending";
my $safe_filename_characters = "a-zA-Z0-9_.-";
my $pending = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
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
open ( UPLOADFILE, ">$dir/$file" ) or print "$!";

while ( <$file_handle> )
{
print "File uploaded.\n";

}
close UPLOADFILE;

my @args = split("\.", $file);
foreach my $j (@args) {
    print "$j\n";
}
# my $file_original_name = $args[0];
# my $file_ext = $args[1];
# my $random_string = `(date +'%Y%m%d_%H%M%S_' && openssl rand -hex 2) | tr -d '\n'`;

# my $newname = $random_string . "." . $file_ext;

# move ("$dir/$file", "$dir/$newname") or print "Save error: $!\n";

# open (NFILE, ">$dir/$newname") or print "$!\n";

# if(-e "$dir/$newname") { 
#     print "Process successful. ";
#  }

close($file_handle);                                       
print $query->header ( );
print "<p> Uploaded file sent for review. Go <a href='/grid.shtml'> back </a> to the grid and check again later!.";

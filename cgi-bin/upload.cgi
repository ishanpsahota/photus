#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use File::Copy;

use constant MAX_FILE_SIZE => 2097152; # 2MB (base 2)

my $query = CGI->new;
my $file = $query->param("image_input");

print "Content-type: text/html\n\n";

if (!$file) {
  print "<h1>Input Error</h1>";
  print "<p>Your request could not be completed, as there was a problem processing your input.</p>";
  exit;
}

if (-s $file > MAX_FILE_SIZE) {
  print "<h1>Invalid File Size</h1>";
  print "<p>The file you are attempting to upload is larger than 2 MB and will not be processed.</p>";
  exit;
}

# Safest but strictly English-biased
if ($file =~ /[^\w_.-]/g) {
  print "<h1>Invalid Filename</h1>";
  print "<p>Filename contains disallowed characters and will not be processed.</p>";
  exit;
}

my $fileHandle = $query->upload("image_input");
my $pendingDir = "../htdocs/uploads/pending";

unless (-d $pendingDir) {
  mkdir $pendingDir, 0700 or 
  die "Could not create missing dir '$pendingDir': $!";
}

open(UPLOADFILE, ">", "$pendingDir/$file") or
  die "Failed to upload file: $!.";

chmod(0600, "$pendingDir/$file");

while (<$fileHandle>) {
  print UPLOADFILE;
}

close($fileHandle);
close UPLOADFILE;

# Ensures only the last index of '.' is the ext
my @args = split /\.([^.]+)$/, $file;

my $ext = $args[1];
my $uniqueName = `(date +'%Y%m%d_%H%M%S_' && openssl rand -hex 2) | tr -d '\n'`;
my $newFileName = "$uniqueName.$ext";

move("$pendingDir/$file", "$pendingDir/$newFileName") or 
  die "Failed to move file to '$pendingDir': $!.";

if (-e "$pendingDir/$newFileName") {
  print "<h1>Upload Successful</h1>";
  print "<p>The file '$file' has been successfully uploaded and sent for review by an administrator. You can check the image <a href=\"/grid.shtml\">Grid</a> later, or <a href=\"/upload.html\">upload</a> more images now.";
}
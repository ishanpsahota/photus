#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use File::Copy;

print "Content-type: text/html\n\n";

my $query = CGI->new;
my $imageSource = $query->param("image");
my $shouldApprove = $query->param("allow");

my $uploadsDir = "../htdocs/uploads";
my $pendingDir = "$uploadsDir/pending";

my @pendingImages = grep { -f $_ } glob "$pendingDir/*";

if (@pendingImages eq 0) {
  print "<p>No images pending approval.</p>";
  exit;
}

if (!$imageSource) {
  print "<p>No image data received.</p>";
  exit;
}

decide((split '/', $imageSource)[-1], $shouldApprove);

sub decide {
  my $imageName = shift;
  my $approve = shift;
  my $filename = "$pendingDir/$imageName";
     
  if ($approve eq "true") {
    move ($filename, $uploadsDir) or do {
      print "<h1>Move Failed</h1>";
      print "<p>Could not move file '$filename' to '$uploadsDir': $!.</p>";
      exit;
    };
  } else {
    unlink $filename or do {
      print "<h1>Delete Failed</h1>";
      print "<p>Could not delete file '$filename': $!.</p>";
      exit;
    };
  }
}

print "<h1>Processing Successful</h1>";
print "<p>File review complete. Return to the <a href='/admin/grid-manager.shtml'>Grid Manager</a>.</p>";
#!/usr/bin/perl

use strict;
use warnings;

print "Content-type: text/html\n\n";

my @files = grep { -f $_ } glob "../htdocs/uploads/*";
my $fileCount = @files;

if ($fileCount eq 0) {
  print << "  NO_IMAGES"=~ s/^\s+//gmr;
  <div class="full-page-banner-message center">
    <i class="icon far fa-frown"></i>
    <h5>It's Quite Lonely Here</h5>
    <p>There are no images to display. You can check back later or <a href="/upload.html">upload</a> something now.</p>
  </div>
  NO_IMAGES
  
  exit;
}

my $imageCard = <<GRID_ITEM;
  <div class="grid-item">
    <img src="%s" class="grid-img"/>
    <div class="img-details">
      <a href="%s" download>
        <button class="btn btn-light" type="button"><i class="fa fa-download" aria-hidden="true"></i></button>
      </a>
    </div>
  </div>
GRID_ITEM

print "<div class=\"main-wrapper row\">";
print "<div class=\"grid-container\">";

for my $column (0 .. 2) {
  print "<div class=\"grid-inner\">";

  my $index = 0;
  foreach my $i (@files) {
    if ($index++ % 3 == $column) {
      chomp($i);

      my $imagePath = substr($i, 9);
      printf $imageCard, $imagePath, $imagePath; 
    }
  }
  print "</div>";
}

print "</div>" x 2;
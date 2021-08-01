#!/usr/bin/perl

use strict;
use warnings;

print "Content-type: text/html\n\n";

my @pendingDir = grep { -f $_ } glob "../htdocs/uploads/pending/*";
my $fileCount = @pendingDir;

if ($fileCount eq 0) {
  print << "  NOTHING_PENDING"=~ s/^\s+//gmr;
  <div class="full-page-banner-message center">
    <i class="icon fas fa-flag-checkered"></i>
    <h5>You're All Caught Up</h5>
    <p>There are currently no images pending approval.</p>
  </div>
  NOTHING_PENDING

  exit;
}

print "<div class=\"main-wrapper text-center\">";
print "<ul class=\"upload-manager-card-list\">";

my $index = 0;
foreach my $i (@pendingDir) {   
  chomp($i);
  my $p = substr($i, 9);

  print << "  PENDING_CARD"=~ s/^\s+//gmr;
  <li class="upload-manager-card">
    <div class="upload-manager-card-image" style="background-image: url($p)"></div>
    <form action="/cgi-bin/approve.cgi" method="POST">
      <div class="upload-manager-switch">
        <input type="radio" id="radio-approve-$index" name="allow" value="true" checked>
        <label for="radio-approve-$index">Approve<i class="fa fa-check" aria-hidden="true"></i></label>
        
        <input type="radio" id="radio-reject-$index" name="allow" value="false">
        <label for="radio-reject-$index">Reject<i class="fa fa-times" aria-hidden="true"></i></label>
      </div>
      <input type="hidden" name="image" value="$p">
      <button type="submit" class="upload-manager-button">Confirm Decision</button>
    </form>
  </li>
  PENDING_CARD

  $index++;
}

print "</ul>";
print "</div>";
#!/usr/bin/perl -W
use strict;

use CGI qw(:all);
my $query = new CGI();

my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
my $index = 0;

open(my $fh, '<', $photos_file) or die "Could not find any photos $!";

while(my $p = <$fh>) {  
print <<CARD_HTML;
<li class="upload-manager-card">
  <div class="upload-manager-card-image" style="background-image: url($p)"></div>
  <form action="/cgi-bin/approve.cgi" method="POST">
    <div class="upload-manager-switch">
      <input type="radio" id="radio-approve-$." name="allow" value="true" checked>
      <label for="radio-approve-$.">Approve<i class="fa fa-check" aria-hidden="true"></i></label>
      
      <input type="radio" id="radio-reject-$." name="allow" value="false">
      <label for="radio-reject-$.">Reject<i class="fa fa-times" aria-hidden="true"></i></label>
    </div>
    <input type="hidden" name="image" value="$p">
    <button type="submit" class="upload-manager-button">Confirm Decision</button>
  </form>
</li>
CARD_HTML
}
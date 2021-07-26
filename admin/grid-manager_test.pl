#!/usr/bin/perl -W
use strict;

use CGI qw(:all);
my $query = new CGI();

print "Content-type: text/html\n\n";

my @photos_file = <../htdocs/pending/*>;
my $index = 0;

# open(my $fh, '<', @photos_file) or die "Could not find any photos $!";

# my $count = `wc -l < $photos_file`;
# chomp($count);
my $count  = @photos_file;
if($count eq 0) {
   print "DIV CLASS='d-flex m-auto justify-content-center'>";
   print "<H1 CLASS='DISPLAY-4'> No images pending for approval.</H1>";
   print "<H1> Check back later? </H1>";
   print "</DIV>";
}
else {
foreach my $i (@photos_file) {   
chomp($i);
my $p = substr($i, 9);
print <<CARD_HTML;
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
CARD_HTML


$index++;
}



}






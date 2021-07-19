#!/usr/bin/perl -W
use strict;

use CGI qw(:all);
my $query = new CGI();

my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
my $index = 0;

open(my $fh, '<', $photos_file) or die "Could not find any photos $!";


while(my $p = <$fh>) {  
    print '<DIV class="card card-grid-item">';
    print '<IMG class="card-img-top" src="';
    print $p;
    print '" alt="image"/>';
    print '<DIV class="card-body text-center">';
    print '<FORM action="/cgi-bin/approve.cgi" method="POST">';
    print '<DIV class="form-group">';
    print '<DIV class="form-check form-check-inline">';
    print '<LABEL class="form-check-label m-1 btn btn-primary">';
    print '<INPUT class="form-check-input" type="radio" name="allow" id="allow_radio_true" value="true">';
    print '<SPAN class=""> Allow <I class="fa fa-check" aria-hidden="true"></I> </SPAN> </LABEL>';
    print '<LABEL class="form-check-label m-1 btn btn-outline-danger">';
    print '<INPUT class="form-check-input" type="radio" name="allow" id="allow_radio_false" value="false"> ';
    print '<SPAN class="">Reject <I class="fa fa-times" aria-hidden="true"></I></SPAN> </LABEL>';
    print '<INPUT type="hidden" name="image" value="';
    print $p;
    print '" /> </DIV> </DIV>';
    print '<DIV class="form-group"> <BUTTON type="submit" class="btn btn-dark">Submit</BUTTON> </DIV>';
    print '</FORM> </DIV></DIV>';    
}

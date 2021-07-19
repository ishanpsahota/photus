#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();


my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $index = 0;

open(my $fh, '<', $photos_file) or die "Could not find any photos $!";

print $query->header();
while(my $p = <$fh>) {    
    if($index % 3 == 0) {        
        print '<DIV class="grid-item">';
        print '<IMG src="';
        print $p;
        print '" class="grid-img" />';
        print '<DIV class="img-details">';
        print '<A href="';
        print $p;
        print '" download>';
        print '<BUTTON class="btn btn-light " type="button">';
        print '<i class="fa fa-download" aria-hidden="true"></i> </BUTTON>';        
        print '</A>';
        print '</DIV>';        
        print '</DIV>';        
    }
    $index += 1;      
}

print <<"HTML_BRIDGE";
</DIV>
<DIV class="grid-inner">
HTML_BRIDGE

$index = 0;
open(my $f1, '<', $photos_file) or die "Could not find any photos $!";
while( my $p1 = <$f1>) {
    if($index % 3 == 1) {        
        print '<DIV class="grid-item">';
        print '<IMG src="';
        print $p1;
        print '" class="grid-img" />';
        print '<DIV class="img-details">';
        print '<A href="'; 
        print $p1;
        print '" download>';
        print '<BUTTON class="btn btn-light " type="button">';
        print '<i class="fa fa-download" aria-hidden="true"></i> </BUTTON>';
        print '</A>';
        print '</DIV>';
        print '</DIV>';    
    }    
    $index += 1;        
}

print <<"HTML_BRIDGE";
</DIV>
<DIV class="grid-inner">
HTML_BRIDGE

$index = 0;    
open(my $f2, '<', $photos_file) or die "Could not find any photos $!";
while( my $p2 = <$f2>) {
    if($index % 3 == 2) {        
        print '<DIV class="grid-item">';
        print '<IMG src="'; 
        print $p2;
        print '" class="grid-img" />';
        print '<DIV class="img-details">';
        print '<A href="'; 
        print $p2;
        print '" download>';
        print '<BUTTON class="btn btn-light " type="button">';
        print '<i class="fa fa-download" aria-hidden="true"></i> </BUTTON>';
        print '</A>';
        print '</DIV>';
        print '</DIV>';             
    }    
    $index += 1;           
}

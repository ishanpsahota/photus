#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();


my @photos_file = <../htdocs/uploads/*>;
my $index = 0;

print $query->header();

my $count = `wc -l < @photos_file`;
chomp($count);
if($count eq 0) {
   print "<DIV CLASS='d-flex m-auto justify-content-center'>";
   print "<H1 CLASS='DISPLAY-4'> No images pending for approval.</H1>";
   print "<H1> Check back later? </H1>";
   print "<H4> Check <A href='/admin/visitors-log.shtml'> Visitors Log </A> </H4>"
   print "</DIV>";
}
else {
foreach my $i (@photos_file) {   
    chomp($i);
    my $p = substr($i, 9);
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
# open(my $f1, '<', $photos_file) or die "Could not find any photos $!";
foreach my $j (@photos_file) {
# while( my $p1 = <$f1>) {    
    chomp($j);
    my $p1 = substr($j, 9);
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
# open(my $f2, '<', $photos_file) or die "Could not find any photos $!";
# while( my $p2 = <$f2>) {
foreach my $k (@photos_file) {
    chomp($k);
    my $p2 = substr($k, 9);
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



}



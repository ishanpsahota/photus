#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();
print "Content-Type: text/html\n\n";


print <<"HTML_START";
<HTML>
<HEAD>
<TITLE> Photus | Photo Grid Website </TITLE>
<META charset="utf-8">
<META name="viewport" content="width=device-width, initial-scale=1">
<LINK rel="icon" href="/assets/logos/photus-d.png"; />
<LINK rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<SCRIPT src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></SCRIPT>
<SCRIPT src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></SCRIPT>
<SCRIPT src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></SCRIPT>        
<LINK rel="stylesheet" href="/assets/styles/style.css"; />
<LINK rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">        
</HEAD>
<BODY>
<DIV class="container-fluid home-wrapper">            
<DIV class="row header-wrapper">
<NAv class="navbar navbar-light bg-light w-100 ">
<A class="navbar-brand" href="/">
<IMG src="/assets/logos/photus-d.png" class="logo" />
</A>                                       
<UL class="navbar-nav ml-auto mt-2 mt-lg-0">
<LI class="nav-item">                   
<A class="" href="/upload.html">
<BUTTON type="button" class="btn btn-outline-primary " data-toggle="modal" data-target="#uploadImg">
Upload &nbsp; <I class="fa fa-upload" aria-hidden="true"></I>
</BUTTON>
</A>                                     
</LI>                            
</UL>                                                                           
</NAV>                            
</DIV>            
<DIV class="main-wrapper row">
<DIV class="grid-container">
<DIV class="grid-inner">
HTML_START


my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $index = 0;

open(my $fh, '<', $photos_file) or die "Could not find any photos $!";


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


print <<"HTML_END";
</DIV>
</DIV>
</DIV>
<DIV class="footer-wrapper row text-center text-md-left d-flex flex-column flex-md-row">                
<H4>
Photus
</H4>
<UL class="list-group list-group-horizontal  ml-md-auto">                                            
<LI class="list-group-item">
Ishan Prasad
</LI>
<LI class="list-group-item">
Jad Al-Tahan
</LI>
<LI class="list-group-item">
Simran Kaur
</LI>
</UL>                
</DIV>                                            
</DIV>
</BODY>
</HTML>
HTML_END



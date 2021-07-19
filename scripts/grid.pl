#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();
print "Content-Type: text/html\n\n";


print <<"HTML_START";
<HTML>
<HEAD>
<TITLE> Grid | Photus | Photo Grid Website </TITLE>
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
<nav class="navbar bg-light w-100 ">
<a class="navbar-brand" href="/">
<svg viewBox="0 0 31 45" width="32px" height="32px"><path d="M15.5,0A15.5,15.5,0,0,0,0,15.5H0V43.3A1.7,1.7,0,0,0,1.7,45h.364a1.7,1.7,0,0,0,1.7-1.7V25.6A15.5,15.5,0,1,0,15.5,0Zm0,27.242A11.742,11.742,0,1,1,27.242,15.5,11.742,11.742,0,0,1,15.5,27.242Z" fill="#303952"/><path d="M13.053,14.088,17.537,6.32A9.325,9.325,0,0,0,9.552,8.211L13,14.182Z" fill="#303952"/><path d="M12.239,15.5,8.569,9.148A9.374,9.374,0,0,0,6.089,15.5a9.474,9.474,0,0,0,.189,1.882h7.048Z" fill="#303952"/><path d="M24.478,12.677A9.431,9.431,0,0,0,18.836,6.71l-3.444,5.967Z" fill="#303952"/><path d="M24.723,13.618H17.674l.273.47,4.484,7.764a9.376,9.376,0,0,0,2.48-6.352A9.549,9.549,0,0,0,24.723,13.618Z" fill="#303952"/><path d="M17.128,18.323l-3.67,6.357a9.336,9.336,0,0,0,7.99-1.891L18,16.817Z" fill="#303952"/><path d="M6.522,18.323a9.431,9.431,0,0,0,5.642,5.967l3.444-5.967Z" fill="#303952"/></svg>
</a>                                       
<ul class="navbar-nav ml-auto list-group-horizontal mt-2 mt-lg-0">
<li class="nav-item mx-1">                   
<a href="/">
<button type="button" class="btn btn-outline-dark">
<span>Home</span><i class="fa fa-home" aria-hidden="true"></i>
</button>
</a>                                     
</li> 
<li class="nav-item mx-1">                   
<a class="" href="/upload.html">
<button type="button" class="btn btn-outline-primary " data-toggle="modal" data-target="#uploadImg">
<span>Upload</span><i class="fa fa-upload" aria-hidden="true"></i>
</button>
</a>                                     
</li>                             
</ul>                                                                           
</nav>                                              
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
<script src="/assets/js/app.js" charset="utf-8"></script>
</BODY>
</HTML>
HTML_END



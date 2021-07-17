#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();
print "Content-Type: text/html\n\n";


print <<"HTML_START";
<html>
<head>
<title> Home | Admin | Photo Grid Website </title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="/assets/logos/photus-d.png"; />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>        
<link rel="stylesheet" href="/assets/styles/style.css"; />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">        
</head>
<body>
<div class="container-fluid home-wrapper">            
<div class="row header-wrapper">
<nav class="navbar navbar-light bg-light w-100 ">
<a class="navbar-brand" href="/admin/home.html">
<img src="/assets/logos/photus-d.png" class="logo" />
</a>    
<strong class="mx-auto">
Admin Panel
</strong>                                                                   
<div class="btn-group">
<button class="btn btn-dark dropdown-toggle" type="button" id="admin_nav_menu" data-toggle="dropdown" aria-haspopup="true"
aria-expanded="false">
Menu 
</button>
<div class="dropdown-menu dropdown-menu-right text-center" aria-labelledby="admin_nav_menu">
<a class="dropdown-item" href="services.html">Services </a>                            
<a class="dropdown-item" href="/grid.html">Grid </a>                            
</div>
</div>
</nav>                            
</div>            
<div class="main-wrapper row text-center">
<h1 class="display-2 mx-auto my-1"> Grid </h1>
<div class="card-columns col-12">
HTML_START


my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
my $index = 0;

open(my $fh, '<', $photos_file) or die "Could not find any photos $!";


while(my $p = <$fh>) {   
    if(length($p) > 0) {
        print '<div class="card card-grid-item">';
        print '<img class="card-img-top" src="';
        print $p;
        print '" alt="image"/>';
        print '<div class="card-body text-center">';
        print '<form action="/cgi-bin/approve.cgi" method="POST">';
        print '<div class="form-group">';
        print '<div class="form-check form-check-inline">';
        print '<label class="form-check-label m-1 btn btn-primary">';
        print '<input class="form-check-input" type="radio" name="allow" id="allow_radio_true" value="true">';
        print '<span class=""> Allow <i class="fa fa-check" aria-hidden="true"></i> </span> </label>';
        print '<label class="form-check-label m-1 btn btn-outline-danger">'
        print '<input class="form-check-input" type="radio" name="allow" id="allow_radio_false" value="false"> '
        print '<span class="">Reject <i class="fa fa-times" aria-hidden="true"></i></span> </label>'
        print '<input type="hidden" name="image" value="';
        print $p;
        print '" /> </div> </div>'
        print '<div class="form-group"> <button type="submit" class="btn btn-dark">Submit</button> </div>';
        print '</form> </div></div>';
    }
}

print <<"HTML_END";
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



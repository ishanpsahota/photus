#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();
print "Content-Type: text/html\n\n";


print <<"HTML_START";
<HTML>
<HEAD>
<TITLE> Home | Admin | Photo Grid Website </title>
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
<NAV class="navbar navbar-light bg-light w-100 ">
<A class="navbar-brand" href="/admin/home.html">
<IMG src="/assets/logos/photus-d.png" class="logo" />
</A>    
<STRONG class="mx-auto">
Admin Panel
</STRONG>                                                                   
<DIV class="btn-group">
<BUTTON class="btn btn-dark dropdown-toggle" type="button" id="admin_nav_menu" data-toggle="dropdown" aria-haspopup="true"
aria-expanded="false">
Menu 
</BUTTON>
<DIV class="dropdown-menu dropdown-menu-right text-center" aria-labelledby="admin_nav_menu">
<A class="dropdown-item" href="services.html">Services </A>       
<A class="dropdown-item" href="/grid.html">Grid </A>                            
</DIV>
</DIV>
</nav>                            
</DIV>            
<DIV class="main-wrapper row text-center">
<H1 class="display-2 mx-auto my-1"> Grid </H1>
<DIV class="card-columns col-12">
HTML_START


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
    print '<SPAN class=""> Allow <i class="fa fa-check" aria-hidden="true"></i> </SPAN> </LABEL>';
    print '<LABEL class="form-check-label m-1 btn btn-outline-danger">'
    print '<INPUT class="form-check-input" type="radio" name="allow" id="allow_radio_false" value="false"> '
    print '<SPAN class="">Reject <i class="fa fa-times" aria-hidden="true"></i></SPAN> </LABEL>'
    print '<INPUT type="hidden" name="image" value="';
    print $p;
    print '" /> </DIV> </DIV>'
    print '<DIV class="form-group"> <BUTTON type="submit" class="btn btn-dark">Submit</BUTTON> </DIV>';
    print '</FORM> </DIV></DIV>';    
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



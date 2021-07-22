#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();
print "Content-Type: text/html\n\n";


print <<"HTML_START";
<HTML>
<HEAD>
<TITLE> Visitors | Admin | Photo Grid Website </TITLE>
<META charset="utf-8">
<META name="viewport" content="width=device-width, initial-scale=1">
<LINK rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
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
<A class="navbar-brand" href="/admin/">
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
<A class="dropdown-item" href="visitors.pl">Services </A>                            
<A class="dropdown-item" href="/grid.html">Grid </A>                            
</DIV>
</DIV>
</nav>                            
</DIV>            
<DIV class="main-wrapper row text-center">
<DIV class="justify-content-center col-12">
<H1 class="display-3"> Visitors  </H1>
HTML_START


# Open file.
my $file = "/home/stud1034/apacheSSL/logs/access_log";

if( ! open( FILE, "$file" ) ) {
	print( "Could not open $file\n" );
	exit;
}

my @array;
my @tempor;

print <<"HTML_BRIDGE";
<DIV class="m-auto w-100 d-flex flex-column">
<TABLE class="table table-striped m-auto table-inverse  table-responsive">
<THEAD class="thead-inverse">
<TR class="">
<TH>IP Address</TH>
<TH> Date &nbsp; <I class="fa fa-calendar" aria-hidden="true"></I> </TH>
<TH> File accessed </TH>
</TR>
</THEAD>
<TBODY>
HTML_BRIDGE


while( <FILE> ) {
	if( $_ =~ /GET/ ) {
		@array = split( / /, $_ );
		if (( $array[6] eq "/") || ($array[6] =~ /html/)){	
            print '<TR>';
            print '<TD scope="row" >', $array[0], '</TD>';

            @tempor = split(/\[/, $array[3]);
            print '<TD>', @tempor ,'</TD>';

            if( $array[6] eq "/" ){
                print "<TD> <CODE> index.html </CODE> </TD>\n";
            }
            else {
                print "<TD>", $array[6], "</TD>\n";
            }
            print '</TR>';                                
        }
    }
}

close( FILE );
print <<"HTML_END";
</TBDOY>
</TABLE>
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
Jad Altahan
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



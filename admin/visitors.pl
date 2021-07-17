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
<div class=" col-12">
<h1 class=""> Visitors  </h1>
HTML_START


# Open file.
my $file = "/home/stud1034/apacheSSL/logs/access.log";

if( ! open( FILE, "$file" ) ) {
	print( "Could not open $file\n" );
	exit;
}

my @array;
my @tempor;

print <<"HTML_BRIDGE";
<TABLE class="table table-striped m-auto table-inverse  table-responsive">
<THEAD class="thead-inverse">
<tr class="">
<th>IP Address</th>
<th> Date &nbsp; <i class="fa fa-calendar" aria-hidden="true"></i> </th>
<th> File accessed </th>
</tr>
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
                print "<TD> <code> index.html </code> </TD>\n";
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
</div>                
</div>        
<div class="footer-wrapper row text-center text-md-left d-flex flex-column flex-md-row">                
<h4>
Photus
</h4>
<ul class="list-group list-group-horizontal  ml-md-auto">                                            
<li class="list-group-item">
Ishan Prasad
</li>
<li class="list-group-item">
Jad Al-Tahan
</li>
<li class="list-group-item">
Simran Kaur
</li>
</ul>                
</div>                                            
</div>
</body>
</html>
HTML_END



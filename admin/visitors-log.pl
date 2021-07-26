#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
my $query = new CGI();

print "Content-type: text/html\n\n";

# Open file.
my $file = "/home/stud1034/apacheSSL/logs/access_log";

if( ! open( FILE, "$file" ) ) {
	print( "Could not open $file\n" );
	exit;
}

my @array;
my @tempor;

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

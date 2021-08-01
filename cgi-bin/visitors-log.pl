#!/usr/bin/perl

use strict;
use warnings;

print "Content-type: text/html\n\n";

my $accessLog = "../logs/access_log";

open(FILE, "-|", "tac", "$accessLog") or do {
  print "<h1>Fatal Error</h1>";
  print "<p>Could not open file '$accessLog'.</p>";
  exit;
};

my @content;
my @tempor;

while (<FILE>) {
  if ($_ =~ /GET/) {
    @content = split(/ /, $_);

    if (($content[6] eq "/") || ($content[6] =~ /html/)) {  
      print "<tr>";
      print "<td scope=\"row\" >", $content[0], "</td>";

      @tempor = split(/\[/, $content[3]);
      print "<td>", @tempor, "</td>";

      if ($content[6] eq "/") {
          print "<td><code>index</code></td>";
      } else {
          print "<td>", $content[6], "</td>";
      }
      print '</tr>';
    }

    # last if $. == (10*3);
  }
}

close(FILE);
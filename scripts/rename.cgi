#!/usr/bin/perl -w

use strict;

my @imgs = <../htdocs/deleted/*>;

my $newname = "";

foreach my $i (@imgs) {
	my @p = split("/", $i);
	my $image = $p[3];
	print "$image\n";
	my @ext = split /\./, $image;
	print @ext;
	foreach my $c (@ext) { print "$c\n"; }
	$newname = `(date +'%Y%m%d_%H%M%S_' && openssl rand -hex 2) | tr -d '\n'`;
	my $file = $newname . "." . $ext[1];
	print "$newname\n";
	print "$file\n";
	$newname = "";
	}



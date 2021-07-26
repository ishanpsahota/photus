#!/usr/bin/perl -W

use strict;

use CGI qw(:all);

my $query = new CGI();

my $img = $query->param('image');

my $pending_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $upload_dir = "/home/stud1034/apacheSSL/htdocs";
my $image_approval = $query->param('allow');


print "Content-type: text/html\n\n";

if(not defined $img) {
    die qq("No image data received.\n");
}

if(not defined $pending_file) {
    die qq(Not able to match images.\n);
}

if(not defined $photos_file) {
    die qq(Can't save changes.\n);
}

approveFile($img, $image_approval);

sub approveFile {
    my $image = shift;
    my $approve = shift;    
	   
    print "$image\n<br/>";

    if($approve eq 'true') {
        print "Approved\n<br/>";
        updateGridFile($image);
        updatePendingFile($image);        
    }

    if($approve eq 'false') {
        print "Rejected\n</br>";
        updatePendingFile($image);
        removeImageFile($image);
    }
}

sub updateGridFile {
    my $image = shift;
    open(my $update_grid_file, ">>", $photos_file) or die "Can't update the grid. $!\n";
    print $update_grid_file "$image\n";
    close $update_grid_file;
    print "Image approved\n";
}

sub updatePendingFile {

    my $image = shift;

    open( my $pending_file_handler, "<", $pending_file )
       or die qq(Cannot update the manager: $!\n); 

    my @entries = <$pending_file_handler>; 
    close( $pending_file_handler ); 
	
    open( my $update_upload, ">", $pending_file ) or die qq(Can't make the final changes: $!\n);        
    chomp($image);
    
    foreach my $imgs ( @entries ) {                	    
	    chomp($imgs);
	    print "S: $image <br/>";
	    print "A: $imgs <br/>";
	    print {$update_upload} "$imgs\n" unless ( ($imgs eq $image) or ($imgs =~ m/$image/) ); 
    } 

    close( $update_upload );
    print "Removed\n<br/>";
}

sub removeImageFile {
    my $image = shift;
    unlink($upload_dir . $image);
}



print "\nFile review done. Go <a href='/admin/grid-manager.shtml'> back </a> to Grid Manager.\n";

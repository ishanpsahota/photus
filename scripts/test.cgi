#!/usr/bin/perl -W

use strict;

use CGI qw(:all);

my $query = new CGI();

my $img = "https://images.unsplash.com/photo-1536329583941-14287ec6fc4e?ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwzMHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";

my $pending_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $upload_dir = "/home/stud1034/apacheSSL/htdocs";
my $image_approval = 'true';


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

open (my $upload, "+<$pending_file") or die "$!";
my @upload_imgs = <$upload>; 
close( $upload ); 

approveFile($img, $image_approval);

sub approveFile {
    my $image = shift;
    my $approve = shift;

    if($approve eq 'true') {
        print "H\n";
        updateGridFile($image);
        updatePendingFile($image);        
    }

    if($approve eq 'false') {
        print "NH";
        updatePendingFile($image);
        removeImageFile($image);
    }
}

sub updateGridFile {
    my $image = shift;
    open(my $update_grid_file, ">>", $photos_file) or die qq(Can't update the grid. $!\n);
    print $update_grid_file  "$image\n";
    close $update_grid_file;
    print "Image approved\n";
}

sub updatePendingFile {

    my $image = shift;

    open( my $update_upload, ">", $pending_file ) or die qq(Can't make the final changes: $!\n);

    foreach my $i ( @upload_imgs ) { 
        print {$update_upload} $i unless ( $i =~ /$image/ ); 
    } 
    close( $update_upload );
    print "Removed\n";
}

sub removeImageFile($img) {
    unlink($img);
    print "File removed.\n";
}


# while(my $i = <$upload>) {    
#     if($i =~ /$img\n/) {
#         if($image_approval eq 'true') {
#             print "h";
#             print "File accepted.\n";
#             OPEN(my $photos, ">>", $photos_file) or die "Can't save the changes!\n";
#             print $photos  "$img\n";
#             close $photos;
#             $i =~ s/$img\n/""/;
#             close $upload;
#             last;
#         }

#         if($image_approval eq 'false') {
#             print "nh";
#             print "File rejected.\n";
#             $i =~ s/$img\n/""/;
#             close $upload;
#             last;
#         }
#     }
# }

# removeTime( "john", "times.txt" ); 

# sub removeTime { 
#     my $name      = shift;
#     my $time_file = shift;

#     if (not defined $time_file) {
#         #Make sure that the $time_file was passed in too.
#         die qq(Name of Time file not passed to subroutine "removeTime"\n);
#     }

#     # Read file into an array for processing
#     open( my $read_fh, "<", $time_file )
#        or die qq(Can't open file "$time_file" for reading: $!\n); 

#     my @file_lines = <$read_fh>; 
#     close( $read_fh ); 

#     # Rewrite file with the line removed
#     open( my $write_fh, ">", $time_file )
#         or die qq(Can't open file "$time_file" for writing: $!\n);

#     foreach my $line ( @file_lines ) { 
#         print {$write_fh} $line unless ( $line =~ /$name/ ); 
#     } 
#     close( $write_fh ); 

#     print( "Reservation successfully removed.<br/>" ); 
# }


print "\nFile review done. Go <a href='/admin/grid-manager.shtml'> back </a> to Grid Manager.\n";

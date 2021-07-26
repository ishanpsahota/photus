#!/usr/bin/perl -W

use strict;

use CGI qw(:all);
use File::Copy;

my $query = new CGI();

my $img = $query->param('image');

# my $pending_file = "/home/stud1034/apacheSSL/cgi-bin/pending.txt";
# my $photos_file = "/home/stud1034/apacheSSL/cgi-bin/photos.txt";
my $upload_dir = "/home/stud1034/apacheSSL/htdocs/upload";
my $pending_dir = "/home/stud1034/apacheSSL/htdocs/pending";
my $home_dir = "/home/stud1034/apacheSSL/htdocs";
my $image_approval = $query->param('allow');

my @pending_imgs = <../htdocs/pending/*>;
my @uploaded_imgs = <../htdocs/uploads/*>;

my $pending_count = @pending_imgs;
my $uploaded_count = @uploaded_imgs;

print "Content-type: text/html\n\n";

if($pending_count eq 0) {
    print "No images pending for approval.\n";
    die qq("No images pending for approval.\n")
}

if(not defined $img) {
    print "No image data received.\n";
    die qq("No image data received.\n");
}

if(not -d $upload_dir) {
    die qq("Cannot process the upload.\n");
}

if(not -d $pending_dir) {
    die qq("Cannot process the request.\n");
}

# if(not defined $pending_file) {
#     die qq(Not able to match images.\n);
# }

# if(not defined $photos_file) {
#     die qq(Can't save changes.\n);
# }

approveFile($img, $image_approval);

sub approveFile {
    my $image = shift;
    my $approve = shift;    
	   
    print "$image\n<br/>";

    if($approve eq 'true') {
        print "Approved\n<br/>";
        moveFile($image);
    }

    if($approve eq 'false') {
        print "Rejected\n</br>";
        removeImageFile($image);
    }
}

sub moveFile {
    my $image = shift;
    foreach my $iter (@pending_imgs) {        
        my $pf = substr($iter, 10);
        print $pf;
        if($pf eq $image) {
            my $from = $home_dir . $img;
            move ($from, $upload_dir) or print "Move failed: $!\n";
            last;
        }
    }

    my @t = split("/", $img);

    if(-e $upload_dir . "/" . @t[1]) {
        print "File moved successfully.\n";
    }
}

sub removeImageFile {
    my $image = shift;
    unlink($upload_dir . $image) or print "Failed to delete file.\n";
}



print "\nFile review done. Go <a href='/admin/grid-manager.shtml'> back </a> to Grid Manager.\n";

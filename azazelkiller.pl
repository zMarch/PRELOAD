#!/usr/bin/perl
use strict;
use warnings;
local $/ = undef;
my $key;

#here be dragons
sub main ()
{
&unpackxor(&readin(&arguments));
#lol
exit();
}

sub arguments ()
{
if (@ARGV == 1 || @ARGV == 2) {
	if (-f $ARGV[0]) {
		$key = $ARGV[1];
		if ($key eq "") {
		$key = "0xfe";
			}
		return $ARGV[0];
		}
	else {
	print ("The file specified doesn't exist.\n");
	exit ();
		} 	
	}
else {
	print "Supply an absolute path to a file and optionally an 0x XOR key.\nThanks.\n";
	exit();
	}
}

sub readin ()
{
open FILE, $_[0] or die("File exists, but we can't read it. Dying");
binmode FILE;
my $t = unpack("H*",<FILE>);
close FILE;
if ($t eq "") {
	print "Empty file.\n";
	exit();
	}
return $t;
}

sub unpackxor ()
{
my ($bbb) = $_[0] =~ m/73696e2e00(.*?)ffff/;
if ($bbb eq "") {
	print "This isn't azazel!\n";
	exit();
	}
my @baa = split(/00/, $bbb);
foreach my $baa(@baa) {
        my @hex = unpack("(A2)*",$baa);
        foreach my $hex(@hex)
                {
		$hex = chr(hex($hex) ^ hex($key));
                if ($hex =~ m/[a-zA-Z0-9]/ || $hex eq "=" || $hex eq "."||  $hex eq "/" || $hex eq "_" ) {
                print "$hex";
                        }
                }
        print "\n";
	}
}

&main ();

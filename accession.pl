#!/usr/bin/perl
use strict;
use warnings;

unless (2 == scalar(@ARGV)) {
   die "Usage: $0 chrom_CDS_4.txt data.csv\n"; 
}  
 
open(IN, $ARGV[0])
      or die "Unable to open input file $ARGV[0]\n";  
open(OUT, ">$ARGV[1]")
      or die "Unable to open output file $ARGV[1]\n";  
 

my %acc_org;
my $accession = "";
my $organism = "";


while (my $line = <IN>) {     
  if ($line =~ /\/organism=\"(.*)\"/){
   $organism = $1;
   }
  
  if ($line =~ /ACCESSION\s+([A-Z]+[0-9]+)\n/g) {
    $accession = $1;
    $acc_org{$accession} = $organism;
   }
}

foreach $accession (keys %acc_org) {
    print OUT "$accession = $acc_org{$accession}\n";

} 

close(IN); 
close(OUT);

#!/usr/bin/perl
	use strict;
	use warnings;
	use 5.010;

package Mods::Manipulations;

sub nucToAmino {
	my $nuc = shift;
	my $protein = "";
	my %translation = qw(
	TCA  S  TCC  S  TCG  S  TCT  S  TTC  F  TTT  F  TTA  L  TTG  L
    TAC  Y  TAT  Y  TAA  -  TAG  -  TGC  C  TGT  C  TGA  -  TGG  W
    CTA  L  CTC  L  CTG  L  CTT  L  CCA  P  CCC  P  CCG  P  CCT  P
    CAC  H  CAT  H  CAA  Q  CAG  Q  CGA  R  CGC  R  CGG  R  CGT  R
    ATA  I  ATC  I  ATT  I  ATG  M  ACA  T  ACC  T  ACG  T  ACT  T
    AAC  N  AAT  N  AAA  K  AAG  K  AGC  S  AGT  S  AGA  R  AGG  R
    GTA  V  GTC  V  GTG  V  GTT  V  GCA  A  GCC  A  GCG  A  GCT  A
    GAC  D  GAT  D  GAA  E  GAG  E  GGA  G  GGC  G  GGG  G  GGT  G
    );

    while ($nuc =~ /(.{3})/g) {
    	exists $translation{$1} or die "Not a codon $1\n";
    	$protein .= $translation{$1};
    }

    say $protein;
}

sub countAA {
	my $seq = shift;
	my %aacount;
	my @aa = qw(
	A R N D C Q E G H I L K M F P S T W Y V
    );

    foreach my $acid (@aa) {
    	my $count = () = $seq =~ /$acid/g;
    	$aacount{$acid} = $count;
    }

	foreach my $key (sort {$aacount{$b} <=> $aacount{$a}} keys %aacount) {
	   say "$key = $aacount{$key}"; 
	}
}

sub countNT {
	my $seq = shift;
	my %ntcount;
	my @aa = qw(
	A T C G
    );

    foreach my $nt (@aa) {
    	my $count = () = $seq =~ /$nt/g;
    	$ntcount{$nt} = $count;
    }

	foreach my $key (sort {$ntcount{$b} <=> $ntcount{$a}} keys %ntcount) {
	   say "$key = $ntcount{$key}"; 
	}
}

1;



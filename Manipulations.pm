#!/usr/bin/perl
	use strict;
	use warnings;
	use 5.010;

package Mods::Manipulations;

sub nucAndAmino {
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

    say "Nucleotide sequence";
    say $nuc;
    say "Amini acid sequence";
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

sub countCodon {
    my $seq = shift;

    my %aminoacids = (
        a =>{
                'GCA' => 0,
                'GCC' => 0,
                'GCG' => 0,
                'GCT' => 0
            },
        r =>{
                'CGA' => 0,
                'CGC' => 0, 
                'CGG' => 0, 
                'CGT' => 0, 
                'AGA' => 0, 
                'AGG' => 0
            },
        n =>{
                'AAC' => 0,
                'AAT' => 0
            },
        d =>{
                'GAC' => 0,
                'GAT' => 0
            },
        c =>{
                'TGC' => 0, 
                'TGT' => 0
            },
        q =>{
                'CAA' => 0, 
                'CAG' => 0
            },
        e =>{
                'GAA' => 0, 
                'GAG' => 0
            },
        g =>{
                'GGA' => 0,
                'GGC' => 0,
                'GGG' => 0,
                'GGT' => 0
            },
        h =>{
                'CAC' => 0, 
                'CAT' => 0
            },
        i =>{
                'ATA' => 0, 
                'ATC' => 0, 
                'ATT' => 0
            },
        l =>{
                'TTA' => 0, 
                'TTG' => 0, 
                'CTA' => 0, 
                'CTC' => 0, 
                'CTG' => 0,  
                'CTT' => 0
            },
        k =>{
                'AAA' => 0, 
                'AAG' => 0
            },
        m =>{
                'ATG' => 0
            },
        f =>{
                'TTC' => 0, 
                'TTT' => 0
            },
        p =>{
                'CCA' => 0, 
                'CCC' => 0, 
                'CCG' => 0, 
                'CCT' => 0
            },
        s =>{
                'TCA' => 0, 
                'TCC' => 0, 
                'TCG' => 0, 
                'TCT' => 0, 
                'AGC' => 0, 
                'AGT' => 0
            },
        t =>{
                'ACA' => 0, 
                'ACC' => 0, 
                'ACG' => 0, 
                'ACT' => 0
            },
        w =>{
                'TGG' => 0
            },
        y =>{
                'TAC' => 0, 
                'TAT' => 0
            },
        v =>{
                'GTA' => 0, 
                'GTC' => 0, 
                'GTG' => 0, 
                'GTT' => 0
            },
        stop =>{
                'TAA' => 0, 
                'TAG' => 0, 
                'TGA' => 0
                },
        );

    while ($seq =~ /(.{3})/g) {
        foreach my $amino (keys %aminoacids) {
            foreach my $codon (%{$aminoacids{$amino}}) {
                if ($codon eq $1) {
                    $aminoacids{$amino}{$1}++;;
                }
            }
        }
    }

    foreach my $key (sort keys %aminoacids) {
        say "$key amino acids are:";
        foreach my $cdn (%{$aminoacids{$key}}) {
            say $cdn;
        }
    }
}

sub overallCodon {
    my $db = "SELECT sequence FROM whereever";
    my $seq = $db;
    my %aminoacids = (
        a =>{
                'GCA' => 0,
                'GCC' => 0,
                'GCG' => 0,
                'GCT' => 0
            },
        r =>{
                'CGA' => 0,
                'CGC' => 0, 
                'CGG' => 0, 
                'CGT' => 0, 
                'AGA' => 0, 
                'AGG' => 0
            },
        n =>{
                'AAC' => 0,
                'AAT' => 0
            },
        d =>{
                'GAC' => 0,
                'GAT' => 0
            },
        c =>{
                'TGC' => 0, 
                'TGT' => 0
            },
        q =>{
                'CAA' => 0, 
                'CAG' => 0
            },
        e =>{
                'GAA' => 0, 
                'GAG' => 0
            },
        g =>{
                'GGA' => 0,
                'GGC' => 0,
                'GGG' => 0,
                'GGT' => 0
            },
        h =>{
                'CAC' => 0, 
                'CAT' => 0
            },
        i =>{
                'ATA' => 0, 
                'ATC' => 0, 
                'ATT' => 0
            },
        l =>{
                'TTA' => 0, 
                'TTG' => 0, 
                'CTA' => 0, 
                'CTC' => 0, 
                'CTG' => 0,  
                'CTT' => 0
            },
        k =>{
                'AAA' => 0, 
                'AAG' => 0
            },
        m =>{
                'ATG' => 0
            },
        f =>{
                'TTC' => 0, 
                'TTT' => 0
            },
        p =>{
                'CCA' => 0, 
                'CCC' => 0, 
                'CCG' => 0, 
                'CCT' => 0
            },
        s =>{
                'TCA' => 0, 
                'TCC' => 0, 
                'TCG' => 0, 
                'TCT' => 0, 
                'AGC' => 0, 
                'AGT' => 0
            },
        t =>{
                'ACA' => 0, 
                'ACC' => 0, 
                'ACG' => 0, 
                'ACT' => 0
            },
        w =>{
                'TGG' => 0
            },
        y =>{
                'TAC' => 0, 
                'TAT' => 0
            },
        v =>{
                'GTA' => 0, 
                'GTC' => 0, 
                'GTG' => 0, 
                'GTT' => 0
            },
        stop =>{
                'TAA' => 0, 
                'TAG' => 0, 
                'TGA' => 0
                },
        );

    while ($seq =~ /(.{3})/g) {
        foreach my $amino (keys %aminoacids) {
            foreach my $codon (%{$aminoacids{$amino}}) {
                if ($codon eq $1) {
                    $aminoacids{$amino}{$1}++;;
                }
            }
        }
    }

    foreach my $key (sort keys %aminoacids) {
        say "$key amino acids are:";
        foreach my $cdn (%{$aminoacids{$key}}) {
            say $cdn;
        }
    }
}

sub getSequence {
    my $gene = shift
    say "SELECT sequence FROM whereever WHERE gene = $gene";
    #highlighting mechanism
}

sub getRestrictionEnzymes {
    my $seq = shift;
    my $before = "";
    my $after = "";
    my %re = (
        ecori =>{
                    'GAATTC' => 0,
                    'CTTAAG' => 0
                },
        bamhi =>{
                    'GGATCC' => 0,
                    'CCTAGG' => 0
                },
        bsumi =>{
                    'CTCGAG' => 0,
                    'GAGCTC' => 0
                },
        );
    my @enzymes;

    # capture strings
        if ($seq =~ /^(.*)ATG/) {
            $before = $1;
        }
        if ($seq =~ /(TAG|TAA|TGA)(.*)/) {
            $after = $2;
        }
    
    # if value returned is one, only 1 site found
    # if value returned is two, a before and after site have been found
    foreach my $enzyme (keys %re) {
        foreach my $site (%{$re{$enzyme}}) {
            if ($before =~ /$site/) {
                $re{$enzyme}{$site}++;
            }
            if ($after =~ /$site/) {
                $re{$enzyme}{$site}++;
            }            
        }
    }

    foreach my $enzyme (keys %re) {
        foreach my $site (%{$re{$enzyme}}) {
            if ($re{$enzyme}{$site} == 2) {
                push (@enzymes, $enzyme) unless ($enzyme ~~ @enzymes);
            }  
        }
    }

    say @enzymes;
}

1;

#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Database; # or Database    , depending on location

package Mods::Core;

### Takes a gene ID(scalar) and returns a string of the whole gene
sub getSequence {
    my $geneid = shift;
    
    # change 
    my $seq = Mods::Database::getSQLResult("seq", "gene", "gene_id", "$geneid");
    return $seq;
}

### Takes a gene ID(scalar) and returns an array of coding regions
sub getCodingRegions {
    my $geneid = shift;
    my @codingregions;
    
    # change 
    my $seq = Mods::Database::getSQLResult("seq", "gene", "gene_id", "$geneid");
    my $regions = Mods::Database::getSQLResult("coding_regions", "gene", "gene_id", "$geneid");
    my $generange = Mods::Database::getSQLResult("gene_loc", "gene", "gene_id", "$geneid"); 

    my @location;
    while ($regions =~ /([0-9]+..[0-9]+)/g) {
        push (@location, $1);
    }

    my $genestart;
    if ($generange =~ /([0-9]+)..[0-9]+/) {
        $genestart = $1 -1;
    }
    
    foreach my $loc (@location) {
        my $start;
        my $end;
        my $offset;

        if ($loc =~ /[0-9]+..([0-9]+)/) {
            $end = $1; 
        }
        if ($loc =~ /([0-9]+)..[0-9]+/) {
            $start = $1;
            $offset = ($end - $start);
        }

        my $temp = substr($seq, (($start - $genestart)- 1), ($offset +1));
        push (@codingregions, $temp);
    }
    return @codingregions;
}

### Takes a gene ID(scalar) and returns a string of the whole amino acid
sub getAminoAcid {
    my $geneid = shift;
    
    # change 
    my $seq = Mods::Database::getSQLResult("aa_seq", "amino_acid", "gene_id", "$geneid");
    return $seq;
}

### Takes a gene ID(scalar) and returns a string of the coding sequence
sub getCodingSequence {
    my $geneid = shift;
    my @regions = getCodingRegions($geneid);

    my $seq = join("", @regions);

    return $seq; 
}

### Takes a gene ID(scalar) and returns a hash containing the counts (including stops)
sub countCodon {
    my $geneid = shift;
    my $seq = getCodingSequence($geneid);    
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

    $seq =~ tr/atcg/ATCG/;

    while ($seq =~ /(.{3})/g) {
        foreach my $amino (keys %aminoacids) {
            foreach my $codon (%{$aminoacids{$amino}}) {
                if ($codon eq $1) {
                    $aminoacids{$amino}{$1}++;;
                }
            }
        }
    }
    return %aminoacids;

    # foreach my $key (sort keys %aminoacids) {
    #     say "$key amino acids are:";
    #     foreach my $cdn (%{$aminoacids{$key}}) {
    #         say $cdn;
    #     }
    # }
}

### Rturns a hash containing the counts of all sequences in the database (including stops)
sub countAllCodon {
    my @allseqs = Mods::Database::getSQLAll("seq", "gene");
    my $seq = join("", @allseqs);

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

    $seq =~ tr/atcg/ATCG/;

    while ($seq =~ /(.{3})/g) {
        foreach my $amino (keys %aminoacids) {
            foreach my $codon (%{$aminoacids{$amino}}) {
                if ($codon eq $1) {
                    $aminoacids{$amino}{$1}++;;
                }
            }
        }
    }
    return %aminoacids;
}

### Takes a gene ID(scalar) and retruns an array containing the restriction enzymes usable
sub getRestrictionEnzymes {
    my $geneid = shift;

    my $seq = Mods::Database::getSQLResult("seq", "gene", "gene_id", "$geneid");
    my @codingregions = getCodingRegions($geneid);

    my @introns;
    my @enzymes;
    my $coding;
    my @empty = ("No restriction enzymes found");
    my %re = (
        ecori =>{
            'GAATTC' => 0,
        },
        bamhi =>{
            'GGATCC' => 0,
        },
        bsumi =>{
            'CTCGAG' => 0,
        },
    );


    # Searches for the first and last non coding regions and extracts the sequence
    if ($seq =~ /(.*?)($codingregions[0].*$codingregions[-1])(.*)/g) {
        push (@introns, $1);
        $coding = $2;
        push (@introns, $3);
    }


    # Searches each intron and sees if there are matches to the restriction enzymes
    # If there are matches, increase the count by 1
    foreach my $enzyme (keys %re) {
        foreach my $site (%{$re{$enzyme}}) {
            foreach my $i (0..1) {
                if ($introns[$i] =~ /$site/) {
                    $re{$enzyme}{$site}++;
                }
            }
        }
    }

    # Searches inbetween the first and last non coding regions to see if the restriction
    # enzyme matches. If there is a match, set the value to 0 to represent an unusable
    # enzyme
    foreach my $enzyme (keys %re) {
        foreach my $site (%{$re{$enzyme}}) {
            if ($coding =~ /$site/){
                $re{$enzyme}{$site} = 0;
            }
        }
    }

    # Checks the restriction enzyme hash for any values of 2
    # Pushes these enzymes to a new array to be returned
    foreach my $enzyme (keys %re) {
        foreach my $site (keys %{$re{$enzyme}}) {
            if ($re{$enzyme}{$site} == 2) {
                push (@enzymes, $site);
            }
        }
    }

    if (@enzymes) {
        return @enzymes;
    }
    else {
        return @empty;
    }
}

### Takes an accession numnber (scalar) and returns the gene ID to be used in the subroutines
sub getGeneFromAccession {
    my $acc = shift;

    my $geneid = Mods::Database::getSQLResult("gene_id", "gene", "accession_number", "$acc");
    return $geneid;
}

### Takes an protein product (scalar) and returns the gene ID to be used in the subroutines
sub getGeneFromProduct {
    my $product = shift;

    my @geneids = Mods::Database::getSQLAllSpecific("gene_id", "gene", "protein_product", "$product");
    return @geneids;
}

1;

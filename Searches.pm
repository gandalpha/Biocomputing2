#!/usr/bin/perl
	use strict;
	use warnings;
	use 5.010;

package Mods::Searches;

sub geneId {
	my @gene_id = @_;
	foreach my $value (@gene_id) {
		say "SELECT gene_id FROM gene WHERE gene_id = $value";
	}
}

sub productName {
	my @product_name = @_;
	foreach my $value (@product_name) {
		say "SELECT product_name FROM gene WHERE product_name = $value";
	}
}

sub accessionNumber {
	my @accession_number = @_;
	foreach my $value (@accession_number) {
		say "SELECT accession_number FROM genbank_info WHERE accession_number = $value";
	}
}

sub geneLocation {
	my @gene_location = @_;
	foreach my $value (@gene_location) {
		say "SELECT gene_location FROM chromosome WHERE gene_location = $value";
	}
}

1;
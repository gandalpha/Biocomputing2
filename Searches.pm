#!/usr/bin/perl
	use strict;
	use warnings;
	use 5.010;
	use DBI;

package Mods::Searches;

### Login and connect ###
	my $dbn = "biodb"; #rn002
	my $dbhost = "hope";
	my $dbsource = "dbi:mysql:database=$dbn;host=$dbhost";
	my $username = "biodb_user"; #rn002
	my $password = "biodb_p"; #otih4i9mm
	my $dbh = DBI->connect($dbsource, $username, $password);

### Searches ###
	#self explaintary from the title, retruns an array
	sub getGeneIDs {
		my $sql = "SELECT pdb_code FROM protein"; #"SELECT gene_ID FROM genes"
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		my @geneids;
		while(my $id = $sth->fetchrow_array) {;
			push(@geneids, $id);
		}
		return @geneids;
	}

	#self explaintary from the title, retruns an array
	sub getProteinProducts {
		my $sql = "SELECT pdb_code FROM protein"; #"SELECT product_name FROM genes"
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		my @proteins;
		while(my $name = $sth->fetchrow_array) {;
			push(@proteins, $name);
		}
		return @proteins;
	}
	#self explaintary from the title, retruns an array
	sub getAccessionNumber {
		my $sql = "SELECT pdb_code FROM protein"; #"SELECT accession_number FROM genes"
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		my @accession;
		while(my $number = $sth->fetchrow_array) {;
			push(@accession, $number);
		}
		return @accession;
	}

	#self explaintary from the title, retruns an array
	sub getChromoLocat {
		my $sql = "SELECT pdb_code FROM protein"; #"SELECT gene_location FROM genes"
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		my @location;
		while(my $geneloc = $sth->fetchrow_array) {;
			push(@location, $geneloc);
		}
		return @location;
	}

	# returns an array that has the gene id, protein product name, accession number and chomo location
	# all in one line. This is provided along side the above 4 subroutines for flexibility for the end user
	sub getsummary{
		my $sql = "SELECT pdb_code, name, date, source FROM protein"; #"SELECT gene_ID, product_name, accession_number, gene_location FROM genes"
		my $sth = $dbh->prepare($sql);
		my @summary;
		if($sth && $sth->execute) {
	        while(my($id, $product, $acc, $loc) = $sth->fetchrow_array) {
	           my $temp = "$id, $product, $acc, $loc";
	           push(@summary, $temp);
	        }
	    }
	    return @summary;
	}

### Below maybe not needed ###
	sub geneId {
		my $gene_ID = shift;
		my $sql = "SELECT gene_ID FROM gene WHERE gene_ID = $gene_ID"
		my $sth = $dbh->prepare($sql);
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

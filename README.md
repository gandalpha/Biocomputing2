# Biocomputing2
Biocomputing2 project


#!/usr/bin/perl
	use strict;
	use warnings;
	use 5.010;

use Mods::Searches;

my $organism = "fox";

if ($organism ne undef){
	Mods::Searches::gene_id($organism);
}

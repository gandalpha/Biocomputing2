#!/usr/bin/perl

use strict;
use warnings;

use DBI;
use CGI;


use Mods::Database;
#use Mods::Core;


#my $dbn = "ms004"; #rn002, biodb, ms004 
#my $dbhost = "hope"; 
#my $dbsource = "dbi:mysql:database=$dbn;host=$dbhost"; 
#my $username = "ms004"; #rn002, biodb_user, ms004 
#my $password = "1u76tv9v9"; #otih4i9mm, biodb_p, 1u76tv9v9 
#my $dbh = DBI->connect($dbsource, $username, $password); 

my($cgi);

$cgi = new CGI;

print $cgi->header("HELLO");

my @params = $cgi->param;

my $gene;

foreach my $param (@params)
{
    my @values = $cgi->param($param);
   foreach my $value (@values)
   {
      $gene=$value;
   }
}

my $sql = "SELECT aa_seq FROM amino_acid WHERE gene_id = '$gene'"; #"SELECT pdb_code FROM protein WHERE pdb_code = '$geneid'"; 
my $sth = $dbh->prepare($sql); 
$sth->execute(); 
my $nuc = $dbh->selectrow_array($sql); 


my $accession = "Dummy_Accession";

#my $nuc = "CCAGACCGAATTCCTACTGACGCAAGATGGGGTCATGGTCACATTCTTTCGCTATGTGGTCGATTCACAGATCTGTACGAATGGGGCCCCTCACGAGCCAGATCGAGATTAGATCACCAGATCATATGATCACGCGACCGATGTCACTAATATCCGTAGTGGAGTCCCACAACGTAAACTACCGGTCAGATAGCCGTCAACAGTGTGGATTGGGGTGTCTATACGGATCCGCTCCGGACGAACGCACAAGTTAACTTATCTTGGTTTAAGGTGGACGTTCCCAGGCAGTGCGAACTTCCAGAAGTGATCGTTAAAACCTACCCGGGGTAATTGCGCATGACGCTTAACTAAGGTTTGTTCACGAACCTTGGATACCTTGCCTGCGGTGTCAAAGTACGGTGTATCTTAGCCCACCCAGATACTGCATGTACCATGAGTAATACGGTGCCCATGTCAGCATGTAACCAAGCAAAATGACCGCATGTTCTGGCGCACTCTTCTGATCATCTGGACAGCCAGTTGTACACAGGTTGATTGCCAGCGCGACGGCCCAATCTCTGCGACTCGGCCCACGTCGGTGTCTCCGACCTCAATGACCAAATGTTGGGATAATTATACTACAATCCTTCAGATTGTGGCTTATGGATCCTGGAGCAGTTCTTTGCAGACCTACGGCTAGTATAAGGCGACGTTATCTAACCTGGCGTGTACTCCTGTTGCGCCCTTCCTGTTAAAGAAATAACGCCGGGAACGTAGCCGCTCGAGCGCGGACTCACATCTTATCGAAGACCCTGAGCCGAAATCCGAATGGCGGGTGAGAACTGTACTCAGCCTTCAGAAAACCATAGTTCGATGGACTTCTAAACCTATGTCTGCTTATACTGGATCTGCAAAGAGCATGGTTCGTTACATGACAATGCCTTATAGGAATTTGGTAGCTGGAACTCTTAATCAGGCCACCACCTTTTTCTCGACAAGACCCTCTGTAGAAGGTGAGGAAACTTGTAATTATCTTACACGTCTCAGGTTTTACGTCATCCACGGTATGAATACGAAAGATATAGTCATCCAGACATCTTCGACATATGCGGGGGCACATCTGATCGGTAGCTTGAACCGCGAATATCGCGAGACTGGGAATTAAGCACAATGTTGCCATGTACAGCTGAAATCCTTTGCGCCCTGCCGCGCTTCGGAGGAAGGGGGTCGGAGCTCTTGCTAAGAAACTGTGTGTAACGGAGCATTTCTTTAAGCTATAAGAAGCCAACATCTCGGATAGTATTGGATACCTGGTTGCGGAGTAGATCACGAAACGCCCCAATGTATTAAGCCTGTCCGCGGGAGGAGGCTTGTGTTGACCCTGTTTGACTACGATGAAGTGTGTGGTGGGGGTATATTTGTGACTAGTCAGATGGTCCAGAGCAGTCAAGTAAAGTACTTGGCAGGCACATGCTAGACGGCCAGTGGTGGGATTGTAGGCATACATTGCACTGGCCGGATTGATATAGTTAAGCAGATTGCTTAAGGGTTATTAGGAGCCCCACGACGGGATTCTTGTCCTCACCATGAGCCACATACCGTGGGTAGGGGAGTGACGGCTGGCCGAGCCTGACGCCTCGCACTCTATGGGTGCGGGCTGGCACTCGGGAATTCATTCTGGTCGGTGATGTTCAACCATACAGGAGCGGCCATTGAATTCGGGCTGTGTACAGTCTCTTATCCTCCGTTTAACCTCAGCGCAGCCCCGGATCGACTTCATAGTACGGCCCAATGGCTTTTTAGAATTTTAGAAAGAAGCTATTAGGATCCTCTTACTCCTGCCCACTCCAATAGGCGAGTGAACTTTTCAGTGTCCGTCGTAAGTGCTTGGACCATCAAAGGCTGGCTTGCTTCTAGGTGGGAGGTTCGTTACCCGTTTAAGCCGCACCACGCACAACCTCCGTCAGGATACGGACGAGCTGTGTGTTCTGATCCCGAACATCTCCGACAAGCTCAGCGATGATCAACTTACGCATGCATACGGCGAAAATCTTGCTATACACGTCGCGCGCGCTTACCTGATCACAGGAAAGCGTGACATACTAGGGGTTATATTGCATAGCGGTTTCACACAGTGTGAAGTGTGTGTCAGGGGCCCGGTCGCGTACAAAATGGTAGGGCAAGTTCAAAATGCCTATTCGAGTATCCGCGAGGAGGAAGAAAGAAGGTTAAGTATTTTCTTTAGAAGGGTCATAATGGAAATCTAAGATTAGTAGCATCCCAGATCCTAATCGCATCCGCCCTGCGAGTGTGGGAAGCGCGGGCGGGGGTAAGACTCAGTGTCGATTAGGGGTCGGCCGACTGAACTAGCAATCCCCCGACAGAGAAGTACACAAAAGGCGCAAGAACTGCTGTGGACAGGCAGTTGGCAGCGGGCAATTGCATTCTGATGTCTGATGAACCAACGCAAACTGATATACCCGCGCGTGGTCAGGTAGTAGTCTGCCAGTCGCCATGGGTCCAGCTGAGCTGTCTCTTTGCCTTCTGATCGACGATCCGCATGCCATTCGTCGGACCCACGCGCCAAGTTCGTTGCGCTCTGTCTCCCTAATGGTTATAGTTTGGCTACGACATATCGCCACACGTGCCAGCCTATAGCCTAGTGATGTCGCGTCGTGTTGGGGGGAGGTGATATCTTCGCTGGCAATCCACGTAGTACCCACATGTCAGTCTATCGACAGGTAGAACCTTCAGCACGAGTACTCGGTCCAGTACGTAGGTTCTGTCATCTGCCACTGGCGCGCGACTAATCCCGCTCCCGACGTAGCTATTGAGAGTAGAAAGGCATTCCTTGAAAATCATAAATAAGGCTTTTGCTTTGCGTTCTGCATATTTTCGGACCAGGTTTGAACTGGTAGAGTGGACAGCCAAGGACAGCTAATTAAGCGAATCCAGGCGTCTAAAGTGTGCGCTAGGCCCCGTTTTCTATGACCGGGAGCGACACCCGTCGAGGTACAATTTTGTAAAAGTTCGTACGGGCTTCTTAGGTTGTGCATCACCTCTGGAAGACCCTCGCCTAGCTCGTCTCCCGGCTGAATAGGACTTCTGTTGTTTTTTCATTTGTGAGGGGGGGACCGTGCCTCCTGACATCGTGCCAACTGCAGGAGAGTCGGCCACGGGGCACCCGTTATTACGGTTCCGGTGGTGGGCGTAGCCAGCCTTATCTTATGGCCAAAGACCCGTAAGAAGCCTCCTGATGTCTCGAGGATACGTTTGAGCAGCGTAATACGCTCGGGGCATAACGTCATACTCACTTTTAGACCTTTTATGGGGGGGTTCGCGTTTGAAAATGTATTCGCTGGGCTGGTCATCGGCGGACGCATAGGGACAACAATAAGGGGTAGTAAATTTTAAGTGATAAAGGGTGCTGGAGGCTGACGAGTTAGTTCCATAAAACCACTTGCTAGAAGCCATAATATGAGCTCTAGGAATGACCCTCATATACGCCCCAGGCAGATCCTTCTCGCCCTTTAGCTAAGATGAAGGCTTTCATAAATCATTAGAGGAACTCGTCCGCCATGTCGTACCATTACTTTTATAAGTTTCGAATGATTCATGATAACTTGTGATACCCTACGTGTTCGAAGGCACTCGGCGTGAATATGGCGGCCAACCGGCTGGTCGACCCCGTATAACCGTAAAGTTATGAACGGGCGCGACGCGCCACTCATTCTGCCTTATCGAGTCCCTTCTGAAAGTTCCGACCCCTGGCGTACAGCATAGCCGGAAATCCGTTGGTCAGGAAGCCGGACCACTAGCAAAAGTAGGCTGTTTCAACTCAGCGGTGCAGGGTAAACACGGTGTTCTACAATCAACATGCTTTTCCGATGCGGAACCTATACTGGCACCGGCTGCCTTATTTCCTACATTAACCATAAGCGGGATGGCCCTATCATAGAATCCCCACGCCATGTTAGGTCCCCAATATTTGCAGCATACCCGGCACGCCCTAAAATTCTGATTCCGAGGCGCATGTGTCACTACCCTTGAGTCTAGTTCAGCTTATGACACTAATCACTGTGTATCACTTGGAGCGACAATGGAAGACTAAGGTGGAGGAGCCGGCCTCTCTTACGTGTGTAGCCCCGCGTCTTGAAATGCGGTATGTCCAATGGGGCATAAACTTTGATCACTATACCCAGGATGAAGGCAAGATGCACTAGTAGATATACTGCCTAATGCCCCACCCGTAGTGGGTCATATGTCATGCGCAAAGTAGCGTTTCAAGATTATCGTGAATCGTGGGGCGACATTGATGTGCAACCGCTGGCGAATCGTCCAGAGGGGTATGAGTGACCACGCTAAAAGCAGGGCCATCGTCTGGCGATTCAGGGGGGATTAGAGAGCTTTAGTTTTGGACGTCAATCGGATGCTCCTCACCGGTGGTCTCACTAGTGGTCTCTATGATTTCTGGGTATATCCGACGCTTATCAATCCAATTGATAAGAACATCCCCCACCTCATCAAGTCAGGGAAGGAGACTGCGCTGTAGCCCCCCGTGCCACTGGGCGGAGCGACAACTCTGCACCGCACAAGTATCAGGTCATCAACTTGATTGGCGTCTTGTGAAAGGGTATCTCGCTGCGATGAAAAAGATAGGCGGGACGCTTTAGAATAGCACACGACCACTCTATGTAGCCACCGTTGCCCACCGACTGAAAGCCGAGGTCCGAATGGGCCCGATGCTTGTTCATGAGATGGCGGTGGTCGATACGTCAGAGCTCTCTCACCCGCTGATAAGGTGGCATTCGTAGGAGAGAGTTTAATACCGCTGAAAAAGTGCGGGACTCAACAATCGGCAATGGGCAGCAGCAAAGCATTACAGTTGAATGGCAAGGGAGTTGGGTCTGTATCGACGTCTTCGGCCCTTATTAGTACGCGTCGCCTGGTTGGCGCGGTTGACGATTGAGCCTATATCGAGACCGTCCTGATAAAGAAGTAGATGATCTGACATCTATGGCAACCCCCATTTGCGTTGATGGTGAATCGTGCTTTAAACGATTTATCGTAGTTTGCGTTGTTGTGCCACCGTTTCTCTGGAAGGGAGTGTGGAAACTAATCCCCAGTTGCTCTCATGTAGATAGGGCTACAACGTCCCAGGGAATGCGCTAAAGTTATCTTTGCAGATTTCCTAGTGGCACTGCCGCGAGGACCCGGTTACCTACATGGGCAAAACGTCCCTCTTAATTAGTCCAATCGATTCTCGTCTTCCTAGATAGTCTGGATGC"; 

my $coding_sequence = "";

my %abbreviations = (
        'c' => 'Cysteine',
        'n' => 'Asparagine',
        'h' => 'Histidine',
        'm' => 'Methionine',
        'y' => 'Tyrosine',
        'r' => 'Arginine',
        'k' => 'Lysine',
        'q' => 'Glutamine',
        'i' => 'Isoleucine',
        'g' => 'Glycine',
        'd' => 'Aspartic_Acid',
        'a' => 'Alanine',
        'p' => 'Proline',
        'f' => 'Phenylalanine',
        't' => 'Threonine',
        'l' => 'Leucine',
        'v' => 'Valine',
        's' => 'Serine',
        'e' => 'Glutamic_Acid',
        'w' => 'Tryptophan',
        )
;

############################
# TO BE FILLED IN MANUALLY #
############################

my %overall_stats = (
                'GCA' => "22%",
                'GCC' => "22%",
                'GCG' => "25%",
                'GCT' => "35%",
                'CGA' => "35%",
                'CGC' => "35%",
                'CGG' => "35%", 
                'CGT' => "35%",
                'AGA' => "35%",
                'AGG' => "35%",
                'AAC' => "35%",
                'AAT' => "35%",
                'GAC' => "39%",
                'GAT' => "35%",
                'TGC' => "35%",
                'TGT' => "35%",
                'CAA' => "35%",
                'CAG' => "35%",
                'GAA' => "35%",
                'GAG' => "35%",
                'GGA' => "35%",
                'GGC' => "35%",
                'GGG' => "35%",
                'GGT' => "35%",
                'CAC' => "35%",
                'CAT' => "35%",
                'ATA' => "35%",
                'ATC' => "35%",
                'ATT' => "35%",
                'TTA' => "55%",
                'TTG' => "35%",
                'CTA' => "35%",
                'CTC' => "35%",
                'CTG' => "35%",
                'CTT' => "37%",
                'AAA' => "35%",
                'AAG' => "35%",
                'ATG' => "35%",
                'TTC' => "35%",
                'TTT' => "35%",
                'CCA' => "35%", 
                'CCC' => "35%", 
                'CCG' => "35%", 
                'CCT' => "35%",
                'TCA' => "35%",
                'TCC' => "35%",
                'TCG' => "35%",
                'TCT' => "35%",
                'AGC' => "35%",
                'AGT' => "35%",
                'ACA' => "35%",
                'ACC' => "35%",
                'ACG' => "35%",
                'ACT' => "35%",
                'TGG' => "37%",
                'TAC' => "35%",
                'TAT' => "35%",
                'GTA' => "35%",
                'GTC' => "35%",
                'GTG' => "85%",
                'GTT' => "35%"
);

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

    while ($nuc =~ /(.{3})/g) {
        foreach my $amino (keys %aminoacids) {
            foreach my $codon (%{$aminoacids{$amino}}) {
                if ($codon eq $1) {
                    $aminoacids{$amino}{$1}++;;
                }
            }
        }
    }


print <<__EOF;
<!DOCTYPE html>
<html>
<head>
<style>
body {
    background-color: steel;
}

h2 {
    font-size: 25px;
}

.sequence {
    float:left;
    width: 850px;
    height: auto;
    margin: 10px;
    border: 3px solid grey;
    padding: 20px;
}

.pie_box {
    display: inline-flex;
    width: 850px;
    height: auto;
    margin: 10px;
    border: 3px solid grey;
    background-color: #f2f2f2;
}

.pie {
    display : none;
    position:absolute;
    transform : translate(-610px, 110px);
}

li {
    font-size : 15pt;
    display: block;
    cursor:pointer;
	cursor: hand;
    margin-bottom:1px;
}

li:hover {
    text-decoration:underline;
	color: blue;
    
}

.enzyme_button {
    padding: 5px;
    display: block;
}

.enzyme {
    float:left;
    height: auto;
    width: auto;
    margin: 10px;
    border: 3px solid grey;  
}

.sticky {
        text-decoration: underline;
}

.coding {
    color:red;
}

code {
    word-wrap:break-word;
    margin:10px;
}

h1 {
    display: block;
    text-decoration: underline;
    margin-left: 10%;
}

#masterpie {
        display: block;
}

[class\$="labels-outer"]
{
        transform: translateX(-50px);
}

[class\$="labels-inner"]
{
        transform: translateX(-15px);
}

.p20_labels-inner
{
        transform: translateX(2px);    
}

.p20_labels-outer
{
        transform: translateX(2px);    
}

</style>
<script src="http://student.cryst.bbk.ac.uk/~aw001/d3.min.js"></script>
<script src="http://student.cryst.bbk.ac.uk/~aw001/d3pie.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
</head>
<body>

<h2>Result Page for Accession Number $accession</h2>
<h3>Showing information about Gene $gene</h2>

<div class="sequence" id="Nucleotide Sequence">
    <h1>Nucleotide Sequence</h1>
__EOF

print "<h2>The coding sequences are highlighted below in red</h2>";

my $sequence_length = length($nuc) - 1;

print "<h3> $gene : Sequence Length : $sequence_length bp </h3>";

print "<div>";

my %aminocount;

my $count = 0;

while ($nuc =~ s/(.*?)(ATG.*?(TAA|TAG|TGA))//) {
        $coding_sequence = $coding_sequence.$2;
        my $intron = $1;
        my $primary_intron = "";
        if ($count == 0) {
            $primary_intron = $intron;
        }
        my $exon = $2;
        if ($primary_intron =~ /(.*?)(GAATTC)(.*)/) {
            my $lead = $1;
            my $enzyme_site = $2;
            my $trail = $3;
            print "<code class=\"non-coding\">$lead</code><code id = \"ecori_first\" class=\"sticky\">$enzyme_site</code><code class=\"non-coding\">$trail</code><code class=\"coding\">$exon</code>";
        }
        else{
        print "<code class=\"non-coding\">$intron</code><code class=\"coding\">$exon</code>";
        $count++;
        }
}

if ($nuc =~ /(.*?)(CTTAAG)(.*)/) {
    print <<__EOF
    <code class = "non-coding">$1</code><code id = "ecori_last" class="sticky">$2</code><code class="non-coding">$3</code>
__EOF
}


else{
    print <<__EOF;
    <code class = "non-coding">$nuc</code>
__EOF
}



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
    
    while ($coding_sequence =~ /(.{3})/g) {
    	exists $translation{$1} or die "Not a codon $1\n";
            $protein .= $translation{$1};
            $aminocount{$translation{$1}}++; 
    }

$protein =~ s/-//g;

my $prot_length=length($protein);

$protein =~ s/(.{10})/$1 /g;
$protein =~ s/(((\w+) ){6})/$1\n/g;


print <<__EOF;
</div>
</div>

<div class="enzyme">
    <h1>Sticky Enzymes</h1>
<ul>
    <input type="button" class="enzyme_button" id="ecori" value="Display ecori">
    <input type="button" class="enzyme_button" id="bamhi" value="Display bamhi">
    <input type="button" class="enzyme_button" id="bsumi" value="Display bsumi">
</ul>
</div>


<div class="sequence" id="Amino Acid Sequence">
    <h1>Amino Acid Sequence</h1>
    <code>
$protein
    </code>
</br> 
<p>
The total length of the amino acid sequence is $prot_length.
</p>
</div>
<div class="pie_box" id="pie_container">
    <ul class="List">
        <h2>Click on an amino acid from the list to display the codon distribution for this gene - (full distribution shown in brackets)</h2>
__EOF

foreach (sort values %abbreviations)
{
print <<__EOF;
<li id="$_">$_</li>
__EOF
}

print <<__EOF;
        </br>
        <form>
            <input type="button" id="Reset" value="Reset Pie">
        </form>
    </ul>
__EOF
foreach (values %abbreviations)
{
my $id = $_."_pie";
print <<__EOF;
<div class="pie" id="$id"></div>
__EOF
}

print <<EOF;
<div class="pie" id="masterpie"></div>
</div>
<script>
EOF
my %mastercodoncount;
foreach (keys %aminoacids)
{
    my $abramino=$_;
    if ($abramino eq "stop") {
        next;
    }
    my $div_id = $abbreviations{$abramino}."_pie";
    print <<__EOF;
var pie = new d3pie("$div_id", {
	"header": {
		"title": {
			"text": "$abbreviations{$abramino}",
			"color": "#df2c2c",
			"fontSize": 18,
			"font": "courier"
		},
		"subtitle": {
			"text": "in $gene",
			"color": "#999999",
			"fontSize": 10,
			"font": "courier"
		},
		"location": "pie-center",
		"titleSubtitlePadding": 15
	},
	"footer": {
		"text": "Created using javascript from https://github.com/benkeen/d3pie",
		"color": "#999999",
		"fontSize": 16,
		"font": "open sans",
		"location": "bottom-left"
	},
	"size": {
		"canvasWidth": 600,
		"canvasHeight": 500,
		"pieInnerRadius": "45%",
		"pieOuterRadius": "86%"
	},
	"data": {
		"sortOrder": "label-desc",

	"content": [
__EOF

foreach (keys %{$aminoacids{$abramino}})
{
    my $codon = $_;
    my $overall = $overall_stats{$codon};
    my $value = $aminoacids{$abramino}{$codon} + 0;
    $mastercodoncount{$codon}=$value;
    
print <<__EOF;
    {
        "label": "$codon - ($overall)",
        "value": $value,
    },
__EOF
}

print <<__EOF;
		]
	},
	"labels": {
		"outer": {
			"format": "label",
            "pieDistance": 50
		},
		"inner": {
			"format": "percentage"
		},
		"mainLabel": {
			"fontSize": 17
		},
		"percentage": {
			"color": "white",
			"fontSize": 20,
			"decimalPlaces": 0
		},
		"value": {
			"color": "#cccc43",
			"fontSize": 10
		},
		"lines": {
			"enabled": false
		},
		"truncation": {
			"enabled": true
		}
	},
	"effects": {
		"load": {
			"speed": 250
		},
		"pullOutSegmentOnClick": {
			"effect": "back",
			"speed": 400,
			"size": 8
		}
	},
	"misc": {
		"colors": {
			"segmentStroke": "#000000"
		}
	},
	"callbacks": {}
});
__EOF
}


print <<__EOF;
var pie = new d3pie("masterpie", {
	"header": {
		"title": {
			"text": "Amino Acid Distribution",
			"color": "#df2c2c",
			"fontSize": 12,
			"font": "courier"
		},
		"subtitle": {
			"text": "in $gene",
			"color": "#999999",
			"fontSize": 10,
			"font": "courier"
		},
		"location": "pie-center",
		"titleSubtitlePadding": 15
	},
	"footer": {
		"text": "Created using javascript from https://github.com/benkeen/d3pie",
		"color": "#999999",
		"fontSize": 16,
		"font": "open sans",
		"location": "bottom-left"
	},
	"size": {
		"canvasWidth": 600,
		"canvasHeight": 500,
		"pieInnerRadius": "55%",
		"pieOuterRadius": "75%"
	},
	"data": {
		"sortOrder": "label-desc",

	"content": [
__EOF

foreach (keys %aminocount)
{
    my $amino = $_;
    my $value = $aminocount{$amino};
    
print <<__EOF;
    {
        "label": "$amino",
        "value": $value,
    },
__EOF
}

print <<__EOF;
		]
	},
	"labels": {
		"outer": {
			"format": "label",
			"pieDistance": 15
		},
		"inner": {
			"hideWhenLessThanPercentage": 3
		},
		"mainLabel": {
			"fontSize": 18
		},
		"percentage": {
			"color": "#ffffff",
			"decimalPlaces": 0
		},
		"value": {
			"color": "#adadad",
			"fontSize": 25
		},
		"lines": {
			"enabled": true
		},
		"truncation": {
			"enabled": true
		}
	},
	"effects": {
		"pullOutSegmentOnClick": {
			"effect": "linear",
			"speed": 400,
			"size": 8
		}
	},
	"misc": {
		"gradient": {
			"enabled": true,
			"percentage": 100
		}
	}
});
__EOF



######################################
# STICKY ENZYME SEC PLUS JQUERY NOTES#
######################################


print <<__EOF;
</script>


<footer>
    <p>
            And let's hope that's the end of that...
    </p>

</footer>

</body>
<script>
\$(document).ready(function(){
    \$("#Reset").click(function(){
        \$(".pie").hide();
        \$("#masterpie").show();
    });
__EOF
foreach (values %abbreviations)
{
        my $div_id = $_."_pie";
        print <<__EOF;
            \$("#$_").click(function(){
        \$(".pie").hide();
        \$("#$div_id").show();
            });
__EOF
}
print <<__EOF;
});
</script>
</html>
__EOF

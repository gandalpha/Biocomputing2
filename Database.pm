#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use DBI;

package Mods::Database;

### Login and connect ###
my $dbn = "ms004"; #rn002 ms004
my $dbhost = "hope";
my $dbsource = "dbi:mysql:database=$dbn;host=$dbhost";
my $username = "ms004"; #rn002 ms004
my $password = "1u76tv9v9"; #otih4i9mm 1u76tv9v9
my $dbh = DBI->connect($dbsource, $username, $password);

#Takes SELECT, FROM, WHERE and a search paramter, in scalar context, and returns the result of the SQL
sub getSQLResult {
    my $select = shift;
    my $from = shift;
    my $where = shift;
    my $search = shift;
    my $sql = "SELECT $select FROM $from WHERE $where = '$search'"; 
    my $sth = $dbh->prepare($sql);
    $sth->execute();
    my $result = $dbh->selectrow_array($sql);
    return $result;
}

# Takes SELECT and FROM as parameters and returns an array
sub getSQLAll {
    my $select = shift;
    my $from = shift;
    my $sql = "SELECT $select FROM $from";
    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @result;
    while (my $row = $sth->fetchrow_array) {
        push (@result, $row);
    }
    
    return @result;
}

# Takes SELECT, FROM, WHERE and a search parameter, in scalar, and returns an array
sub getSQLAllSpecific {
    my $select = shift;
    my $from = shift;
    my $where = shift;
    my $search = shift;
    my $sql = "SELECT $select FROM $from WHERE $where = '$search'";
    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @result;
    while (my $row = $sth->fetchrow_array) {
        push (@result, $row);
    }
    
    return @result;
}

1;

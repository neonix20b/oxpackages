#!/usr/bin/perl -w
use strict;
use Cwd;
use DBI;
my $folder = getcwd();
my $id = shift;
my $domain = shift;
my $password = shift;

open CONF, "Settings.php";
my $conf = join("", <CONF>);

$conf =~ s/http:\/\/pkg_phpbb.oxnull.net/http:\/\/$domain.oxnull.net/g;
$conf =~ s/'oxnull.net'/'$domain.oxnull.net'/g;
$conf =~ s/pkg_phpbb/ox$id/g;
$conf =~ s/qwerty92_phpbb/$password/g;

close CONF;
open CONF, ">Settings.php";
print CONF $conf;
close CONF;

my $dsn = "DBI:mysql:dbname=ox$id;hostaddr=localhost";
my $db_user_name = "ox$id";
my $db_password = $password;
my $dbmysql = DBI->connect($dsn, $db_user_name, $db_password,{ RaiseError => 0, PrintError => 0});

my $sth = $dbmysql->prepare("UPDATE smf_themes SET value = REPLACE(value, 'http://pkg_phpbb.oxnull.net', 'http://".$domain.".oxnull.net')");
$sth->execute();
$sth = $dbmysql->prepare("UPDATE smf_themes SET value = REPLACE(value, '/home/pkg_phpbb/', '/home/ox".$id."/')");
$sth->execute();
$sth = $dbmysql->prepare("UPDATE smf_settings SET value = REPLACE(value, '/home/pkg_phpbb', '/home/ox".$id."/')");
$sth->execute();
$sth = $dbmysql->prepare("UPDATE smf_settings SET value = REPLACE(value, 'http://pkg_phpbb.oxnull.net', 'http://".$domain.".oxnull.net')");
$sth->execute();

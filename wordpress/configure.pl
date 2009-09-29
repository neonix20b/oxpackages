#!/usr/bin/perl -w
use strict;
use Cwd;
use DBI;
my $folder = getcwd();
my $id = shift;
my $domain = shift;
my $password = shift;

open CONF, "wp-config.php";
my $conf = join("", <CONF>);
close CONF;

$conf =~ s/pkg_wordpress/ox$id/g;
$conf =~ s/qwerty92_wordpress/$password/g;

my $dsn = "DBI:mysql:dbname=ox$id;hostaddr=localhost";
my $db_user_name = "ox$id";
my $db_password = $password;
my $dbmysql = DBI->connect($dsn, $db_user_name, $db_password,{ RaiseError => 0, PrintError => 0});

my $sth = $dbmysql->prepare("UPDATE wp_options SET option_value = REPLACE(option_value, 'http://pkg_wordpress.oxnull.net', 'http://".$domain.".oxnull.net') WHERE option_name = 'home' OR option_name = 'siteurl'");
$sth->execute();

$sth = $dbmysql->prepare("UPDATE wp_posts SET guid = REPLACE(guid, 'http://pkg_wordpress.oxnull.net', 'http://".$domain.".oxnull.net')");
$sth->execute();

$sth = $dbmysql->prepare("UPDATE wp_posts SET post_content = REPLACE(post_content, 'http://pkg_wordpress.oxnull.net', 'http://".$domain.".oxnull.net')");
$sth->execute();
open CONF, ">wp-config.php";
print CONF $conf;
close CONF;
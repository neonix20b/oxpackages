#!/usr/bin/perl -w
use strict;
use Cwd;
my $folder = getcwd();
my $id = shift;
my $domain = shift;
my $password = shift;

open CONF, "configuration.php";
my $conf = join("", <CONF>);
close CONF;
$conf =~ s/\s*\$db\s*=\s*'.*?'\s*;/ \$db = 'ox$id';/g;
$conf =~ s/\s*\$user\s*=\s*'.*?'\s*;/ \$user = 'ox$id';/g;
$conf =~ s/\s*\$password\s*=\s*'.*?'\s*;/ \$password = '$password';/g;
$conf =~ s/\s*\$sitename\s*=\s*'.*?'\s*;/ \$sitename = '$domain.oxnull.net';/g;
$conf =~ s/\s*\$log_path\s*=\s*'.*?'\s*;/ \$log_path = '$folder\/logs';/g;
$conf =~ s/\s*\$tmp_path\s*=\s*'.*?'\s*;/ \$tmp_path = '$folder\/tmp';/g;
open CONF, ">configuration.php";
print CONF $conf;
close CONF;

open CONF, ".htaccess";
$conf = join("", <CONF>);
close CONF;
$conf =~ s/AuthUserFile \/home\/sys\/pkgpasswd/#/g;
$conf =~ s/AuthType Basic/#/g;
$conf =~ s/require valid-user/#/g;
$conf =~ s/order deny,allow/#/g;
$conf =~ s/AuthGroupFile/#AuthGroupFile/g;
$conf =~ s/AuthName/#AuthName/g;
open CONF, ">.htaccess";
print CONF $conf;
close CONF;
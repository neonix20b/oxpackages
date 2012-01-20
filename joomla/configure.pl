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
$conf =~ s/var\s*\$db\s*=\s*'.*?'\s*;/var \$db = 'ox$id';/g;
$conf =~ s/var\s*\$user\s*=\s*'.*?'\s*;/var \$user = 'ox$id';/g;
$conf =~ s/var\s*\$password\s*=\s*'.*?'\s*;/var \$password = '$password';/g;
$conf =~ s/var\s*\$sitename\s*=\s*'.*?'\s*;/var \$sitename = '$domain.oxnull.net';/g;
$conf =~ s/var\s*\$log_path\s*=\s*'.*?'\s*;/var \$log_path = '$folder\/logs';/g;
$conf =~ s/var\s*\$tmp_path\s*=\s*'.*?'\s*;/var \$tmp_path = '$folder\/tmp';/g;
open CONF, ">configuration.php";
print CONF $conf;
close CONF;

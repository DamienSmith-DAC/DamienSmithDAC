
# perl grants.pl g.csv

use Data::Dumper;

# for grants
$r1 = "grants for (.*?)\@.*";
$r2 = "GRANT (.*?) ON `(.*?)`.*";

$c1 = "CREATE USER '%s'\@'\%' IDENTIFIED WITH authentication_pam AS 'mysql';";
$c2 = "GRANT %s ON %s.* TO '%s'\@'\%';";

$h = {};
$uu = undef;
while (<>) {
	/mysql|root/ && next;
	chomp;
	$db = '';
	if (($u) = $_ =~ /$r1/i) {
		$h->{$u} = [] if not exists $h->{$u};
		$sql = '';
		$uu = $u;
	}
	if (/grant/gi) {
		$sql = $_;
		$sql =~ s/^\|\s+//g;
		$sql =~ s/\s+\|$//g;
		push @{$h->{$uu}}, {u => $uu, sql => $sql} if $sql !~ /error|grants/i;
	} else {
		undef $u;
	}
}

foreach $u (keys %$h) {
	$u || next;
	printf "-- %s\n", $u;
	printf "$c1\n", $u;
	foreach $e (@{$h->{$u}}) {
		printf "%s;\n", $e->{sql};
	} 
	print "\n\n";
}


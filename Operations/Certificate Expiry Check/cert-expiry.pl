#!/usr/bin/perl
#
use strict;
use lib '.';
use POSIX qw/difftime mktime strftime/;
use List::Util qw(first);
use constant TEST => 1;

sub dd;
sub hh;
sub mm;
sub ss;
sub get_host;
sub get_exp;

our $prod;
our $np;
require "all-servers-array";

my $offset = 11; # hours diff from system
my $diff;
my $cmd = qq(echo | openssl s_client -servername %s -connect %s:443 2>/dev/null | openssl x509 -noout -text);
my $html;
my @rec;
my $text;
my $now = now();
my $NOW = strftime('%Y-%m-%d %H:%M:%S', localtime($now));
my $to;
my $to;
if (TEST) {
	$to = 'Joe.Chiu@treasury.nsw.gov.au';
} else {
	$to = 'Indu.Neelakandan@treasury.nsw.gov.au,Joe.Chiu@treasury.nsw.gov.au';
}
my $from = 'Joe.Chiu@treasury.nsw.gov.au';
my $subject = "Just a certificate expiry report";
my @th = ( "APPLICATION", "URL", "EXPIRYDATE", "DNS", "SSL CO", "DAY", "HOUR", "STATUS" );
my @mth = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
my $c = {
        s0 => "#ffffff",
        s1 => "#eeeeee",
        today => "#AED6F1",
        week => "#F9E79F",
        week2 => "#AED6F1",
        expired => "#E6B0AA",
        invalid => "#A9DFBF",
};

print "Now: $NOW\n";

$html .= "<b>PRODUCTION CERTIFICATE EXPIRATION REPORT</b>\n";
$html .= "<table border=0 cellspacing=0 cellpadding=0>\n<tr><td>\n";
$html .= "<table border=0 cellspacing=0 cellpadding=6 width=100%>\n";
$html .= qq(<tr style="color:white" bgcolor=black><td><b>).join('</b></td><td><b>',@th)."</b></td></tr>\n";
go($prod);
my $total = @rec;
foreach my $r (@rec) {
	$html .= $r->{html}
}
$html .= sprintf qq(<tr><td colspan=%d align=right>%s</td></tr>), scalar @th, "&#9731; generated at $NOW";
$html .= "</table>\n</td></tr>\n</table>";

@rec = ();
$html .= "<b>NON PRODUCTION CERTIFICATE EXPIRATION REPORT</b>\n";
$html .= "<table border=0 cellspacing=0 cellpadding=0>\n<tr><td>\n";
$html .= "<table border=0 cellspacing=0 cellpadding=6 width=100%>\n";
$html .= qq(<tr style="color:white" bgcolor=black><td><b>).join('</b></td><td><b>',@th)."</b></td></tr>\n";
go($np);
$total = @rec;
foreach my $r (@rec) {
	$html .= $r->{html}
}
$html .= sprintf qq(<tr><td colspan=%d align=right>%s</td></tr>), scalar @th, "&#9731; generated at $NOW";
$html .= "</table>\n</td></tr>\n</table>";

eval { mailer($html) };

if ($@) {
	print "[$NOW]\t$@\n";
} else {
	print "[$NOW]\tmail sent to $to\n$text\n";
}


sub get_exp {
	my $host = shift;
	my $c = sprintf $cmd, $host, $host;
	my @txt = `$c`;
	my $h = {};
	foreach my $t (@txt) {
		chomp $t;
		$h->{exp} = $t if $t =~ /Not After/;
		$h->{dns} = $t if $t =~ /DNS/;
		$h->{Issuer} = $t if $t =~ /Issuer:/;
	}
        $h->{exp} =~ s/^\s+//;
        $h->{dns} =~ s/^\s+//;
	$h->{dns} =~ s/, DNS:/<br>/g;
	$h->{dns} =~ s/DNS://g;
	$h->{Issuer} =~ /.*?O=(.*?),.*/g;
	$h->{Issuer} = $1;
	return $h;
}
sub get_host {
	my $s = shift;
        $s =~ /[.*?]?http[s]:\/\/(.*)/;
	my @m = split /\//, $1;
        return shift @m;
}
sub mth2num {
        my $m = shift;
        return first { $mth[$_] =~ /$m/i } 0 .. $#mth;
}
# s or no s for plural num
sub snos {
        my $n = shift;
        return 's' if $n > 1;
}
sub now {
        time + int($offset%86400)*3600
}
sub dd {
        my $dd = sprintf "%d", int($diff/86400);
        $dd." day".snos($dd)
}
sub hh {
        my $hh = strftime('%H', localtime($diff));
        $hh." hour".snos($hh)
}
sub mm {
        my $mm = strftime('%M', localtime($diff));
        $mm." minute".snos($mm)
}
sub ss {
        my $ss = strftime('%S', localtime($diff));
        $ss." second".snos($ss)
}

sub mailer { 
	my $c = shift;
	my $csv = 'https://github.com/NSWDAC/Platform/blob/master/Operations/License%20Alert/license-data.csv';
	open MAIL, '|/usr/sbin/sendmail -t' || die "Can't sendmail - $!"; 
	print MAIL "To: $to\n"; 
	print MAIL "From: $from\n"; 
	print MAIL "Subject: $subject\n"; 
	print MAIL qq(Content-Type: text/html; charset=UTF-8\n\n);
	print MAIL $c; 
	close MAIL; 
}

sub go {
	my $servers = shift;
	my $nn = 0;
	foreach my $s (@$servers) {
		my $host = get_host $s->{url};
		my $h = get_exp $host;
		print "$host: $h->{Issuer}\n";
		# Not After : Jan 10 23:59:59 2019 GMT
		my @dns = split /<br>/, $h->{dns};
		my @d = split / /, $h->{exp};
		my $then = mktime(0,0,0,$d[4],mth2num($d[1]),$d[6]-1900);
		$diff = difftime($then, $now);
		printf "%s%12s%12s%12s\n%s\n", dd, hh, mm, ss, join(', ',@dns);
		my $bg = $nn % 2 ? $c->{s1} : $c->{s0};
		my $stat;
		if ($diff > 0) {
			if (dd() < 1) {
				$bg = $c->{today};
				$stat = "Will expire today!";
			} elsif (dd() < 7) {
				$bg = $c->{week};
				$stat = "Will expire in a week!";
			} elsif (dd() < 14) {
				$bg = $c->{week2};
				$stat = "Will expire in two weeks!";
			} else {
				$stat = "OK!";
			}
		} else {
			$bg = $c->{expired};
			$stat = "Expired!";
		}
		
		$h->{exp} =~ s/Not After : //;
		my @td = ($s->{app}, $s->{url}, $h->{exp}, $h->{dns}, $h->{Issuer}, dd, hh, $stat);
		my $hh = {
			'stat' => $stat,
			'html' => sprintf qq(<tr bgcolor="$bg"><td nowrap=1 valign=top>%s</td></tr>\n), join('</td><td nowrap=1 valign=top>',@td)
		};
		push @rec, $hh;
		$nn++;
	}
}

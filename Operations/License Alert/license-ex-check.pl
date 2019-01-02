#!/usr/bin/perl
#
use strict;
use lib '.';
use open ':std', ':encoding(UTF-8)';
use File::Copy;
use POSIX qw/difftime mktime strftime/;
use Text::CSV;
use constant TEST => 1;

sub day;
sub hh;
sub mm;
sub ss;
sub icons;

my $csv = Text::CSV->new({ sep_char => ',' });

my $cfile = 'license-data.csv';
my $repos = 'Platform';
my $gitfile = "./Platform/Operations/License Alert/$cfile";
my $cmd = 'git clone https://2c7016eed9a1498aeb11e596bbd42b5f7353b9e0@github.com/NSWDAC/'.$repos;
my $now = now();
my $NOW = strftime('%Y-%m-%d %H:%M:%S', localtime($now));
my $mth = strftime('%m', localtime($now));
my $dst = ($mth > 3 and $mth < 11) ? 1 : 0; # day saving time
my $offset = 10 + $dst; # hours diff from system
my $diff;
my $html;
my @rec;
my $text;
my $to;
if (TEST) {
	$to = 'Joe.Chiu@treasury.nsw.gov.au';
} else {
	$to = 'Ali.Baig@treasury.nsw.gov.au,Indu.Neelakandan@treasury.nsw.gov.au,Joe.Chiu@treasury.nsw.gov.au';
}
my $from = 'Joe.Chiu@treasury.nsw.gov.au';
my $subject = "Just another expiration sample";
my @th = ( "SOFTWARE", "SERVER", "EXPIRYDATE", "DAY", "HOUR", "NOTE", "STATUS" );
my $c = {
	s0 => "#ffffff",
	s1 => "#eeeeee",
	today => "#AED6F1",
	week => "#F9E79F",
	week2 => "#AED6F1",
	expired => "#E6B0AA",
	invalid => "#A9DFBF",
};

`$cmd`;
copy $gitfile, $cfile;
`rm -rf $repos`;
if (!-e $cfile) {
        exit mailer("$cfile not exists...");
}

$html .= "<b>LICENSE EXPIRATION REPORT</b>\n";
$text .= "License Expiration Report: generated at $NOW\n";
$html .= "<table border=0 cellspacing=0 cellpadding=0>\n<tr><td>\n";
$html .= "<table border=0 cellspacing=0 cellpadding=6 width=100%>\n";
$html .= qq(<tr style="color:white" bgcolor=black><td><b>).join('</b></td><td><b>',@th)."</b></td></tr>\n";

open my $fh, "<:encoding(utf8)", $cfile or die "$cfile: $!";
my $nn;
R: while ( my $r = $csv->getline( $fh ) ) {

	my $err = "".$csv->error_diag();
	if ($err) {
		my @err = $csv->error_diag();
		$html .= sprintf qq(<tr bgcolor=red style="color:white"><td colspan=%d>%s</td></tr>), scalar @th, join(", ",@err);
		next R;
	}
	my ($app, $env, $ip, $host, $exp, $note) = @$r;
	$note ||= 'N/A';
	$exp =~ /ex/i && next R;
	$exp =~ s/\W/\//g;
	# 23/10/2018
        my @d = split /\//, $exp;
        my $then = mktime(0,0,0,$d[0],$d[1]-1,$d[2]-1900);

        $diff = difftime($then, $now);

        my $msg = sprintf "%-36s%-36s%10s%12s%12s%12s%12s", "$app($env)", "$host($ip)", $exp, day, hh, mm, ss;
	my @td = ("$app($env)", "$host($ip)", $exp, day, hh);
	my $bg = $nn % 2 ? $c->{s1} : $c->{s0};
	my $stat;
        if ($diff > 0) {
                if (day() < 1) {
			$bg = $c->{today};
                        $stat = "Will expire today!";
                } elsif (day() < 7) {
			$bg = $c->{week};
                        $stat = "Will expire in a week!";
                } elsif (day() < 14) {
			$bg = $c->{week2};
                        $stat = "Will expire in two weeks!";
                } else {
                        $stat = "OK!";
                }
        } else {
		$bg = $c->{expired};
		$stat = "Expired!";
        }
	if ($exp !~ /\d+\/\d+\/\d{4}/g) {
		$bg = $c->{invalid};
		$note = "Invalid Date! eg. dd/mm/yyyy";
		$stat = "INVALID" if $exp !~ /\d+\/\d+\/\d{4}/g;
	}
	$text .= "$msg - $stat\n";
	push @td, $note, $stat;
	my $h = {
		'stat' => $stat,
		'html' => sprintf qq(<tr bgcolor="$bg"><td nowrap=1>%s</td></tr>\n), join('</td><td nowrap=1>',@td)
	};
	push @rec, $h;
	$nn++;
}
close $fh;
my $total = @rec;
if (!$total) {
	$html .= sprintf qq(<tr><td colspan=%d>%s</td></tr>), scalar @th, "None of the licenses is expired!";
} else {
	foreach my $r (@rec) {
		$html .= $r->{html} if $r->{'stat'} !~ /ok/gi;
	}
}
$html .= sprintf qq(<tr><td colspan=%d align=right>%s</td><td nowrap>%s</td></tr>), (scalar @th)-1, icon(), " generated at $NOW";
$html .= "</table>\n</td></tr>\n</table>";

exit mailer("Error: invalid format in the CSV file\n".system("cat $cfile")) unless $text;

eval { mailer($html) };

if ($@) {
	print "[$NOW]\t$@\n";
} else {
	print "[$NOW]\tmail sent\n$text\n";
}

sub mailer { 
	my $c = shift;
	my $csv = 'https://github.com/NSWDAC/Platform/blob/master/Operations/License%20Alert/license-data.csv';
	$c .= "<ul><li style='margin-left:-20;'>CSV File in GitHub: <a href='$csv'>$csv</a></li>";
	$c .= "<li style='margin-left:-20;'>Please save the CSV file with CSV format if edited by Microsoft Excel.</li></ul>";
	open MAIL, '|/usr/sbin/sendmail -t' || die "Can't sendmail - $!"; 
	print MAIL "To: $to\n"; 
	print MAIL "From: $from\n"; 
	print MAIL "Subject: $subject\n"; 
	print MAIL qq(Content-Type: text/html; charset=UTF-8\n\n);
	print MAIL $c; 
	close MAIL; 
}

# s or no s for plural num
sub snos {
	my $n = shift;
	return 's' if $n > 1;
}
sub now {
        time + int($offset%86400)*3600
}
sub day {
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

sub icon {
        my @icons = qw/ &#9731 &#9788 &#9786 /;
        srand (time ^ $$);
        # zodiac constellations
        my @z = icons 9800, 12;
        # planets
        my @p = icons 9795, 5;
        # yi icons
        my @y = icons 9775, 9;
        push @icons, @z, @p, @y;
        return $icons[rand @icons];
}
sub icons {
        my $s = shift;
        my $e = shift;
        return map { '&#'.($s +$_).';' }(0..$e-1);
}


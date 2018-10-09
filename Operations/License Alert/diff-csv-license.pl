#!/usr/bin/perl
#
use strict;
use lib '.';
use open ':std', ':encoding(UTF-8)';
use POSIX qw/difftime mktime strftime/;
use Text::CSV;
use constant TEST => 0;

sub day;
sub hh;
sub mm;
sub ss;

my $csv = Text::CSV->new({ sep_char => ',' });

my $cfile = 'license-data.csv';
my $token = 'token=AoGhFWJYCetCrWopE34VJS7hpDXGmcPkks5bvspuwA%3D%3D';
my $giturl = "https://raw.githubusercontent.com/NSWDAC/Platform/master/Operations/License%20Alert";
my $cmd = "curl -Os $giturl/$cfile?$token";
my $offset = 10; # hours diff from system
my $diff;
my $html;
my @rec;
my $text;
my $now = now();
my $NOW = strftime('%Y-%m-%d %H:%M:%S', localtime($now));
my $to;
if (TEST) {
        $to = 'Joe.Chiu@treasury.nsw.gov.au';
} else {
        $to = 'Ali.Baig@treasury.nsw.gov.au,Indu.Neelakandan@treasury.nsw.gov.au,Joe.Chiu@treasury.nsw.gov.au';
}
my $from = 'Joe.Chiu@treasury.nsw.gov.au';
my $subject = "Just a test sample";
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

system $cmd;
rename "$cfile?$token", $cfile;
unlink "$cfile?$token";
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
$html .= sprintf qq(<tr><td colspan=%d align=right>%s</td></tr>), scalar @th, "&#9731; generated at $NOW";
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

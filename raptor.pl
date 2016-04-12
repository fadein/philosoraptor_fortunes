#!/usr/bin/perl

use warnings; use strict;
use List::Util qw(max);

# maximum width of any fortune
our $fortuneMaxWidth = 76;

my $raptor = <<'RAPTOR';
                ,,
         r-^`^wm^^wm-wmmw-^,
     .,~d ( 0)           () \
    (      .,                )
   (              ,,,,,,,,,,)
  (       ,---~~~~
  (      f        ``````````)
 (                  rw~--~mw
 |               rmY ,i^ir..
 |           ,rmw'        \ \
 )          )              \ \
)          )           _,--x /
RAPTOR

my $rapWidth = max( map { length } split(/\n/, $raptor));

# center the raptor within $fortuneMaxWidth
my $pad = int(($fortuneMaxWidth - $rapWidth) / 2);
$raptor = join("\n", map { (' ' x $pad) . $_ } split(/\n/, $raptor)) . "\n";

# skip until the 1st fortune
do { $_ = <> } until (/^%/);

my ($line, $top, $topPad, $botPad) = ('', undef, '', '');
while ($line = <>) {
	if ($line ne "\n" and defined $top) {
		$topPad = int(($fortuneMaxWidth - length($top)) / 2);
		$topPad = ($topPad > 0) ? (' ' x $topPad) : '';
		$botPad = int(($fortuneMaxWidth - length($line)) / 2);
		$botPad = ($botPad > 0) ? (' ' x $botPad) : '';
		print $topPad, $top, "\n", $raptor, "\n", $botPad, $line;
		($line, $top, $topPad, $botPad) = ('', undef, '', '');
	}
	elsif ($line eq "%\n") {
		print $line;
	}
	elsif ($line ne "\n") {
		$top = $line;
	}
}

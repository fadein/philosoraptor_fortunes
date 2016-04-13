#!/usr/bin/perl

use warnings; use strict;
use List::Util qw(max);

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

# skip until the 1st fortune
do { $_ = <> } until (/^%/);

my ($line, $top, $topPad, $botPad) = ('', undef, '', '');
while ($line = <>) {
	if ($line ne "\n" and defined $top) {

		# find the max width of the fortune
		my $fortuneMaxWidth = max( map({ length } ($top, $line)), $rapWidth);
		$topPad = int(($fortuneMaxWidth - length($top)) / 2);
		$topPad = ($topPad > 0) ? (' ' x $topPad) : '';

		# center the raptor within $fortuneMaxWidth
		my $rapPad = int(($fortuneMaxWidth - $rapWidth) / 2);
		$rapPad = ($rapPad > 0) ? (' ' x $rapPad) : '';
		my $paddedRaptor = join("\n", map { $rapPad . $_ } split(/\n/, $raptor)) . "\n";

		$botPad = int(($fortuneMaxWidth - length($line)) / 2);
		$botPad = ($botPad > 0) ? (' ' x $botPad) : '';
		print $topPad, $top, "\n", $paddedRaptor, "\n", $botPad, $line;
		($line, $top, $topPad, $botPad) = ('', undef, '', '');
	}
	elsif ($line eq "%\n") {
		print $line;
	}
	elsif ($line ne "\n") {
		$top = $line;
	}
}

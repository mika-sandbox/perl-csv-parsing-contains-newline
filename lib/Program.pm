package Program;
use strict;
use warnings;
use utf8;

use Text::CSV::Encoded;

sub parse {
  my ($class, $text) = @_;

  my $csv = Text::CSV::Encoded->new(+{
    binary       => 1,
    encoding_in  => 'utf8',
    encoding_out => 'utf8',
    sep_char     => "\t",
  });

  open my $fh, '<:utf8', \$text;

  $csv->header($fh);

  my @lines;

  while (my $fields = $csv->getline($fh)) {
    push @lines, $fields;
  }

  close $fh;

  return \@lines;
}

1;
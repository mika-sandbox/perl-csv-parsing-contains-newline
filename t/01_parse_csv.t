use strict;
use warnings;
use utf8;

use Encode qw(encode_utf8);
use Test::Spec;

use Program;

my $TEXT = <<'TEXT';
obj_1	obj_2	obj_3	obj_4	obj_5	obj_6
テスト1	テスト2	テスト3	テスト4	"改行
テスト1"	"改行
テスト2"
TEXT

describe '改行付き CSV ファイルについて' => sub {
  my @lines;

  before all => sub {
    @lines = @{
      Program->parse(encode_utf8($TEXT));
    }
  };

  it '1行目は' => sub {
    my @first = @{$lines[0]};

    is $first[0], 'テスト1';
    is $first[1], 'テスト2';
    is $first[2], 'テスト3';
    is $first[3], 'テスト4';
    is $first[4], "改行\nテスト1";
    is $first[5], "改行\nテスト2";
  };
};

runtests caller;
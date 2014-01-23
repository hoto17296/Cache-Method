use strict;
use Test::More;
use Test::Cache::Method;
use Time::HiRes qw/ gettimeofday tv_interval /;

subtest 'Cache::Method' => sub {
  my $t0 = [gettimeofday];
  scalar Test::Cache::Method->sum(1,2);
  my $t1 = [gettimeofday];
  scalar Test::Cache::Method->sum(1,2);
  my $t2 = [gettimeofday];
  cmp_ok tv_interval($t0, $t1), '>', 1, 'first call';
  cmp_ok tv_interval($t1, $t2), '<', 1, 'second call';

  my $t = new Test::Cache::Method;
  $t0 = [gettimeofday];
  scalar $t->sum(1,2,3);
  $t1 = [gettimeofday];
  scalar $t->sum(1,2,3);
  $t2 = [gettimeofday];
  cmp_ok tv_interval($t0, $t1), '>', 1, 'first call obj';
  cmp_ok tv_interval($t1, $t2), '<', 1, 'second call obj';

};

done_testing;

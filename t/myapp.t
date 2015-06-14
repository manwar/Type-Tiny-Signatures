use lib 't/lib';

use Test::More;

use Type::Tiny;
use Type::Tiny::Signatures qw(MyApp::Types);

fun greeting (AllCaps $name) {
    return "hello, $name";
}

is greeting('MARTIAN'), 'hello, MARTIAN';
ok ! eval { greeting('martian') };
ok $@;

ok 1 and done_testing;

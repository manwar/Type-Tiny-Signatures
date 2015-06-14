use Test::More;

use Type::Tiny;
use Type::Tiny::Signatures;

fun greeting (Str $name) {
    return "hello, $name";
}

is greeting('martian'), 'hello, martian';
ok ! eval { greeting([]) };
ok $@;

ok 1 and done_testing;

#include <a_samp>

new string[12] = {"Hello world"};

stringOrigin() {
    return string;
}

returnString() {
    return stringOrigin();
}

main() {
    // this code works, calling stringOrigin() which simply returns the string
    // contents directly into a native.
    // this is one "level" of function call depth.
    // uncomment these lines for a demo:
    //
    // new local[12];
    // strcat(local, stringOrigin(), sizeof(local));
    // print(local);

    // this code however, does not work. It calls a Pawn function which returns
    // the value of the return value of stringOrigin().
    // this is two "levels" of function depth and causes the error.
    //
    new local[12];
    strcat(local, returnString(), sizeof(local));
    print(local);
}

# array returns

[![sampctl](https://shields.southcla.ws/badge/sampctl-pawn--string--returns-2f2f2f.svg?style=for-the-badge)](https://github.com/Southclaws/pawn-string-returns)

A quick demonstration/minimal reproduction of a Pawn bug related to returning
arrays into the arguments of other functions.

Build and run this package to trigger the bug:

```bash
sampctl package run --forceBuild
```

## Explanation

Consider the following two functions:

```pawn
new string[12] = {"Hello world"};

stringOrigin() {
    return string;
}

returnString() {
    return stringOrigin();
}
```

Simple enough, right? There's a global string and a function that just returns
that global. There is also a second function which returns the return value of
the first function.

This code works, calling stringOrigin() which simply returns the string contents
directly into a native. this is one "level" of function call depth.

```pawn
new local[12];
strcat(local, stringOrigin(), sizeof(local));
print(local);
```

This code however, does not work. It calls a Pawn function which returns the
value of the return value of stringOrigin(). this is two "levels" of function
depth and causes the error.

```pawn
new local[12];
strcat(local, returnString(), sizeof(local));
print(local);
```

## Solution

*Always* use pass-by-reference to output array data from a function. The above functions would be rewritten as:

```pawn
new string[12] = {"Hello world"};

stringOrigin(output[], len = sizeof output) {
    strcat(output, string, len);
    return 0; // return 0 generally means success
}

returnString(output[], len = sizeof output) {
    return stringOrigin(output, len); // it's okay to directly pass the return of stringOrigin here because stringOrigin only returns a single cell value (0) not an array.
}
```

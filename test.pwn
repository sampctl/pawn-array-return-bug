#include <a_samp>

new string[12] = {"Hello world"};

stringOrigin() {
    return string;
}

returnString() {
    return stringOrigin();
}

main() {
    new padding1[100];

    new local[12];
    strcat(local, returnString(), sizeof(local));

    print(local);

    new padding2[100];

    dumparr(padding1);
    dumparr(padding2);
}

dumparr(arr[], len = sizeof(arr)) {
    for(new i; i < len; ++i) {
        printf("%d: %d", i, arr[i]);
    }
}

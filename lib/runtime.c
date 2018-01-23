#include <stdlib.h>
#include <string.h>
#include <stdio.h>

extern void printInt(int n) {
    printf("%d\n", n);
}

extern void printString(const char* str) {
    printf("%s\n", str);
}

int readInt() {
    int n;

    scanf("%d\n", &n);

    return n;
}

char* readString() {
    char* result = (char*)malloc(1);
    size_t length;

    getline(&result, &length, stdin);

    length = strlen(result);
    result[length - 1] = '\0';

    return result;
}

void error() {
    printf("runtime error");
    exit(1);
}

char* addStrings(char* a, char* b) {
    size_t lengthA, lengthB;
    lengthA = strlen(a);
    lengthB = strlen(b);

    char* result = malloc(lengthA + lengthB + 1);
    memcpy(result, a, lengthA);
    memcpy(result + lengthA, b, lengthB);
    result[lengthA + lengthB] = '\0';

    return result;
}

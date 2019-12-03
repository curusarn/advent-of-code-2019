#include <stdio.h>
#include <stdlib.h>

int main() {
    char * buff;
    size_t buffsize = 100;
    buff = (char*) malloc(buffsize * sizeof(char));
    if(!buff) {
        perror("Unable to allocate buffer");
        exit(1);
    }

    int * prg;
    size_t prgsize = 100;
    prg = (int*) malloc(prgsize * sizeof(int));
    if(!prg) {
        perror("Unable to allocate buffer");
        exit(1);
    }
    int n = 0;
    while (getdelim(&buff, &buffsize, ',', stdin) != -1) {
        int value;
        sscanf(buff, "%d,", &value);
        prg[n] = value;
        n++;
    }
    n--;
    free(buff);
    if (!feof(stdin)) {
        perror("Error reading input");
        free(prg);
        exit(1);
    }
    prg[1] = 12;
    prg[2] = 2;

    int op_ptr = 0;
    while (1) {
        if (op_ptr > n) {
            printf("Operation pointer out of bounds! (%d > %d)\n", op_ptr, n);
            free(prg);
            exit(2);
        }
        switch (prg[op_ptr]) {
            case 1: // add
                if (op_ptr + 3 > n || prg[op_ptr+1] > n || prg[op_ptr+2] > n || prg[op_ptr+3] > n) {
                    printf("Operation pointer (+args) out of bounds! (%d > %d)\n", op_ptr + 3, n);
                    free(prg);
                    exit(2);
                }
                prg[prg[op_ptr+3]] = prg[prg[op_ptr+1]] + prg[prg[op_ptr+2]];
                op_ptr += 4;
                break;
            case 2: // mul
                if (op_ptr + 3 > n || prg[op_ptr+1] > n || prg[op_ptr+2] > n || prg[op_ptr+3] > n) {
                    printf("Operation pointer (+args) out of bounds! (%d > %d)\n", op_ptr + 3, n);
                    free(prg);
                    exit(2);
                }
                prg[prg[op_ptr+3]] = prg[prg[op_ptr+1]] * prg[prg[op_ptr+2]];
                op_ptr += 4;
                break;
            case 99: // exit
                printf("pgr[0] = %d\n", prg[0]);
                free(prg);
                exit(0);
            default: // fail
                printf("fail with opcode %d\n", prg[op_ptr]);
                free(prg);
                exit(2);
        }
    }
}
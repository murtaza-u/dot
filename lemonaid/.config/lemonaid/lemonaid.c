#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdbool.h>
#include <string.h>

#define CMDLEN 110
#define LEN(X) sizeof(X)/sizeof(X[0])
#define FORBLOCKINBLOCKS for (unsigned int i = 0; i < LEN(blocks); i ++)

typedef struct {
    char *cmd;
    int interval;
    int signal;
} Block;

#include "config.h"

static char statusbar[LEN(blocks)][CMDLEN] = {0};

static void sighandler(int signal);
static void update(unsigned long long int time);
static void run_cmd(unsigned int index, const Block *block, char block_text[]);
static void write_status();

int main() {
    FORBLOCKINBLOCKS signal(SIGRTMIN + blocks[i].signal, sighandler);
    unsigned long int time = 0;
    while (1) {
        update(time);
        time ++;
        sleep(1.0);
    }
    return 0;
}

void sighandler(int signal) {
    signal = signal - SIGRTMIN;

    FORBLOCKINBLOCKS {
        if (blocks[i].signal == signal) {
            run_cmd(i, &blocks[i], statusbar[i]);
            write_status();
            break;
        }
    }
}

void run_cmd(unsigned int index, const Block *block, char block_text[]) {
    FILE *cmdf = popen(block -> cmd, "r");
    if (!cmdf) return;

    // Get output of the command
    fgets(block_text, CMDLEN - delim_length, cmdf);

    // close
    pclose(cmdf);

    // remove newline char at the end
    unsigned int len = strlen(block_text);
    if (block_text[len - 1] == '\n') block_text[len - 1] = '\0';

    // add the delimeter if block is not the last one
    if (index != LEN(blocks) - 1) strncat(block_text, delim, CMDLEN - len - 1);
}

void update(unsigned long long int time) {
    bool write = false;
    FORBLOCKINBLOCKS {
        if ((blocks[i].interval != 0 && time % blocks[i].interval == 0) || time == 0) {
            run_cmd(i, &blocks[i], statusbar[i]);
            write = true;
        }
    }
    if (write) write_status();
}

void write_status() {
    unsigned int len =  CMDLEN * LEN(blocks);
    char buffer[len];
    unsigned int i = 0;

    strncpy(buffer, "%{l}", len - 1);
    for (; i < left; i ++)
        strncat(buffer, statusbar[i], len - strlen(buffer) - 1);

    strncat(buffer, "%{c}", len  - strlen(buffer) - 1);
    for (; i < centre + left; i ++)
        strncat(buffer, statusbar[i], len - strlen(buffer) - 1);

    strncat(buffer, "%{r}", CMDLEN - strlen(buffer) - 1);
    for (; i < right + left + centre; i ++)
        strncat(buffer, statusbar[i], len - strlen(buffer) - 1);

    fprintf(stdout, "%s", buffer);
    fflush(stdout);
}

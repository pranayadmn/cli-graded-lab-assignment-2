#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void handle_sigterm(int sig) {
    printf("Parent received SIGTERM. Cleaning resources...\n");
}

void handle_sigint(int sig) {
    printf("Parent received SIGINT. Exiting gracefully...\n");
    exit(0);
}

int main() {
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    pid_t parent_pid = getpid();

    pid_t c1 = fork();
    if(c1 == 0) {
        sleep(5);
        kill(parent_pid, SIGTERM);
        exit(0);
    }

    pid_t c2 = fork();
    if(c2 == 0) {
        sleep(10);
        kill(parent_pid, SIGINT);
        exit(0);
    }

    while(1) {
        pause();
    }

    return 0;
}

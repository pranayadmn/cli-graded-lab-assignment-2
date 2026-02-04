#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int n = 3;

    for(int i = 0; i < n; i++) {
        pid_t pid = fork();

        if(pid < 0) {
            perror("fork failed");
            exit(1);
        }
        else if(pid == 0) {
            printf("Child %d started with PID %d\n", i+1, getpid());
            sleep(1);
            printf("Child %d exiting\n", i+1);
            exit(0);
        }
    }

    int status;
    pid_t child_pid;
    while((child_pid = wait(&status)) > 0) {
        printf("Parent cleaned child with PID %d\n", child_pid);
    }

    return 0;
}

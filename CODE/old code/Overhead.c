#include "velocity_buffer.h"
#include <stdio.h>
#include <unistd.h>

void initVelocityBuffer(VelocityBuffer *buffer, int *values, int maxSize) {
    buffer->values = values;
    buffer->maxSize = maxSize;
    buffer->head = buffer->tail = buffer->count = 0;
}

int writeToBuffer(VelocityBuffer *buffer, int velocity) {
    if (buffer->count < buffer->maxSize) {
        buffer->values[buffer->head] = velocity;
        buffer->head = (buffer->head + 1) % buffer->maxSize;
        buffer->count++;
        return 0; // Success
    }
    return -1; // Buffer full
}

int readFromBuffer(VelocityBuffer *buffer, int *velocity) {
    if (buffer->count > 0) {
        *velocity = buffer->values[buffer->tail];
        buffer->tail = (buffer->tail + 1) % buffer->maxSize;
        buffer->count--;
        return 0; // Success
    }
    return -1; // Buffer empty
}

void sendVelocitiesToStepper(VelocityBuffer *buffer, int freq) {
    int velocity;
    while (readFromBuffer(buffer, &velocity) != -1) {
        //printf("Sending %d to stepper motor\n", velocity);
        // Here we would send 'velocity' to the stepper motor

        // Sleep for the duration between velocity updates
        usleep(1000000 / freq); // Sleep for 1/freq seconds
    }
}


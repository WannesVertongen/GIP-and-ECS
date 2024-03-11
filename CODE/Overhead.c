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
        printf("Sending %d to stepper motor\n", velocity);
        // Here you would send 'velocity' to the stepper motor

        // Sleep for the duration between velocity updates
        usleep(1000000 / freq); // Sleep for 1/freq seconds
    }
}

int main() {
    int MAX_BUFFER_SIZE = 1000;
    int UPDATE_FREQUENCY = 500;

    int bufferValues[MAX_BUFFER_SIZE]; // Array to hold velocity values
    VelocityBuffer buffer; // Velocity buffer structure

    // Initialize the buffer
    initVelocityBuffer(&buffer, bufferValues, MAX_BUFFER_SIZE);

    // Write some velocities to the buffer
    printf("Writing velocities to buffer...\n");
    for (int i = 0; i < MAX_BUFFER_SIZE + 5; ++i) {
        int result = writeToBuffer(&buffer, i * 10); // Write velocities in increments of 10
        if (result == -1) {
            printf("Buffer is full. Stopping writing.\n");
            break;
        }
    }

    // Send velocities to stepper motor
    printf("Sending velocities to stepper motor...\n");
    sendVelocitiesToStepper(&buffer, UPDATE_FREQUENCY);

    return 0;
}
#ifndef VELOCITY_BUFFER_H
#define VELOCITY_BUFFER_H

typedef struct {
    int *values;    // Array to hold the velocities
    int head;       // Points to the next write position
    int tail;       // Points to the next read position
    int maxSize;    // Maximum number of elements in the buffer
    int count;      // Current number of elements in the buffer
} VelocityBuffer;

void initVelocityBuffer(VelocityBuffer *buffer, int *values, int maxSize);
int writeToBuffer(VelocityBuffer *buffer, int velocity);
int readFromBuffer(VelocityBuffer *buffer, int *velocity);
void sendVelocitiesToStepper(VelocityBuffer *buffer, int freq);

#endif /* VELOCITY_BUFFER_H */
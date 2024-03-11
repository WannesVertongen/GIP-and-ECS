#include <stdio.h>
#include <unistd.h> // For sleep/usleep functions
#include <time.h>   // For nanosleep

// Dummy function to represent sending a value to a stepper motor.
void sendValueToStepperMotor(int value) {
    printf("Sending %d to stepper motor\n", value);
}

// Function to initialize and start the timer.
void startMotorControlTimer(int *values, int array_size, int freq) {
    struct timespec ts;

    // Correctly calculate the delay in nanoseconds for the given frequency
    // First, calculate the period in seconds as a floating-point value
    double periodInSeconds = 1.0 / freq;

    // Then, convert the period to nanoseconds
    // sec to nanosec is * 1e9 (1 second = 1,000,000,000 nanoseconds)
    ts.tv_nsec = (long)((periodInSeconds) * 1e9);

    for (int i = 0; i < array_size; i++) {
        sendValueToStepperMotor(values[i]);
        nanosleep(&ts, NULL); // Sleep for the calculated period before sending the next value
    }
}

int main() {
    int motorValues[] = {10, 20, 30, 40, 50}; // Example values to send to the motor
    int array_size = sizeof(motorValues) / sizeof(motorValues[0]);
    int freq = 500; // Frequency in Hz
    startMotorControlTimer(motorValues, array_size, freq);
    
    return 0;
}

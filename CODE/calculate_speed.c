#include <stdio.h>
#include <stdlib.h>

void calculate_speed(float *positions, float *speeds, int array_size, float time_interval) {
    for (int i = 1; i < array_size; i++) {
        // Calculate the position difference between consecutive time steps
        float position_difference = positions[i] - positions[i - 1];
        
        // Calculate the speed by dividing the position difference by the time interval
        float speed = position_difference / time_interval;
        
        // Store the calculated speed in the speeds array
        speeds[i - 1] = speed;
    }
}
int main() {
    // Example input: positions array
    float positions[] = {0.0, 1.0, 3.0, 6.0, 10.0};
    int array_size = sizeof(positions) / sizeof(positions[0]);
    
    // Allocate memory for speeds array

    //Kzou dit veranderen en de arrays dezelfde grootte geven door een begin snelheid mee te geven
    float speeds[array_size - 1];

    
    // Example time interval
    float time_interval = 0.1;  // Assume time interval is 0.1 seconds
    
    // Calculate speeds
    calculate_speed(positions, speeds, array_size, time_interval);
    
    // Output speeds
    printf("Speeds:\n");
    for (int i = 0; i < array_size - 1; i++) {
        printf("%.2f ", speeds[i]);
    }
    printf("\n");
    
    return 0;
}
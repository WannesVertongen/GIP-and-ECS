## Problems occured during experiments

1. Position setpoint = 1m, but robot continues movement even when current x-position is >1m. Due to intergral part of controller?? Gives bad results for x velocity

2. Acceleration not high enough to reach swing 

3. We use 85 for x velocity and position (instead of 100 as it should)


Feedback Boris

1. Doe ramp hoger om limiet te zoeken
2. Eerst in beweging brengen om eerste inertie te overwinnen
3. Kabel motor gebruiken want die wel snel (servo)

## New approach
Begin met starthoek
Lagere snelheid
angle loggen in c
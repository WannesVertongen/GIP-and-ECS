//Functie overzicht:
//1.Input (x1,y1), (x2,y2) 
//2.GenInitPath.c
//3.Bereken of afstand mogelijk is in 1 swing
// Nee: 
//      { FUNCTIE
//          constante hoek propogatie? tot of max afstand single swing of dichterbij?    
//          Wanneer dicht genoeg, uit deze functie terug naar MAIN }
//
// createPath.c (single swing)

//VRAAG !!!!
//Wat doen we met de arrays robot_pos enzo met de verschillende functies. Oftewel doen we verschillende arrays, of we moeten zien
//dat we niet de vorige waardes overwriten. Dus dan moet in single swing ge bv de array beginnen aanvullen vanaf t= (size init) +(size multiple)
//?????
//

#include "createPath.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h> 



int Multiple_Swing_Trajectory(coordinates co, limit lim, pathdata *pdat)
{
    //Initialize robot
     GenInitPath(co, lim, *pdat);

     //Now the robot is at (x1,y1). Check if the distance can be bridged in one swing
     //Ik denk dat de enige reden dat het niet in 1 swing kan is als de maximale kabel lengte wordt overschreden. Want (x1,x2) 
     //moeten sws binnen de limieten van het robot bereik blijven, wat wil zeggen dat de robot altijd tussen x1 en x2 kan gaan
     //staan. Enkel wanneer de kabel lengte dat niet aan kan gaat het in meerdere swings moeten.

     





}
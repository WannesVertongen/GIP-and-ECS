//Functie overzicht:
//1.Input (x1,y1), (x2,y2) 
//2.GenInitPath.c
//3.Bereken of afstand mogelijk is in 1 swing
// Ja: {createPath.c (single swing)}
//
// Nee: 
//      { FUNCTIE
//          deel afstand op in twee
//          voer dubbele 'single_swing' uit met geupdate coordinaten}
//
// Geef path aan buffer functie
// Geef buffer arrays aan robot 

//VRAAG !!!!
//Wat doen we met de arrays robot_pos enzo met de verschillende functies. Oftewel doen we verschillende arrays, of we moeten zien
//dat we niet de vorige waardes overwriten. Dus dan moet in single swing ge bv de array beginnen aanvullen vanaf t= (size init) +(size multiple)
//?????
//


#include "createPath.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h> 



int Multiple_Swing_Trajectory(coordinates *co, limit lim, pathdata *pdat)
{
    //Initialize robot
     GenInitPath(*co, lim, *pdat);

     //Now the robot is at (x1,y1). Check if the distance can be bridged in one swing

     //Ik denk dat de enige reden dat het niet in 1 swing kan is als de maximale kabel lengte wordt overschreden. Want (x1,x2) 
     //moeten sws binnen de limieten van het robot bereik blijven, wat wil zeggen dat de robot altijd tussen x1 en x2 kan gaan
     //staan. Enkel wanneer de kabel lengte dat niet aan kan gaat het in meerdere swings moeten.

    //x_m zou dan al berekend moeten worden in GenInit !!
    float max_required_cl;

    if(pdat->x_m > (co->x_2-co->x_1)/2){ //X_m over de helft (y2<y1)
        
        max_required_cl = sqrt(pow((pdat->x_m - co->x_1), 2) + pow(co->y_1, 2));
    }
    else{
        max_required_cl = sqrt(pow((pdat->x_m - co->x_2), 2) + pow(co->y_2, 2));
    }

    //Single swing possible:
    if(max_required_cl <= lim.MAX_cable_length)
    {
        createPath(*co, lim, *pdat);
        return 0;
    }

    //Multiple swing required
    if(max_required_cl > lim.MAX_cable_length)
    {
      //Divide distance in two equal parts
      float x_mid = (co->x_2-co->x_1)/2;
      float y_mid = fabs((co->y_2-co->y_1)/2);  //Kan ook eerst swing met constante cl, dan is y_mid=y1. Maar dan wel op korte afstand veel hoogte overbruggen

      //Update end position for first swing (co moet nu dus ook een pointer zijn: pas dit aan in createPath)
      float x_end = co->x_2;
      float y_end = co->y_2;

      co->x_2 = x_mid;
      co->y_2 = y_mid;

      //First swing
      createPath(*co, lim, *pdat);

      //Update start & end position for second swing
      co->x_1 = pdat->Object_x[-1]; //final position of array if size is correct
      co->y_1 = pdat->Object_y[-1];

      co->x_2 = x_end;
      co->y_2 = y_end;

      //Second swing
      createPath(*co, lim, *pdat);  
    }

    //Geef data mee aan buffer

}

   
     






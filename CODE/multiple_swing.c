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



int Multiple_Swing_Trajectory(coordinates co, limit lim, pathdata *pdat)
{
    //Initialize robot
     GenInitPath(co, lim, *pdat);

     //Now the robot is at (x1,y1). Check if the distance can be bridged in one swing

     //Ik denk dat de enige reden dat het niet in 1 swing kan is als de maximale kabel lengte wordt overschreden. Want (x1,x2) 
     //moeten sws binnen de limieten van het robot bereik blijven, wat wil zeggen dat de robot altijd tussen x1 en x2 kan gaan
     //staan. Enkel wanneer de kabel lengte dat niet aan kan gaat het in meerdere swings moeten.

    //x_m zou dan al berekend moeten worden in GenInit 
    float max_required_cl;

    if(pdat->x_m > (co.x_2-co.x_1)/2){ //X_m over de helft (y2<y1)
        
        max_required_cl = sqrt(pow((pdat->x_m - co.x_1), 2) + pow(co.y_1, 2));
    }
    else{
        max_required_cl = sqrt(pow((pdat->x_m - co.x_2), 2) + pow(co.y_2, 2));
    }

    if(max_required_cl > lim.MAX_cable_length)
    {
        //MULTIPLE SWING FUNCTION: fase1: bewegingswet om naar juiste locatie te gaan? Of versnellen tot v_constant? Maar dan ook 
        //weer vertraging nodig

        int array_size = 1; //Nieuwe array of verder gaan op array van GenInit?
        int moving_time = 5; //Abritary but is a magic number 

        //Bereken tot waar robot moet gaan voor single swing kan activeren. Denk goed na want dit moet gaan tot x_m snapje en dan ineens
        //Stoppen voor swing beweging


        // Update robot_position (cable_length stays constant)
        float time;
        int i;

        //Using bang-bang
        for (time = 0, i = 0; i < array_size/2; time += lim.T_s, i++) {
            pdat->robot_pos_over_time[i] = 
        }



        // cable length in the first 5 seconds with a bang-bang motion

        if (i < ceil(array_size/2)) {
            float cl = pdat->cl_1 + 2*distance_cl * pow(time/pdat->t_swing,2);
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl; //Hoezo update de object coordinaat? Object staat toch nog stil hier?
        }
        if (i >= ceil(array_size/4) && i < ceil(array_size/2)) {
            float cl = pdat->cl_1 - 2*distance_cl * pow(time/pdat->t_swing,2)  + 4*distance_cl*(time/lim.T_s) - distance_cl;
            pdat->cable_length_over_time[i] = cl;
            pdat->Object_y[i] = cl;
        }

         // position of the motor after the cable also with a bang-bang motion 
        if (i >= ceil(array_size/2) && i < ceil(array_size * 0.75)) {
            pdat->robot_pos_over_time[i] = co.x_1 + 2*distance_x * pow((time-array_size*lim.T_s)/pdat->t_swing,2);
        }
        if (i >= ceil(array_size * 0.75) && i < array_size) {
            pdat->robot_pos_over_time[i] = co.x_1 -2*distance_x * pow((time-array_size*lim.T_s)/pdat->t_swing,2) + 4*distance_x*((time-array_size*lim.T_s)/pdat->t_swing) -distance_x;
        }
    }


    }

    //Nu is het binnnen bereik van 1 swing
    //Update input naar huidige coordinaten 
    createPath(co, lim, *pdat);

     





}
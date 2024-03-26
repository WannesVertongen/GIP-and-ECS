#include "createPath.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h> 

#define PI 3.14159265


// DOEL van de functie 
// 1) schok voor touw in te korten op basis van Δcl=h+marge.  
// ΔE=mgΔh=mg(Δcl∗cos(θ_1​))
// Duratie inkorting T = $\frac{\Delta E}{P_{nom}}$
// * Bewegingswet keuze: 
//    - Minimum jerk
//    - $s(\tau) = \frac{16}{3}\tau^3    (0<\tau<0.25)$
//    - $s(\tau) = -\frac{16}{3}\tau^3 + 8\tau^2 - 2\tau + \frac{1}{6} (0.25<\tau<0.75)$
//    - $s(\tau) = \frac{16}{3}\tau^3 - 16\tau^2 + 16\tau -\frac{13}{3} (0.75<\tau<1)$
//    - -> $cl(t) = cl_2 + \Delta cl* s(\tau)$
// 2 -> 3
//* $\theta_1 = \theta_2$
//* Duratie swing halve periode: $T/2 = \pi \sqrt{\frac{cl}{g}}$ 


// - halve breedte marge: 
//        - $\Delta \theta = 2 sin^{-1}(\frac{B}{4cl}) $ 
//        - $\theta_3 = \theta_2 - \Delta \theta$
// Tijd tussen $\theta_2$ en $\theta_3$:
//    - $\theta(t) = \theta_0 cos(\sqrt{g/l}t)$
//    - $t_2 = \pi \sqrt{\frac{cl}{g}}$ 
//    - $\Delta t = \sqrt{l/g}*cos^{-1}(\frac{\theta_3}{\theta_2})$
//    - $t_3 = t_2 + \Delta t$

//* De coordinaat van de linker-onderhoek van de bak bij $\theta_3$ is dan:
//    - $x_3 = x_M + cl*sin(\theta_3) - \frac{B}{2}*cos(\theta_3)$
//    - $y_3 = cl*cos(\theta_3) + \frac{B}{2}*sin(\theta_3)$

//* De kabel verlenging tussen $\theta_2$ en $\theta_3$ is dan:
//    - $\Delta cl = marge_1 + \frac{h}{2} + marge_2$
//    - $\tau = \frac{t}{\sqrt{l/g}*cos^{-1}(\frac{\theta_3}{\theta_2})}$

//* Bewegingswet keuze:
//    - Minimal acceleration (bang-bang)
//    - $s(\tau) = 2\tau^2 (0<\tau<5)$
//    - $s(\tau) = -2\tau^2 + 4\tau -1 (0.5<\tau<1)$
//    - $cl = cl_2 + s(\tau)*\Delta cl (t_2<t<t_3)$

// * Eindpositie:
//    * $L_p$ = Lengte platform
//    * $x_e = x_3 + L_p * cos(\theta_3)$
//   * $y_e = y_3 + L_p * sin(\theta_3)$
//* Aanpassing kabel lengte:
//    * $\Delta cl = \sqrt{(x_e-x_3)^2 + (y_e -y3)^2}$

//* Bewegingswet keuze: Bang-Bang
//   - max acceleratie: $\frac{dS^2}{dt^2}_{max} = \frac{L}{T^2}*a_{max}$
//    - tijd: $T = \sqrt{\frac{a_{max}*L_p}{g*sin(\theta_3)}}$ 
//    - $t_4 = t_3 + T$


//    - Minimal acceleration (bang-bang)
//    - $s(\tau) = 2\tau^2 (0<\tau<5)$
//    - $s(\tau) = -2\tau^2 + 4\tau -1 (0.5<\tau<1)$
//    - $cl = cl_3 + s(\tau)*\Delta cl (t_3<t<t_4)$

// nodige inputs: theta_1 h_bak, m_bak, P_nom, cl_init cl_1 = \srt(5), theta_2, T_swing, theta_3, B_bak, L_p -> x_e ,y_e, a_max

## Opstelling:


<div style="transform: rotate(90deg);">
    <img src="new_test_setting.svg" alt="Image failed to load" width="750" height="500">
</div>

* Aangezien onze vorige opstelling de verticale hijsbeweging pure arbeid van de motor was. Blijkt dat dit toch niet zo energie efficient is en ook niet zo tijdsefficient. 
* In deze opstelling willen we een hogere eindpositie bereiken zonder te hijsen maar door gebruik te maken van een swing. 
* Qua opstelling valt de start constructie weg en blijft de landingsconstructie nodig, maar nu op een hoogteverschil $\Delta h$ ten opzichte van de start. 
* Uit dynamische vergelijking hebben we  transfer function $\theta / x = \frac{-s^2}{l*s^2 + g}$ afgeleid. Door verschillende $x(t)$ profielen op te leggen, proberen we $\Delta h$ te bereiken met een hoek $\theta < 45°$ zodat de bak niet omkantelt. 
### Verder werk

* Het zoeken naar een optimaal $x(t)$ profiel voor deze opstelling aan de hand van matlab simulaties.
* Berekening maken voor energie om te kunnen vergelijken 


### input shaping

Om optimaal bewegingsprofiel op te stellen moet er eerst een maximale hoek worden berekend die we willen dat de opstelling behaald.

Maximaal kan de bak tot $ \theta= \pi /2$ komen aangezien de flesjes er zo niet uitvallen. Maar omdat de bak dan geen horizontale snelheidscomponent heeft kan de bak enkel verticaal verplaatsen moest dan de kabel lengte aanpasbaar zijn. Het hoogste platform bevind zich dan net uit de draaicirkel onder de bak. op positie:

* De coordinaat van de linker-onderhoek van de bak bij $\theta_{platform}$ is dan:
    - $x_3 = x_M + cl*sin(\theta_3) - \frac{B}{2}*cos(\theta_3)$
    - $y_3 = cl*cos(\theta_3) + \frac{B}{2}*sin(\theta_3)$

    - $\theta_{max} = \frac{\pi}{2} - \frac{cl - H_{bak}}{cl}$   komt van  $cl*cos(0) - cl*sin(\frac{\pi}{2} - \theta_{max}) = H_{bak}$

* De bak zou dan nog moeten gekantelt worden zodat wanneer deze op de loopband terecht komt dat door zwaartekracht recht wordt gezet. 
    - zwaartepunt in midden dus helling van platform is dan kleiner dan $\frac{\pi}{4}$ met de verticale. 
    - neem helling platform 40° met verticale. (een marge van 5°)


* er moet nog gemeten worden of deze hoek haalbaar is binnen de tijd. 
    $\Delta t = \sqrt(\frac{cl}{g}) * cos^{-1}(\frac{\Theta_{max}}{\frac{\pi}{2}})$
    of via de val versnelling.

    ik denk dat het sowieso haalbaar is want is er recht onder.


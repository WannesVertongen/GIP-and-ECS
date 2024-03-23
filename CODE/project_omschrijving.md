## Proef opstelling  

<img src="proefopstelling.svg" alt="Image failed to load" width="750" height="500">

### Afmetingen  
* Gelijke hoogte begin en eind
* 1m x 2m  -> kleine hoeken swing +hanger
### Toleranties:
* positie (x_3,y_3)
* hoogte schuine wand rechts
* ondersteuning tegen kantelen links


## Stap 1: initialisatie


<img src="initialisatie.svg" alt="Image failed to load" width="1000" height="600">

### bak dimensies

* h = 24cm
* B = 30cm
* d = 40cm

* $ R = \sqrt{B^2/4 + h^2}$
* $\alpha$ = $bgtan(\frac{B}{2h}) $

### 1. Bak hijsen 
* $\Delta E  = mg\Delta h$
* tijd T = 5s (zelf gekozen)
* P(W) = $\frac{\Delta E}{t}$

* Bewegingswet keuze:
    - Minimal rms acceleration (3rd degree polynomial)
    - $s(\tau) = 3\tau^2-2\tau^3$
    - $S(t) = \Delta h* s(\tau)$ met $\tau=\frac{t}{T}$
    - $a_{max} = 4$
    
    

* Bewegingswet verantwoording:
    - Bak ophijsen -> torque-beperking op motor -> beperk versnelling
    - Snelheidsbeperking niet van belang
    - Minimal rms acceleration zorgt voor laagste gemiddelde torque en dus laagste stroomverbruik

* Maximale belasting:
    - $a_{max} = \frac{dS^2}{dt^2}_{max} = \frac{\Delta h}{T^2} * 4$
    - $F_{max}$ = massa  bak * $a_{max} $ 

### Bak kantelen 
* Om te weten hoe ver de robot zich moet verplaatsen volgens de x-as om de start positie te bereiken, wordt er eerst uitgerekend hoeveel de robot moet bewegen om de bak van rechte positie tot schuine positie op de start wand te brengen (zie onderaan tekening initialisatie).

* $x_2-x_1 = \frac{b}{2}$
* $x_3 - x_2 = R*cos(\alpha+\theta_1)$
* $\Delta x_{kantel} = \frac{b}{2} + R*cos(\alpha + \theta_1)$

### 2. Verplaatsing in x
* Theoretisch gezien: geen vermogenverbruik want kracht staat loodrecht op verplaatsing. Vereenvoudiging geldig als beweging gebeurt zonder schommelen van de massa.
* Tijd T = 5s (zelf gekozen)
* Afstand $\Delta x_{tot} = \Delta x_{1->2} + \Delta x_{kantel}$

* Bewegingswet keuze:
    - 5th degree polynomial 
    - $s(\tau) = 6\tau^5 -15\tau^4 +10\tau^3$
    - S(t) = $\Delta x_{tot}* s(\tau)$ met $\tau=\frac{t}{T}$

* Beweginswet verantwoording:
    - Lage eindsnelheid nodig voor tijdens het kantelen van de bak.
    - Beperkte versnelling en jerk nodig zodat bak niet schommelt en/of kabel niet trilt.
    - In vergelijking met andere 3e graads continue functies: laagste piek snelheid, piek versnelling en rms versnelling.

MISSCHIEN VERMELDEN DAT IN DE PRAKTIJK BAK HIJSEN EN NAAR RECHTS BRENGEN WSS TEGELIJKERTIJD GAAT GEBEUREN OM TIJD TE BESPAREN?




### 3. Robot naar Xm = $\frac{x2-x1}{2}$
* Robot wordt exact in het midden tussen start en eind geplaatst zodat er zich een eenvoudige pendulum beweging voordoet.
* Tijdens het verplaatsen van de robot naar $x_m$ moet de kabel verlengen zodat het object op zijn huidige positie blijft liggen.

* verplaatsing robot = ( hier moet een bewegingswet komen vanuit de lessen beweging en trillingen )

* kabel lengte: cl(t) = $\sqrt{x(t)^2+y^2}$
* Eind positie: cl = $\sqrt{x_1^2+y_1^2}$ & $\theta_1 = bgtan(\frac{y_1}{x_m})$

## Stap 2 : swing


<img src="swing.svg" alt="Image failed to load" width="1000" height="600"> 

### 1 -> 2
* kabel lengte in korten: $\Delta cl = h + marge$
* cl(t) =  ( hier moet een bewegingswet komen vanuit de lessen beweging en trillingen )
* begeleiding zodat bak niet fout omkantelt 

### 2 -> 3
* $\theta_1 = \theta_2$
* Duratie swing halve periode: $T/2 = \pi \sqrt{\frac{cl}{g}}$ 
* Kritisch koppel 
    - $ F_t - G = m* a_r$
    - $a_r = v^2/cl$
    - $v = \sqrt{2g(cl-y_1)} $ 
    - $F_t = m(\frac{2g(cl-y_1)}{cl} + g) $
    - T = ?
    - P = ? (geen positieverandering van de motor)

## Stap 3: Landing

<img src="landing.svg" alt="Image failed to load" width="1000" height="600">

MArge inrekenen dat object zeker hoog genoeg komt, maar $\theta_1 = \theta_2$, dus landingswand moet lager en meer naar links.

### marge:

* volledige bak marge:  
    - $sin(\frac{\Delta \theta}{2}) = \frac{B}{2cl}$
    - $\Delta \theta = 2 bgsin(\frac{B}{2cl}) $ 
* hale breedte marge: 
    - $\Delta \theta = 2 bgsin(\frac{B}{4cl}) $ 
    - $\theta_3 = \theta_2 - \Delta \theta$

* tijd tussen $\theta_2 en \theta_3$: 
    - $\theta(t) = \theta_0 cos(\sqrt{g/l}t)$
    - $t = \sqrt{l/g} *bgcos(\frac{\theta_3}{\theta_2})$

* positie landplatform:
    - hoek = $\theta_3$
    - $x_3 = x_M + cl*sin(\theta_3)$
    - $y_3 = cl*cos(\theta_3)$
    - $\Delta x = sin(\theta_2) - sin(\theta_3)$
    - $\Delta y = cos(\theta_2) - cos(\theta_3)$

* Beweging van $(x_2,y_2) -> (x_3,y_3)$:






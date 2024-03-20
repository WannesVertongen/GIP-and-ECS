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


### bak hijsen 
 * $\Delta E  = mg\Delta h$
 * tijd t = 5s (zelf gekozen)
 * P(W) = $\frac{\Delta E}{t}$

### verplaatsing in x

theoretisch gezien geen arbeid want kracht staat loodrecht op verplaatsing

###
bak kantelen 

* $x_2-x_1 = \frac{b}{2}$
* $x_3 - x_2 = R*cos(\alpha+\theta_1)$
* $\Delta x_{tot} = \frac{b}{2} + R*cos(\alpha + \theta_1)$

### bak dimensies

* h = 24cm
* B = 30cm
* d = 40cm

* $ h = \sqrt{B^2/4 + h^2}$
* $\alpha$ = $bgtan(\frac{B}{2h}) $


### robot naar Xm = $\frac{x2-x1}{2}$
kabel met lengte moet aangepast worden zodat object terplekken blijft

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

Tekening van de landing 

MArge inrekenen dat object zeker hoog genoeg komt, maar $\theta_1 = \theta_2$, dus landingswand moet lager en meer naar links.

### marge:
tekening van de hoek

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






## Experimenten
### 1. Stijfheid kabel
De kabel waar het object aan hangt heeft een zekere axiale stijfheid $k_{kabel}$. Eerst wordt lengte $l_1$ van de kabel gemeten zonder last. Vervolgens wordt er een last aan de kabel gehangen met gekende massa m. De nieuwe lengte $l_2$ van de kabel wordt nogmaals gemeten. De stijfheid wordt dan vervolgens gevonden door:

$ k_{kabel} = \frac{F}{\Delta x}=\frac{m*g}{l_2-l_1}$

Het experiment kan voor verschillende massa's herhaald worden voor een nauwkeuriger resutaat.

### 2. Robot aansturing
Essentieel aan de opstelling is het vinden van een geschikt verplaatsingsprofiel $x(t)$ of snelheidsprofiel $v(t)$ voor de beweging van de robot, om de gewenste beweging van het object te bereiken. Verschillende soorten profielen worden hiervoor eerst in Matlab gesimuleerd om een eerste voorspelling van de respons van het object te maken. Dit werd gedaan voor de eerder beschreven opstelling, met een kabellengte van 1.8m en $\theta_{opt} = 60.85° $. 

De plots van alle resultaten kunnen gevonden worden in de volgende map: [Plots](https://github.com/WannesVertongen/GIP-and-ECS/tree/main/Matlab/Plots). Hieronder worden enkele van de resultaten besproken.

#### 2.1 Constante snelheid
Een eerste profiel dat getest wordt is dat van een 'ramp input', ofwel een beweging met constante snelheid. Hoewel dit snelheidsprofiel in de realiteit nooit exact nageleefd kan worden aangezien het een oneindige versnelling van de robot vereist, is het door zijn eenvoud toch interessant om naar te kijken. Verschillende snelheden v worden opgelegd. Hieronder is het resultaat voor $v = 5m/s$ te zien.

<img src="fig_rampv5.svg" alt="Image failed to load" width="750" height="500">

Onder elkaar worden respectievelijk de robot positie en hoek $\theta$ in de tijd en het verloop van het object geplot. De rode stippellijn op de onderste twee plots duidt het moment of de plaats aan waarop de robot niet meer beweegt, maar stilstaat op zijn eindpositie. De groene stippellijn staat op een hoogte van $\theta_{opt} = 60.85° $. We zien dat het object wordt meegesleurd met de robot en dan oscilleert rondom het rustpunt van de robot. Voor een ramp input is dit de laagste snelheid van de robot waarbij het object nog net de gewenste horizontale en verticale verplaatsing bereikt. Het verloop van de hoek is wel niet bepaald glad wat voor trillingen in de kabel kan zorgen en liefst vermeden wordt.

De resultaten tonen ook meteen dat er geen demping of luchtwrijving in de dynamische vergelijkingen is inbegrepen. Of dit weldegelijk een correcte vereenvoudiging is, dient nagegaan te worden door het experiment. De 'ramp input' dient opgelegd te worden en vervolgens kan er gekeken worden naar het effectieve verloop van het object. Behaalt het object wel de vereiste hoogte? Blijft het touw wel gestrekt tijdens de zwaaibeweging?


#### 2.2 Constante versnelling & vertraging
Een realistischer profiel voor de robot is een met een constante versnelling gevolgd door een constante vertraging, ook wel gekend als de 'bang-bang' motion law. Een bewegingswet wordt bepaald door de af te leggen afstand, hier $\Delta x_r$, en de duratie van de beweging T. Nu zal er dus een analyse gedaan worden voor verschillende T's. Het resultaat voor T=0.751102s wordt getoond, wat overeenkomt met een gemiddelde snelheid van 3m/s.

<img src="fig_bangbangv3.svg" alt="Image failed to load" width="750" height="500">

Het object bereikt nu al voor een lagere snelheid net het doel, weliswaar op een later tijdstip. Een hogere snelheid behaalt uiteraard ook het doel, maar heeft wel een grotere 'overshoot' wat een verspilling van energie is. Dit is 1 van de trade-offs die verder besproken worden. Het verloop van $\theta$ en dus ook van het object is nu veel gladder.

#### 2.3 7e-graads polynoom
De vorige twee opgelegde profielen waren respectievelijk 1e en 2e orde continu. Onze verwachting waren dat je een niet al te 'gladde' functie nodig had om een grote amplitude swing van het object te verkrijgen. De 7e-graads polynoom is 4e orde continu. Deze werd getest om onze verwachting te testen en hieruit blijkt dat deze eigenlijk fout was. Ook dit profiel haalt voor een gemiddelde snelheid van 3m/s het gewenste doel, zelfs met een iets grotere marge, zoals hieronder getoond. De reden hiervoor kan zijn dat dit profiel een hogere pieksnelheid heeft dan de vorige.  

<img src="fig_polyv3.svg" alt="Image failed to load" width="750" height="500">


De respons van het voorwerp op de verschillende profielen kan vergeleken worden met de voorspellende analyse en met elkaar. Is er effectief zo weinig verschil tussen de profielen? Heeft het al dan niet gladde verloop van $\theta$ een merkbaar effect op de beweging? Kan de demping en wrijving effectief worden verwaarloosd en kan dit voor alle profielen?

#### 2.4 Trade-off's

De experimenten brengen enkele trade-off met zich mee:

1. Voor elk profiel geldt dat een hogere gemiddelde snelheid zorgt voor een grotere maximale hoek. Er kan gekozen worden voor een $\theta > \theta_{opt}$ om een marge in te bouwen, maar dit gaat wel ten koste van de energie-efficiëntie.

2. Een eenvoudige maar niet onbelangrijke trade-off is de afweging dus duratie van de beweging en energieverbruik, die tegengestelde eisen stellen aan de snelheid.

3. Een eenvoudiger profiel voor de aansturing resulteert in een hogere vereiste snelheid om het doel te halen. Een complexer profiel is dus aantrekklijker op vlak van energie-efficiëntie, maar kan eventueel zorgen voor een moeilijkere aansturing/controller van de robot.



## Energieverbruik 

????



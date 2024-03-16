## Specificaties:

### Bewegingsbereik:
- Breedte: 75 cm
- Lengte: 113 cm
- Hoogte: 270 cm

Reden voor specificatie: Dit bewegingsbereik is gekozen op basis van de ruimtelijke vereisten van het project, waaronder de benodigde werkruimte en manoeuvreerbaarheid van de actuatoren.

Aangezien we met swing beweging werken kan het object dus uit dit werkingsgebied komen. Wij werken enkel met 2D bewegingen van x en y. Limieten in de functies moeten worden opgelegd zodat object positie ook binnen een bepaald veiligheidsdomein worden gehouden. Dit kan door op elk moment van de beweging de positie van het object te evalueren.

### Dimensies Motor:
- Breedte: 12 cm
- Lengte: 11 cm
- Hoogte: 20 cm

Reden voor specificatie: Deze afmetingen zijn gemeten in het labo en beperken de beschikbare bewegingsruimte.

### Motor:
- Specificaties Motor_kabel: zie model (steppermotor)
- Specificaties Motor_x: zie model (steppermotor)

Reden voor specificatie: De specifieke motormodellen zijn nodig om factoren zoals het koppel en snelheid te evalueren. En zorgen dat het traject de boven limieten vermijd.

### Bout:
- Gewicht: te meten

Reden voor specificatie: Het gewicht van de bout zal worden gemeten om de dynamische belasting op het systeem te evalueren en te waarborgen dat de actuatoren deze kunnen dragen.

### Snelheidsoplegging:
- Maximale snelheid van de motor voor gecontroleerde bewegingen: 0.2

Reden voor specificatie: De maximale snelheid is beperkt tot 0.2 om nauwkeurige en gecontroleerde bewegingen te garanderen voor gebruiksveiligheid.

## Ontwerp

### Actuatoren:
- Motor voor x
- Motor voor kabel lengte
Reden voor specificatie: Dit zijn de bestuurbare componenten van het systeem in Real-Time.

### Sensoren:
- Encoder in x
- Encoder in kabel lengte
- Uiteindelijke exacte positiebepaling via gemonteerde camera

Reden voor specificatie: Dit zijn de sensoren die informatie bevatten over het systeem in Real-Time.

### Software:
- Geïmplementeerde functies in C
- Andere software nodig?

Reden voor specificatie: De nodige software voor het realiseren van de beweging.

### Communicatie:
- Tussen code en sensoren / actuatoren?
- 500 Hz

Reden voor specificatie: 500 Hz is de frequentie waarop de robot de input snelheden inleest. 

## Trade-Off's:

- Complexiteit is momenteel gereduceerd voor effectieve resultaten. Deze dient nog omhoog te gaan eens we meer weten over de uitvoering    van onze code in de realiteit.
- Is er genoeg aan de berekeningen voor onze code of is er nood aan feedback van de camera?
- Is de bout zwaar genoeg en klein genoeg om gereduceerd te worden tot een punt massa?
- Hoe gaan obstakels zoals randen onze resultaten beïnvloeden?

# Experiment
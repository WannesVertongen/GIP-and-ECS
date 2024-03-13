## Specificaties:

### Bewegingsbereik:
- Breedte: 75 cm
- Lengte: 113 cm
- Hoogte: 270 cm

### Dimensies Motor:
- Breedte: 12 cm
- Lengte: 11 cm
- Hoogte: 20 cm

### Motor:
- Specificaties Motor_kabel: zie model (steppermotor)
- Specificaties Motor_x: zie model (steppermotor)

### Bout:
- Gewicht: te meten

### Snelheidsoplegging:
- Maximale snelheid van de motor voor gecontroleerde bewegingen: 0.2

### Snelheid voor swing beweging:
- Afhankelijk van swingmethode en nog te specificeren. Zorg ervoor dat de beweging niet kan worden uitgevoerd indien te hoog. Zorg ervoor dat de lengte snelheden niet te hoog zijn zodat de bout niet in het rond vliegt. Eerst testen zonder bout.

## Ontwerp

### Actuatoren:
- Motor voor x
- Motor voor kabel lengte

### Sensoren:
- Encoder in x
- Encoder in kabel lengte
- Uiteindelijke exacte positiebepaling via gemonteerde camera

### Software:
- Geïmplementeerde functies in C
- Andere software nodig?

### Communicatie:
- Tussen code en sensoren / actuatoren?
- 500 Hz

## Trade-Off's:

- Complexiteit is momenteel gereduceerd voor effectieve resultaten. Deze dient nog omhoog te gaan eens we meer weten over de uitvoering van onze code in de realiteit.
- Is er genoeg aan de berekeningen voor onze code of is er nood aan feedback van de camera?
- Is de bout zwaar genoeg en klein genoeg om gereduceerd te worden tot een punt massa?
- Hoe gaan obstakels zoals randen onze resultaten beïnvloeden?


## Opmerkingen presentatie 29/03

1.  Input shaping: gebruik input shaping om horizontale bewegingen robot te maken (vaste tijd)

2. 'Dynamische steun' (weet niet meer wat ze hiermee bedoelen)

3. Afweging tijd vs energie veel meer in rekening brengen! Wanneer tijdsoptimaal, wanneer energie efficiënt. Bereken totaal energieverbruik en vergelijk met energieverbruik van standaard beweging.

4. Start paal: servo in schuine wand --> wand laten kantelen ipv bak eraf trekken. Dimensioneer servo met max koppel nodig.

5. Landing: bakken schuin --> hoe oplossen? Gebruik van een loopband? 

6. Hoe ontwerp aanpassen naar landplaats hoger dan startplaats?

## Oplossingen

#### 1. Input shaping
* Zie documentatie voor paper met uitleg
* Viskeuze demping volgens x [Ns/m] en volgens kabelhoek [Ns/theta] nodig: hoe inschatten/meten?
* Dynamische vergelijkingen vragen weer om F als input, maar input shaping geeft snelheidsprofiel als input. Hoe oplossen? F=m(dv/dt)?
* Trade-off tussen robuustheid en snelheid


#### 4. Servo in start wand
* Zie papier Pieter: verschillende opties

#### 3. Energie afwegingen

Energieberekening 'standaard' traject:

$E = \int ^T _0 P dt = \int ^T _0 F \dot{x} dt$

Of via sensors op de robot:

$ P = \sqrt{3 V_{rms} I_{rms}}$

Bedenkingen: grootste energieverbruik is in het liften van de last. De horizontale verplaatsing heeft niet zo'n groot verbruik, aangezien de zwaartekracht bijna loodrecht op de verplaatsing staat. Dus ons design bespaart eig helemaal niet zo veel energie op deze manier. Ofwel moeten we dan focussen op tijdsefficiëntie, ofwel moeten we toch meer een ballistic swing gebruiken om aan de last hoger te krijgen zonder het zelf te liften.
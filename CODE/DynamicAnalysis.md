# DYNAMISCHE ANALYSE
## 1.Opstelling
VOEG HIER TEKENING TOE VAN OPSTELLING!!
+ beschrijven vd verschillende variabelen (m,M,L,...)
+ zeg kabel lengte constant id analyse anders enkel numeriek oplosbaar

## 2. Langrangiaan opstellen
De Langrangiaan L van het systeem wordt gegeven door L = T - V, waarbij T = de kinetische energie en V = de potentiële energie van het systeem. 

De kinetische energie van het systeem wordt bepaald door de beweging van de slede en de massa onderaan de kabel. De beweging van de massa wordt in functie gezet van de beweging van de slede. De kinetische energie wordt vervolgens:

$T = \frac{1}{2}m (\dot x)^2 + \frac{1}{2}M((\dot x)^2 + l^2 (\dot \theta)^2 + 2 \dot x \dot \theta l cos(\theta))$

De enige potentiële in het systeem zit in de massa onderaan de slinger en wordt gegeven door:

$V = -Mglcos(\theta)$

Hieruit volgt direct de Langrangiaan:
$L = \frac{1}{2}m (\dot x)^2 + \frac{1}{2}M((\dot x)^2 + l^2 (\dot \theta)^2 + 2 \dot x \dot \theta l cos(\theta)) + Mglcos(\theta)$

## 3. Bewegingsvergelijkingen
De bewegingsvergelijkingen kunnen gevonden worden aan de hand van volgende formule:

$\frac{d}{dt}(\frac{\partial L}{\partial \dot q_i}) - \frac{\partial L}{\partial q_i} = Q_i$

met $q_i$ = x of $\theta$ en $Q_i$ de uitwendige kracht. Voor $q_i=x$ wordt dit:

$(M+m)\ddot x + (Mlcos(\theta))\ddot \theta - Ml(\dot \theta)^2 sin(\theta) = F$

Voor $q_i = \theta$ wordt dit:

$Ml(cos(\theta)\ddot x + l\ddot \theta + g sin(\theta)) = 0$

Deze vergelijkingen kunnen vervolgens omgezet worden naar de state space equation:

$\ddot x  = \frac{F + Ml(\dot \theta)^2 sin(\theta) + Mg sin(\theta)cos(\theta)}{M+m-M(cos(\theta))^2}$

$\ddot \theta = \frac{-((F + Ml(\dot \theta)^2 sin(\theta))cos(\theta) + (m+M)g sin(\theta))}{l(M+m-M(cos(\theta))^2)}$

Dit systeem van tweede-orde differentiaal vergelijkingen kan omgezet worden naar een stelsel van eerste-orde differentiaal vergelijkingen door de volgende nieuwe variabelen in te voeren:
$x_1 = x, x_2 = \theta, x_3 = \dot x$ en $x_4 = \dot \theta$. De nieuwe vergelijkingen zijn dan: 

$\dot x_1 = x_3$

$\dot x_2 = x_4$

$\dot x_3  = \frac{F + Ml(x_4)^2 sin(x_2) + Mg sin(x_2)cos(x_2)}{M+m-M(cos(x_2))^2}$

$\dot x_4 = \frac{-((F + Ml(x_4)^2 sin(x_2))cos(x_2) + (m+M)g sin(x_2))}{l(M+m-M(cos(x_2))^2)}$

## 4. Vergelijkingen oplossen
Deze vergelijkingen kunnen opgelost worden naar $x(t)$ en $\theta(t)$ als de kracht op het systeem gekend is met behulp van Matlab. Deze vergelijkingen kunnen door ons gebruikt worden op de momenten wanneer de kabel een constante lengte heeft in ons ontwerp, met name tijdens de eerste stap van de initialisatie en tijdens de swing beweging wanneer de slede stilstaat op een vaste positie.
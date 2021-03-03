# cosim
work in progress simulation of COVID-19 spread of Troy High School's in-person education model. Not entirely statistically sound or scientifically based, just an exercise in simulation and data collection.

CONTROLLABLE VARIABLES
N: population size (total number of students at school)
C: classes attended each day
Cl: number of classrooms
T:  total days attended (simulation length)
"Hybrid teaching" options:
Nk: student body physically present on any given day
OR
Ck: classes physically attended per student per day
STATISTIC VARIABLES
I: projected number of students infected over timespan
R0: Basic Reproduction Number (new infections per infected student) @ end of simulation
 
dots will attend c classes each day
between classes, dots will walk through one of three passageways (CRUDE, i know) to get to their next class
3% infection rate when in close contact (conservative, assumes caution and recognition -> isolation)
every dot in the same class as an infected will have a 3% chance of being infected themselves every class
infected dot has 2n16 chance to self-quarantine (stop attending classes) after nth day
3% infection rate when using same passageway as infected dot between classes
simulations will start with max(N/300, 2) infected dots attending classes.
after each day, students have a 0.5% chance of getting infected themselves (from outside)


works cited??:
https://www.the-hospitalist.org/hospitalist/article/218769/coronavirus-updates/covid-19-update-transmission-5-or-less-among-close

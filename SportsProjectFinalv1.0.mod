# North (Division 1) is teams 1 2 3 4 5 6
# South (Division 2) is teams 7 8 9 10 11 12


param I := 12;  # Number of teams
param J := 12;  # Index for number of teams
param K := 9;   # Number of weeks
param d{i in 1..I, j in 1..J} >= 0;


#Variables
var x {i in 1..I, j in 1..J, k in 1..K} binary; #equal to 1 if team i hosts team j in week k
var y {i in 1..I, k in 1..K-1} binary; #equal to 1 if team i plays BTB away in weeks k and k + 1


#Objective function Minimize travel cost for teams
minimize Travel: sum {i in 1..I, j in 1..J, k in 1..K} d[i,j] * x[i,j,k] + sum {i in 1..I, k in 1..8} y[i,k];


#Constraints

#A team can only play once a week
subject to OnceAWeek {i in 1..I, k in 1..K}: sum{j in 1..J} (x[i,j,k] + x[j,i,k]) <= 1;


#Division 1 play every Division 1 team once
subject to EveryDiv1 {i in 1..6, j in 1..6: i!=j}: sum{k in 1..K} (x[i,j,k] + x[j,i,k]) = 1;


#Division 2 play every Division 2 team once
subject to EveryDiv2 {i in 7..J, j in 7..J: i!=j}: sum{k in 1..K} (x[i,j,k] + x[j,i,k]) = 1;


#Division 1 play 3 teams in Division 2
subject to Div1Play3Div2 {i in 1..6}: sum{j in 7..J, k in 1..K} (x[i,j,k] + x[j,i,k]) = 3;


#Division 2 play 3 teams in Division 1
subject to Div2Play3Div1 {i in 7..J}: sum{j in 1..6, k in 1..K} (x[i,j,k] + x[j,i,k]) = 3;


#2 or 3 home division games (Division 1)
subject to 2HomeGamesDiv1 {i in 1..6}: sum{j in 1..6, k in 1..K} x[i,j,k] >= 2;
subject to 3HomeGamesDiv1 {i in 1..6}: sum{j in 1..6, k in 1..K} x[i,j,k] <= 3;


#2 or 3 home division games (Division 2)
subject to 2HomeGamesDiv2 {i in 7..J}: sum{j in 7..J, k in 1..K} x[i,j,k] >= 2;
subject to 3HomeGamesDiv2 {i in 7..J}: sum{j in 7..J, k in 1..K} x[i,j,k] <= 3;


#4 home games
subject to HomeGames {i in 1..I}: sum{k in 1..K, j in 1..J: i!=j} x[i,j,k] = 4;


#Play another team only once
subject to UniqueTeams {i in 1..I, j in 1..J}: sum{k in 1..K} (x[i, j, k] + x[j, i, k]) <= 1;


#can't have more than 1 BTB away games
subject to BackToBackAway {i in 1..I}: sum{k in 1..K-1} y[i, k] <= 1;
subject to OneBTBAway {i in 1..I, k in 1..8}: sum{j in 1..J} (x[i,j,k] + x[i,j,k+1]) + y[i,k] >= 1;


#can't start with BTB away
subject to StartBTBAway {i in 1..I}: sum{j in 1..J} (x[i,j,1] + x[i,j,2]) >= 1;


#can't end with BTB away
subject to EndBTBAway {i in 1..I}: sum{j in 1..J} (x[i,j,8] + x[i,j,9]) >= 1;


#Have Tahiti-Fiji, Sweden-Denmark, Chile-Argentina, and Antarctica-Australia different weeks
subject to NotSameWeek {k in 1..K}: x[11, 12, k] + x[12, 11, k] + x[3, 5, k] + x[5, 3, k] + x[9, 10, k] + x[10, 9, k] + x[7, 8, k] + x[8, 7, k] <= 1;


# Make the schedule balanced
subject to MaxBalanceTravel {i in 1..I}: sum{j in 1..J, k in 1..K} d[i,j] * x[i,j,k] <= 3300;
subject to MinBalanceTravel {i in 1..I}: sum{j in 1..J, k in 1..K} d[i,j] * x[i,j,k] >= 2500;


#Can only be 4 teams on a bye week. Entire matrix must solve to 4 or above
subject to ByeWeek {i in 1..I}: sum{k in 1..K, j in 1..J} x[i,j,k] = 4;
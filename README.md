# UTK MSBA Project

## Teammates include: 
Whitson Buck, Tyler Dykes, DJ Fugate, Aaron Harper, Hannah Johnson, and Olivia Popp

## Project Description:
Project created for studnets to make a AMPL script to optimize a sports schedule. 
  - 12 Teams
  - 9 Weeks
  - 2 Divisions
  - Hard Constraints:
    + Each team plays everyone in their division
    + 8 Total games per team
    + 4 games hosted, 4 games traveling, and 1 by week.
    + 2 OR 3 home division games
    + Teams do not have more than 1 back to back travel weeks
    + Teams must not start or end the season with back to back travel games.
  - Soft Constraints
    + Balanced Schedule
    + Travel Friendly
    + Splitting up "Big TV Games"

## Outcome: 
Created a dynamic AMPL script that optimized teams based upon above constraints.


## Files Descriptions:
- ScheduleCheck.run
  + Runs the optimization file, and produces a file easier for reading
- Distance.txt
  + Distance Matrix between Teams
- SportsProjectFinalv1.0.mod
  + Optimization File

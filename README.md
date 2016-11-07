# poker-simulator
simulates starting hands and flop, turn, river for tournies and cash games in omaha and hold'em poker

From my experience, virtually every high level poker player reaches that level through deep self-analysis of hands played and situations encountered.  Writing about spots and working through opponent hand ranges and lines is key to growth as a player. Most training software have woefully incompetent AIs that do no simulate real world behavior and usually overcomplicate matters.  I wanted to create a workbook of sorts where I could simply simulate dealt hands, position, and board textures which would be helpful in analyzing preflop opening ranges, c-betting boards, double barrels, etc.  This is useful for both personal growth as a player as well as coaching/discussion scenarios to see how people think about hands.  
  
To start, pick a seat (row #) and the column indicates what position you are in for that hand. Work through how the opponents before you would act and how you would likely play your dealt hand.  Visualizing this and examing the various decision points will translate to clearer and more optimal real world play. The optional tourney parameter will also assign a random amount of big blinds, which will alter decisions.  
-------------  
  
The function's default parameters - poker_simulator() - will return a 9 handed hold'em cash game of 36 hands/4 orbits.  Changing the parameters can yield an omaha deal, 2 to 10 handed play, tourney big blinds, and more simulations/orbits. { for example, poker_simulator(game="omaha", handed  = 2, tourney = TRUE, simulations = 60)  } There are example outputs in the repo. 

  
------------  

Hoping to add some color and hand values (pair, straight, etc) to next version. 

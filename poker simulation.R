poker_simulator <- function(game = "holdem", handed = 9,  simulations = 36, tourney = FALSE, blind_min_max = c(8,60)){
  suit <- c("c" ,"h" ,"d", "s")
  rank <- c(2:9, "T", "J", "Q", "K", "A")
  deck <- NULL 
  n<-1
  for(r in rank){
    deck <- c(deck, paste(r, suit, sep=""))
  }
  
  shuffle <- function(deck) {
    return(sample(deck,length(deck)))
  }
  #need 4 rows for flop turn river board, and then number of handed; init dataframe
  holder <- rep("", handed+4)
  session <- data.frame(holder,holder,stringsAsFactors = F)
  
  #creating the deal for holdem
  for (i in 1:simulations){
    deck1 <- shuffle(deck)
    #create 10 possible hands
    if (game == "holdem") {
      hand1 <- paste(deck1[1],deck1[1+handed])
      hand2 <- paste(deck1[2],deck1[2+handed])
      hand3 <- paste(deck1[3],deck1[3+handed])
      hand4 <- paste(deck1[4],deck1[4+handed])
      hand5 <- paste(deck1[5],deck1[5+handed])
      hand6 <- paste(deck1[6],deck1[6+handed])
      hand7 <- paste(deck1[7],deck1[7+handed])
      hand8 <- paste(deck1[8],deck1[8+handed])
      hand9 <- paste(deck1[9],deck1[9+handed])
      hand10 <- paste(deck1[10],deck1[10+handed])
      #first card of flop = how many handed*2 + 1 burn + it is the next card
      flop <- paste(deck1[(handed*2)+2],deck1[(handed*2)+3],deck1[(handed*2)+4])
      turn <- deck1[(handed*2)+6]
      river<- deck1[(handed*2)+8]
    }
    else if(game == "omaha" ){
      hand1 <- paste(deck1[1],deck1[1+handed],deck1[1+handed*2],deck1[1+handed*3])
      hand2 <- paste(deck1[2],deck1[2+handed],deck1[2+handed*2],deck1[2+handed*3])
      hand3 <- paste(deck1[3],deck1[3+handed],deck1[3+handed*2],deck1[3+handed*3])
      hand4 <- paste(deck1[4],deck1[4+handed],deck1[4+handed*2],deck1[4+handed*3])
      hand5 <- paste(deck1[5],deck1[5+handed],deck1[5+handed*2],deck1[5+handed*3])
      hand6 <- paste(deck1[6],deck1[6+handed],deck1[6+handed*2],deck1[6+handed*3])
      hand7 <- paste(deck1[7],deck1[7+handed],deck1[7+handed*2],deck1[7+handed*3])
      hand8 <- paste(deck1[8],deck1[8+handed],deck1[8+handed*2],deck1[8+handed*3])
      hand9 <- paste(deck1[9],deck1[9+handed],deck1[9+handed*2],deck1[9+handed*3])
      hand10 <- paste(deck1[10],deck1[10+handed],deck1[10+handed*2],deck1[10+handed*3])
      #first card of flop = how many handed*4 + 1 burn + it is the next card
      flop <- paste(deck1[(handed*4)+2],deck1[(handed*4)+3],deck1[(handed*4)+4])
      turn <- deck1[(handed*4)+6]
      river<- deck1[(handed*4)+8]
    }
    
    board <- paste(flop,turn,river)
    allhands <- c(hand1,hand2,hand3,hand4,hand5,hand6,hand7,hand8,hand9,hand10)
    allboard <- c(flop, turn, river, board)
    #use only the hands we need
    usedhands <- ""
    for (n in 1:handed) {
      usedhands[n] <- allhands[n]
    }
    hands_board <- c(usedhands, allboard)
    session[i] <- hands_board
  }#end of loop to create all hands
  
  if(tourney) {
    #initializing random bb amount based on parameter
    bb <- sample(blind_min_max[1]:blind_min_max[2], nrow(session)-4) #number of rows minus flop,turn,river,board = no. of hands
    for (i in 1:length(bb)){bb[i] <- paste(bb[i], "BB", sep="")}
    #appending bb amount to end of hand, row by row
    for(i in 1:length(bb)){session[i,] <- apply(session[i,], 1, paste, bb[i])}
  }
  #also need row names "Seat 1, Seat 2, Flop, Turn, etc."
  boardrows <- c("Flop", "Turn", "River", "Board")
  seatrows <- ""
  for(i in 1:handed){seatrows[i] <- paste("Seat", i)}
  allrows <- c(seatrows, boardrows)
  row.names(session) <- allrows
  
  #creating positions for use as column titles
  position_names <- c("bb","sb","bu","co","hj", paste("utg",handed-6,sep=""),paste("utg",handed-7,sep=""),paste("utg",handed-8,sep=""),paste("utg",handed-9,sep=""),paste("utg",handed-10,sep=""))
  #discarding positions we don't need
  used_positions <- ""
  for (z in 1:handed){
    used_positions[z] <- position_names[z]
  }
  colnames(session) <- rep(used_positions,ceiling(simulations/handed))[1:simulations]
  filename <- paste(handed,"handed",game,if(tourney){"tourney"}else{"cash game"},floor(simulations/handed),"orbits.csv")
  write.csv(session, filename)
  return(session)
}
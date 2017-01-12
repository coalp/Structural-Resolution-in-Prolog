

happy(vincent).

listens2Music(butch).
listens2Music(mill).

playsAirGuitar(vincent) :- listens2Music(vincent), happy(vincent).
playsAirGuitar(butch) :- happy(butch).
playsAirGuitar(butch) :- listens2Music(butch).


playCard(mill) :- happy(mill) ; listens2Music(mill).

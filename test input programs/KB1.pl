
% woman(Person).
% Person is a woman.
woman(mia).
woman(jody).
woman(yolanda).

% playsAirGuitar(Person).
% Person plays air guitar.
playsAirGuitar(jody).

party.

% loves(Subject,Object).
% Subject loves Object.
loves(vincent,mia).
loves(marsellus,mia).
loves(pumpkin,honey_bunny).
loves(honey_bunny,pumpkin).

% jealous(Object1, Object2).
% Object1 is jealous with Object2.
jealous(X,Y):-loves(X,Z),loves(Y,Z).

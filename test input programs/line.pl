
% point(XCoordinate, YCoordinate).
% XCoordinate and YCoordinate defines a point on Cartesian plane.

% line(PointA, PointB).
% PointA and PointB defines a line.

% vertical(Line).
% Line is vertical.
vertical(line(point(X,_),point(X,_))).

% horizontal(Line).
% Line is horizontal.
horizontal(line(point(_,Y),point(_,Y))).

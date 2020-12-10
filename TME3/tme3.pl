concatene([],L2,L2).
concatene([X|R],L2,[X|LRes]):-concatene(R,L2,LRes).

inverse([],[]).
inverse([X|L],Lres):-concatene(inverse(L),[X],Lres).
/*inverse([X|L],Lres):-inverse(L,LInv),concatene(LInv,[X],Lres).*/
/*
supprime([X|L], X, L).
supprime([Y|L], X)
supprime([X|L], Y, Res) :- supprime(L, Y, )
*/
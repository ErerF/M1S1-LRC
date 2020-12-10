% Intervalles de Allen
% Programmation Jean-Gabriel Ganascia
% Novembre 2018
%

transposer(<, >).
transposer(=, =).
transposer(e, et).
transposer(m, mt).
transposer(d,dt).
transposer(s, st).
transposer(o, ot).
transposer(X, S) :- \+ member(X, [<, =, e, m, d, s, o]), transposer(S, X).

transposition([], []).
transposition([X|L], [Xt|Lt]) :- transposer(X, Xt), transposition(L, Lt).

symetriser(<,>).
symetriser(s, e).
symetriser(o, ot).
symetriser(m, mt).
symetriser(d, d).
symetriser(=, =).
symetriser(e, s).
symetriser(ot, o).
symetriser(mt, m).
symetriser(dt, dt).
symetriser(et, st).
symetriser(st, et).

symetrisation([], []).
symetrisation([X|L], [Xt|Lt]) :- symetriser(X, Xt), symetrisation(L, Lt).


compositionBase(<, O, [<]):- member(O, [<, m, o, et, s, dt, st]).
compositionBase(<, O, [<, m, o, s, d]):- member(O, [d, e, ot, mt]).
compositionBase(<, >, [<, m, o, s, d, e, =, mt, ot, st, dt, et, >]).

compositionBase(m, O, [<]) :- member(O, [m, o, et, dt]).
compositionBase(m, O, [m]) :- member(O, [s, st]).
compositionBase(m, O, [o, s, d]) :- member(O, [d, e, ot]).
compositionBase(m, mt, [e, et, =]).

compositionBase(o, O, [<, m, o]) :- member(O, [o, et]).
compositionBase(o, s, [o]).
compositionBase(o, O, [o, s, d]) :- member(O, [d, e]).
compositionBase(o, dt, [<, m, o, et, dt]).
compositionBase(o, st, [o, et, dt]).
compositionBase(o, ot, [o, ot, e, et, d, dt, st, s, =]).

compositionBase(s, et, [<, m, o]).
compositionBase(s, s, [s]).
compositionBase(s, O, [d]) :- member(O, [d, e]).
compositionBase(s, dt, [<, m, o, et, dt]).
compositionBase(s, st, [s, st, =]).

compositionBase(et, s, [o]).
compositionBase(et, d, [o, s, d]).
compositionBase(et, dt, [dt]).
compositionBase(et, e, [e, et, =]).

compositionBase(d, d, [d]).
compositionBase(d, dt, [<, m, o, s, d, e, =, mt, ot, st, dt, et, >]).
compositionBase(dt, d, [o, s, d, e, =, ot, st, dt, et]).

composition(A, B, L) :- compositionBase(A, B, L),!.
composition(A, B, L) :- transposer(A, At), transposer(B, Bt),
	compositionBase(Bt, At, Lt), transposition(Lt, L),!.
composition(A, B, L) :- symetriser(A, As), symetriser(B, Bs),
	compositionBase(As, Bs, Ls), symetrisation(Ls, L), !.
composition(A, B, L) :- symetriser(A, As), transposer(As, Ast),
	symetriser(B, Bs), transposer(Bs, Bst),
	compositionBase(Bst, Ast, Lts),
	transposition(Lts, Ls),
	symetrisation(Ls, L),!.

contrainte([], _, []):-!.
contrainte([X|L], Q, R) :- contrainte_aux(X, Q, Raux),
    contrainte(L, Q, RR),
    union(Raux, RR, R).

contrainte_aux(_, [], []):-!.
contrainte_aux(X, [T|Q], L) :- composition(X, T, C),
    contrainte_aux(X, Q, R),
    union(C, R, L).






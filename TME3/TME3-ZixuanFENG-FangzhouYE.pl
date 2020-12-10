/*Exo 2*/
concatene([],L2,L2).
concatene([X|R],L2,[X|LRes]):-concatene(R,L2,LRes).
/* La concaténation de [X|R] et de L2 est commencé par X et suivi de la concaténation de R et L2. */
/*
[debug]  ?- concatene(L1,L2,[a,b,c]).
L1 = [],
L2 = [a, b, c] ;
L1 = [a],
L2 = [b, c] ;
L1 = [a, b],
L2 = [c] ;
L1 = [a, b, c],
L2 = [] ;
false.
[debug]  ?- concatene([a,b,c],[d],L2).
L2 = [a, b, c, d].
*/

inverse([],[]).
inverse([X|L],Res):-inverse(L,LInv),concatene(LInv,[X],Res).
/* L'inverse de [X|L] est l'inverse de L suivi de X. */
/*
[debug]  ?- inverse([a,b,c,d],L2).
L2 = [d, c, b, a].
*/

supprime([],Y,[]).
supprime([Y|B],Y,Res):-supprime(B,Y,Res).
supprime([A|B],Y,[A|R1]):-A\=Y,supprime(B,Y,R1).
/* Pour supprimer(X,Y,Z),
        quand X est vide, on retourne vide;
        quand X est une liste commencé par Y, on le supprime et on répèce cette opération récursivement avec le reste;
        quand X=[X1|X2] dont X1!=Y, on retourne une liste commencé  par X1 et suivi du résultat de supprimer(X2,Y,Res). */
/*
[debug]  ?- supprime([a,b,a,c],a,[b,a,c]).
false.
[debug]  ?- supprime([a,b,a,c],a,[b,c]).
true .
[debug]  ?- supprime([a,b,a,c],a,L).
L = [b, c] .
*/

filtre([],Y,[]).
filtre(X,[],X).
filtre(X,[A|B],Z):-supprime(X,A,T),filtre(T,B,Z).
/*La filtrage de liste X de [A|B] une liste d'éléments s'agit de supprimer le premier
élément de la liste puis on fait une filtrage de liste qui suis la (B). Par l'hypothèse de 
récurrence. ça marchera 
*/
/*
[debug]  ?- filtre([1,2,3,4,2,3,4,2,4,1],[2,4],L).
L = [1, 3, 3, 1] .
[debug]  ?- filtre([1,2,3,4],[5],L).
L = [1, 2, 3, 4] .
[debug]  ?- filtre([1,2,3,4],[],L).
L = [1, 2, 3, 4] .
*/

/*Exo 3*/
/*Q1*/
palindrome(X):-inverse(X,X).
/*
La teste de palindrome s'agist de tester si l'inverse d'une séquence de lettres est bien lui même
( par la définition )
*/
/*
[debug]  ?- palindrome([l,a,v,a,l]).
true.
[debug]  ?- palindrome([l,a,v,a,i]).
false.
[debug]  ?- palindrome([]).
true.
*/

/*Q2*/
/*1er facon:*/
inter(A,B,[A|[]]):-palindrome2(B).
inter(A,B,[C1|C2]):- C2\=[],concatene(B,[C1],D),inter(A,D,C2).
palindrome2([]).
palindrome2([A|[]]).
palindrome2([A|B]):-inter(A,[],B).
/*
L'idée de cette solution est de tester si le premier élément est égale au dernier élément, si oui, on continue avec les éléments au milieu.

inter(A,B,C):
    A: l'élément à tester, c.à.d le premier élément de la liste (on peut dire 'originale')
    B: les éléments qu'on a déjà vu sauf le premier, c.à.d les éléments au milieu déjà parcouru
    C: les éléments à parcourir dans la liste originale

    Dans chaque tour, on regarde s'il reste un seul élément dans C=[C1|C2] (c.à.d C2=[]):
        -- Si oui, on teste si A==C1
            * si oui, continuer avec palindrome2(B)
            * sinon, retourne false
        -- sinon, on ajoute C1 dans la liste B et le supprime dans C, et continue avec inter.

palindrome2:
    cas base:
        Quand la liste est vide --> true
        Quand il y a un seul élément dans la liste -->true
    Dans le reste des cas, on appele inter

exemple:
        palindrome2([l,a,v,a,l])
            A         B         C
            l       []      [a,v,a,l]
            l       [a]      [v,a,l]
            l       [a,v]      [a,l]
            l       [a,v,a]      [l]    --> true, continuer avec palindrome2([a,v,a])
*/
/*
[debug]  ?- palindrome2([]).
true.
[debug]  ?- palindrome2([a]).
true .
[debug]  ?- palindrome2([l,a,v,a,l]).
true .
[debug]  ?- palindrome2([l,a,v,i,l]).
false.
[debug]  ?- palindrome2([l,a,v,v,a,l]).
true .
*/

/*2eme facon:*/
/*la teste de palindrome s'agit de tester l'égalité de première lettre et dernière lettre ET la teste de palindrome de séquence entre deux extremité*/
palindrome3([]).
palindrome3([A]).
palindrome3(X) :- concatene([A|B], [A], X), palindrome3(B).

/*
[debug]  ?- palindrome3([]).
true.
[debug]  ?- palindrome3([a]).
true .
[debug]  ?- palindrome3([l,a,v,a,l]).
true .
[debug]  ?- palindrome3([l,a,v,i,l]).
false.
[debug]  ?- palindrome3([l,a,v,v,a,l]).
true .
*/
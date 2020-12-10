/*
Zixuan FENG
Fangzhou YE
*/

/*ex1*/
/*r(a, b).
r(f(X), Y) :- p(X, Y).
p(f(X), Y) :- r(X,Y).*/


/*
[trace]  ?- r(f(f(a)),b).
   Call: (7) r(f(f(a)), b) ? creep      //C2 avec X=f(a),Y=b
    Call: (8) p(f(a), b) ? creep        //C3 avec X=a, Y=b
   Call: (9) r(a, b) ? creep            //C1
   Exit: (9) r(a, b) ? creep
   Exit: (8) p(f(a), b) ? creep
   Exit: (7) r(f(f(a)), b) ? creep
true.                                   //On a bien la clause vide.

[trace] [1]  ?- p(f(a),b).
   Call: (14) p(f(a), b) ? creep        //C3 avec X=a, Y=b
   Call: (15) r(a, b) ? creep           //C1
   Exit: (15) r(a, b) ? creep
   Exit: (14) p(f(a), b) ? creep
true.                                   //On a bien la clause vide.
*/


/*ex2*/
/*r(a,b).
q(X,X).
q(X,Z):-r(X,Y),q(Y,Z).*/

/*
[trace] [1]  ?- q(X,b).
   Call: (14) q(_G11312, b) ? creep     //C2 avec X=b 
   Exit: (14) q(b, b) ? creep          
X = b .                                 //Solution trouvé

[trace] [1]  ?- q(b,X).
   Call: (14) q(b, _G11313) ? creep     //C2 avec X'=b
   Exit: (14) q(b, b) ? creep           
X = b ;                                 //Solution trouvé
   Redo: (14) q(b, _G11313) ? creep     //Demande s'il y a une autre solution?
   Call: (15) r(b, _G11389) ? creep     //C3 avec X'=b, Z'=X => r(b,Y'),q(Y',X)
   Fail: (15) r(b, _G11389) ? creep     //fail avec r(b,Y')
   Fail: (14) q(b, _G11313) ? creep
false.                                  //Il n'y a pas d'autre solution possible.
                                
*/

/*Ex3*/
/*reivse(X):-serieux(X).
devoir(X):-consciencieux(X).
reussir(X):-reivse(X).
serieux(X):-devoir(X).
consciencieux(pascal).
consciencieux(zoe).*/

/*
[trace] [1]  ?- reussir(X).
   Call: (14) reussir(_G11312) ? creep
   Call: (15) reivse(_G11312) ? creep
   Call: (16) serieux(_G11312) ? creep
   Call: (17) devoir(_G11312) ? creep
   Call: (18) consciencieux(_G11312) ? creep
   Exit: (18) consciencieux(pascal) ? creep
   Exit: (17) devoir(pascal) ? creep
   Exit: (16) serieux(pascal) ? creep
   Exit: (15) reivse(pascal) ? creep
   Exit: (14) reussir(pascal) ? creep
X = pascal ;
   Redo: (18) consciencieux(_G11312) ? creep
   Exit: (18) consciencieux(zoe) ? creep
   Exit: (17) devoir(zoe) ? creep
   Exit: (16) serieux(zoe) ? creep
   Exit: (15) reivse(zoe) ? creep
   Exit: (14) reussir(zoe) ? creep
X = zoe.
*/

/*Ex4*/
/*Q1.2.3.*/
/*parent(X,Y):-pere(X,Y).
parent(X,Y):-mere(X,Y).*/
/*Q4*/
/*parent(X,Y,Z):-pere(X,Z),mere(Y,Z).*/
/*Q5*/
/*grandpere(X,Z):-pere(X,Y),pere(Y,Z).
grandpere(X,Z):-pere(X,Y),mere(Y,Z).
frereousoeur(X,Y):-pere(Z,X),pere(Z,Y),mere(A,X),mere(A,Y),X\=Y.*/
/*Q6*/
/*ancetre(X,Y):-parent(X,Y).
ancetre(X,Y):-parent(X,Z),ancetre(Z,Y).*/
/*ancetre1(X,Y):parent(X,Z),*/
/*pere(huang,pepin).
pere(qijia,berthe).
pere(pepin,charlemagne).
pere(pepin,frere).
pere(pepin,nonfrere).
pere(ggpere,huang).
pere(gggpere,ggpere).
mere(autremere,nonfrere).
mere(berthe,frere).
mere(berthe, charlemagne).*/


/*
2.
[debug] [1]  ?- parent(pepin,charlemagne).
true .
[debug] [1]  ?- parent(berthe,charlemagne).
true.

3.
[debug] [1]  ?- parent(charlemagne,X).
false.
[debug] [1]  ?- parent(pepin,X).
X = charlemagne .
[debug] [1]  ?- parent(A,B).
A = pepin,
B = charlemagne ;
A = berthe,
B = charlemagne.

4.
[debug] [1]  ?- parent(X,Y,charlemagne).
X = pepin,
Y = berthe.
[debug] [1]  ?- parent(X,Y,Z).
X = pepin,
Y = berthe,
Z = charlemagne.
[debug] [1]  ?- parent(pepin,Y,Z).
Y = berthe,
Z = charlemagne.
[debug] [1]  ?- parent(berthe,Y,Z).
false.

5.
[debug] [1]  ?- grandpere(X,charle[debug] [1]  ?- ancetre(X,charlemagne).
X = pepin ;
X = berthe ;
X = huang ;
X = qijia ;
X = ggpere ;
X = gggpere ;
false.


X = huang ;
X = qijia ;
false.
[debug] [1]  ?- grandpere(X,Y).
X = huang,
Y = charlemagne .
[debug] [1]  ?- grandpere(X,pepin)[debug] [1]  ?- ancetre(X,charlemagne).
X = pepin ;
X = berthe ;
X = huang ;
X = qijia ;
X = ggpere ;
X = gggpere ;
false.


false.

[debug] [1]  ?- frereousoeur(X,Y).[debug] [1]  ?- ancetre(X,charlemagne).
X = pepin ;
X = berthe ;
X = huang ;
X = qijia ;
X = ggpere ;
X = gggpere ;
false.


X = charlemagne,
Y = frere ;
X = frere,
Y = charlemagne ;
false.
[debug] [1]  ?- frereousoeur(X,pepin).
false.
[debug] [1]  ?- frereousoeur(X,charlemagne).
X = frere ;
false.

6.
[debug] [1]  ?- ancetre(gggpere,charlemagne).
true 
[debug] [1]  ?- ancetre(X,charlemagne).
X = pepin ;
X = berthe ;
X = huang ;
X = qijia ;
X = ggpere ;
X = gggpere ;
false.
*/


/*Exo5*/
et(1,1,1).
et(1,0,0).
et(0,1,0).
et(0,0,0).
ou(1,1,1).
ou(1,0,1).
ou(0,1,1).
ou(0,0,0).
non(1,0).
non(0,1).
/*
Q1.
[debug]  ?- et(1,1,Z).
Z = 1 .
[debug]  ?- ou(1,1,0).
false.
[debug]  ?- ou(1,1,Z).
Z = 1 .
[debug]  ?- non(1,0).
true.
[debug]  ?- non(1,Z).
Z = 0.

Q2.
[debug]  ?- et(X,Y,1).
X = Y, Y = 1.
[debug]  ?- et(0,0,R).
R = 0.
[debug]  ?- et(X,Y,R).
X = Y, Y = R, R = 1 ;
X = 1,
Y = R, R = 0 ;
X = R, R = 0,
Y = 1 ;
X = Y, Y = R, R = 0.
*/

/*Q3*/
xor(0,0,0).
xor(0,1,1).
xor(1,0,1).
xor(1,1,0).
circuit(X,Y,E):-et(X,Y,Z),non(Z,W),non(X,T),xor(T,W,R),non(R,E).
/* La valeur Z obtenue par et(X,Y,Z) est utilisé dans non(Z,W) etc. */
/*
Q4.
?- circuit(X,Y,Z).
X = Y, Y = Z, Z = 1 ;
X = 1,
Y = Z, Z = 0 ;
X = 0,
Y = Z, Z = 1 ;
X = Y, Y = 0,
Z = 1.

   X  Y  circuit
   0  0  1
   0  1  1
   1  0  0
   1  1  1
*/
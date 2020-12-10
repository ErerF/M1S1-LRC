subs(chat, felin).
subs(lion, felin).
subs(chien, canide).
subs(canide, chien).
subs(souris, mamifere).
subs(felin, mamifere).
subs(canide, mamifere).
subs(mamifere, animal).
subs(canari, animal).
subs(animal, etreVivant).
subs(and(some(aMaitre), animal), pet).
subs(pet, some(aMaitre)).
subs(some(aMaitre), all(aMaitre, humain)).
subs(chihuahua, and(chien, pet)).
subs(lion, carnivore).
subs(carnivore, predateur).
/*tous les animal se nourrit*/
subs(animal, all(mange, etreVivant)).
subs(some(mange), all(mange, etreVivant)).
/*------------------------------------*/
subs(and(some(mange), all(mange, nothing)), nothing).
equiv(carnivore, all(mange, animal)).
equiv(herbivore, all(mange, plante)).
inst(Felix, chat).
inst(Pierre, humain).
inst(Princesse, chihuahua).
inst(Marie, humain).
inst(Jerry, souris).
inst(Titi, canari).
instR(Felix, aMaitre, Pierre).
instR(Princesse, aMaitre, Marie).
instR(Felix, mange, Jerry).
instR(Felix, mange, Titi).
/*----------------------------------------------*/
subsS1(C, C).
subsS1(C, D) :- subs(C, D), C\==D.
subsS1(C, D) :- subs(C, E), subsS1(E, D).
/*----------------------------------------------*/
/*Exercice 2*/
/*Q1 
- une conception est la subsomption de lui-même
- la subsomption est transitive. Si une coception C est 
subsompé par une conception D. Cela est équivalent que s'il
existe une conception intermédiaire E telle que C est subsompé
par E et E est subsompé par D.
*/

/*Q2
subsS1(canari, animal). => true car cette subsomption existe déjà
subsS1(chat, etreVivant). => true car par la transitivité, chat est
subsompé par felin, ce qui est subsompé par mamifere qui est
subsompé par animal.
*/ 

/*Q3
subsS1(chien, souris). le programme ne s'arrête pas, il a tombé
dans une boucle infinie. car il vérifie toujours la subsomption
de chien par canide et celle de canide par chien. Cela vient du
fait que le chien est équivalent à canide.
*/

/*----------------------------------------------*/
subsS(C, D) :- subsS(C, D, [C]).
subsS(C, C, _).
subsS(C, D, _) :- subs(C, D), C \== D.
subsS(C, D, L) :- subs(C, E), not(member(E, L)), subsS(E, D, [E|L]), E \== D.
/*----------------------------------------------*/

/*Q4
subsS(canari, animal). => true
subsS(chat, etreVivant). => true
subsS(chien, canide). => true
subsS(chien, chien). => true
*/

/*Q5
subsS(souris, some(mange)). => true
car par la transitivite, il va vérifier si animal subsompé par some(mange).
*/

/*Q6
subsS(chat, humain). => false
subsS(chien, souris). => false
*/

/*Q7
subsS(chat, X). renvoye toutes les classes que le chat peut y appartenir
subsS(X, mamifere). renvoye toutes les conceptes qui peut etre subsompées
par la classe mamifere
*/

/*----------------------------------------------------*/
subsS(C, D) :- subsS(C, D, [C]).
subsS(C, C, _).
subsS(C, D, _) :- equiv(C, D).
subsS(D, C, _) :- equiv(C, D).
subsS(C, D, _) :- subs(C, D), C \== D.
subsS(C, D, L) :- subs(C, E), not(member(E, L)), subsS(E, D, [E|L]), E \== D.
/*----------------------------------------------------*/

/*Q8
subsS2(C, D, _) :- equiv(C, D).
subsS2(D, C, _) :- equiv(C, D).
*/

/*Q9
subsS2(lion, all(mange, animal)). => true
par la transitivité, lion est subsompé par carnivore, ce qui est équivalent à
ceux qui mange d'animal
*/

/*Exercice 3*/
subsS(C,and(D1,D2),L) :- D1\=D2,subsS(C,D1,L),subsS(C,D2,L).
subsS(C,D,L) :- subs(and(D1,D2),D),E=and(D1,D2),not(member(E,L)),subsS(C,E,[E|L]),E\==C.
subsS(and(C,C),D,L) :- nonvar(C),subsS(C,D,[C|L]).
subsS(and(C1,C2),D,L) :- C1\=C2,subsS(C1,D,[C1|L]).
subsS(and(C1,C2),D,L) :- C1\=C2,subsS(C2,D,[C2|L]).
subsS(and(C1,C2),D,L) :- subs(C1,E1),E=and(E1,C2),not(member(E,L)),subsS(E,D,[E|L]),E\==D.
subsS(and(C1,C2),D,L) :- Cinv=and(C2,C1),not(member(Cinv,L)),subsS(Cinv,D,[Cinv|L]).

/*Exercice 4*/
subsS(all(R, C), all(R, D)) :- subsS(C, D).
subsS(all(R, C), D) :- equiv(D, X), subsS(all(R, C), X).
subsS(C, all(R, D)) :- equiv(C, Y), subsS(Y, all(R, D)).
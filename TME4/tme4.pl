subs(chat, felin).
subs(lion, felin).
subs(chien, canide).
subs(canide, chien).
/*equiv(canide, chien).*/
subs(souris, mamifere).
subs(felin, mamifere).
subs(canide, mamifere).
subs(mamifere, animal).
subs(canari, animal).
subs(animal, etreVivant).
subs(and(some(aMaitre), animal), pet).
all(aMaitre, pet).
subs(some(aMaitre), all(aMaitre, humain)).
subs(chihuahua, and(chien, pet)).
equiv(carnivore, all(mange, animal)).
equiv(herbivore, all(mange, plante)).
subs(lion, carnivore).
subs(carnivore, predateur).
subs(animal, all(mange, etreVivant)).
subs(and(some(mange), all(mange, nothing)), nothing).
inst(Felix, chat).
instR(Felix, aMaitre, Pierre).
inst(Pierre, humain).
inst(Princesse, chihuahua).
instR(Princesse, aMaitre, Marie).
inst(Marie, humain).
inst(Jerry, souris).
inst(Titi, canari).
instR(Felix, mange, Jerry).
instR(Felix, mange, Titi).
/*----------------------------------------------*/
subsS1(C, C).
subsS1(C, D) :- subs(C, D), C/==D.
subsS1(C, D) :- subs(C, E), subsS1(E, D).
/*----------------------------------------------*/
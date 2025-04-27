/* This program is based on the song "I'm My Own Grandpa".
*  Below are some statements summarizing what happened in the song.
*
* I married widow
* Widow had daughter (redhair)
* My father married redhair
* I had son (babyboy)
* redhair had son (onrun)
*
* Questions: 
* Is my father my son-in-law?
* Is my daughter my step-mother?
* Is my son my father's brother-in-law?
* Is my son my uncle?
* Is my son a brother to my daughter?
* Is my father's son my grandson?
* Is my wife my grandmother?
* Am I my wife's grandchild?
*
* Main Question: Am I my own Grandpa?
*
*-----------------------------------*/

% Facts

male(i).
male(father).
male(babyboy).
male(onrun).

female(widow).
female(redhair).

% NOTE: the husband is always on the left, the wife on the right
married(i, widow).
married(father, redhair).

parent(father, i).
parent(widow, redhair).
parent(i, babyboy).
parent(redhair, onrun).

% Rules

father(X, Y) :- male(X), parent(X, Y).
father(X, Y) :- male(X), married(X, Wife), parent(Wife, Y). %If married, and wife has son

mother(X, Y) :- female(X), parent(X, Y).
mother(X, Y) :- female(X), married(Husband, X), parent(Husband, Y). %If married, and husband has son

son(X, Y) :- male(X), parent(Y, X).
daughter(X, Y) :- female(X), parent(Y, X).

parent_in_law(X, Y) :- parent(X, Z), married(Z, Y).
parent_in_law(X, Y) :- parent(X, Z), married(Y, Z).

son_in_law(X,Y) :- married(X, Z), daughter(Z, Y).

uncle(X, Y) :- male(X), parent(Z, Y), brother(X, Z).
aunt(X, Y) :- female(X), parent(Z, Y), sister(X, Z).

sibling_in_law(X, Y) :- married(X, Z), sibling(Z, Y).
sibling_in_law(X, Y) :- sibling(X, Z), married(Z, Y).

step_parent(X, Y) :- married(X, Z), parent(Z, Y).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandchild(X, Y) :- grandparent(Y, X).

brother(X, Y) :- male(X), parent(Z, X), parent(Z, Y), X \= Y.

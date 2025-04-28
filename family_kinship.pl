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

parent_of(X,Y) :- father(X,Y) ; mother(X,Y). % to fix things?

sibling(X,Y) :- parent_of(Z, X), parent_of(Z, Y), X \= Y.

son(X, Y) :- male(X), parent_of(Y, X).
daughter(X, Y) :- female(X), parent_of(Y, X).

parent_in_law(X, Y) :- parent_of(X, Z), married(Z, Y).
parent_in_law(X, Y) :- parent_of(X, Z), married(Y, Z).

son_in_law(X,Y) :- married(X, Z), daughter(Z, Y).

uncle(X, Y) :- male(X), parent_of(Z, Y), brother(X, Z).
aunt(X, Y) :- female(X), parent_of(Z, Y), sister(X, Z).

sibling_in_law(X, Y) :- married(X, Z), sibling(Z, Y).
sibling_in_law(X, Y) :- sibling(X, Z), married(Z, Y).
sibling_in_law(X, Y) :- married(X, A), married(Y, B), sibling(A, B).

step_parent(X, Y) :- married(X, Z), parent_of(Z, Y).

grandparent(X, Y) :- parent_of(X, Z), parent_of(Z, Y).
grandchild(X, Y) :- grandparent(Y, X).

brother(X, Y) :- male(X), parent_of(Z, X), parent_of(Z, Y), X \= Y.


% For testing purposes
% Answer all the questions listed at the start

/* Questions: 
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
* NOTE: SHOULD ANSWER ALL YES
*/

runit :- parent_in_law(i, father), 	write(yes), nl,
	step_parent(i, redhair), 	write(yes), nl,
	sibling_in_law(babyboy, father),write(yes), nl, %Right now fails, everything else works
	uncle(babyboy, i), 		write(yes), nl,
	brother(babyboy, redhair), 	write(yes), nl,
	grandchild(onrun, i), 		write(yes), nl,
	grandparent(widow, i), 		write(yes), nl,
	grandchild(i, widow), 		write(yes), nl,
	grandparent(i,i), 		write(yes).

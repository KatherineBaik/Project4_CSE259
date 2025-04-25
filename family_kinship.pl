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


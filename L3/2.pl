mulher(maria).
bonito(maria).
homem(marcos).
bonito(marcos).
rico(marcos).
mulher(ana).
rico(ana).
forte(ana).
homem(fabiano).
forte(fabiano).
bonito(fabiano).
homem(silvio).
amavel(silvio).
forte(silvio).
gosta(X, Y) :- homem(X), mulher(Y), bonita(Y).
feliz(X) :- homem(X), rico(X).
feliz(X) :- mulher(Y), gosta(X, Y), gosta(Y, X).
feliz(X) :- homem(Y), gosta(X, Y), gosta(Y, X).
gosta(ana, X) :- homem(X), gosta(X, ana).
gosta(maria, X) :- homem(X), gosta(X, maria), (rico(X) ; amavel(X) ; bonito(X)), forte(X).

passaro(marcelo).
peixe(silvio).
minhoca(ana).
gosta(X, Y) :- passaro(X), minhoca(Y).
gosta(X, Y) :- gato(X), peixe(Y).
gosta(X, Y) :- amigos(X, Y), amigos(Y, X).
pessoa(eu).
gato(chuck_norris).
dono(chuck_norris, eu).
amigos(eu, chuck_norris).
come(chuck_norris, X) :- gosta(chuck_norris, X), not(pessoa(X)).

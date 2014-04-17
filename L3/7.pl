% A
adiciona(X, L1, L2) :- L2 = [X | L1].

% B
% implementação usando a biblioteca padrão
remover(X, L1, L2) :- delete(L1, X, L2).

% C
% implementação usando a biblioteca padrão
inverte(L1, L2) :- reverse(L1, L2).

% D
tamanho([], 0).
tamanho([Head | Tail], T) :- tamanho(Tail, N), T is N + 1. 


% E
% lista vazia
soma([], 0).
% a soma dos elementos de uma lista é a cabeça + a soma da cauda
soma([Head | Tail], Soma) :- soma(Tail, S), Soma is Head + S.


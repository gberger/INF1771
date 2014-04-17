# titulo, genero, diretor, ano, min.

dados_filme(amnesia, suspense, nolan, 2000, 113).
dados_filme(babel, drama, inarritu, 2006, 142).
dados_filme(capote, drama, miller, 2005, 98).
dados_filme(casablanca, romance, curtiz, 1942, 102).
dados_filme(matrix, ficcao, wachowsk, 1999, 136).
dados_filme(rebecca, suspense, hitchcock, 1940, 130).
dados_filme(shrek, aventura, adamson, 2001, 90).
dados_filme(sinais, ficcao, shymalan, 2002, 106).
dados_filme(spartacus, acao, kubrik, 1960, 184).
dados_filme(titanic, romance, cameron, 1997, 194).
dados_filme(volver, drama, almodovar, 2006, 121).


diretor(F, D) :- dados_filme(F, _, D, _, _).

filmes_do_genero(G, F) :- dados_filme(F, G, _, _, _).

filmes_do_diretor(D, F) :- dados_filme(F, _, D, _, _).

ano_do_filme(F, A) :- dados_filme(F, _, _, A, _).

filmes_com_duracao_inferior(D, F) :- dados_filme(F, _, _, _, M) , M < D.

filmes_lancados_entre(A, B, F) :- dados_filme(F, _, _, C, _), (C >= A), (B >= C).


classico(F) :- filmes_lancados_entre(0, 1980, F).

classicos_suspense(F) :- classico(F) , filmes_do_genero(suspense, F).


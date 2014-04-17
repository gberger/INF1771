aluno(joao, calculo).
aluno(maria, calculo).
aluno(joel, programacao).
aluno(joel, estrutura).
frequenta(joao, puc).
frequenta(maria, puc).
frequenta(joel, ufrj).
professor(carlos, calculo).
professor(ana_paula, estrutura).
professor(pedro, programacao).
funcionario(pedro, ufrj).
funcionario(ana_paula, puc).
funcionario(carlos, puc).

professor_alunos(X, Y) :- aluno(Y, Z), professor(X, Z), frequenta(Y, K), funcionario(X, K).

universidade_pessoas(X, Y) :- frequente(Y, X) ; funcionario(Y, X).

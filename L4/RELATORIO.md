# Problema 1

## STRIPS

Veja o arquivo `1/strips.txt`.

## PDDL

Alguns predicados tiveram que ser alterados ou complementados para se adequarem ao PDDL. 

O predicado `put-table` recebeu uma duas versões, de modo a evitar inconsistências de domínio:

* bloco x é retirado do bloco z e posto no bloco y

* bloco x é retirado da mesa e posto no bloco y

Veja os arquivo `1/domain.pddl` e `1/problem.pddl`.

### Busca Progressiva

  * Tempo: 61ms
  * Nós gerados: 23
  * Nós expandidos: 4
  * Plano final:

```
  (PUT-TABLE B A)
  (PUT-ON A D C)
  (PUT-ON B A)
  (PUT-ON C B)
```

### Busca Regressiva

  * Tempo: 61ms
  * Nós gerados: 12
  * Nós expandidos: 4
  * Plano final:

```
  (PUT-TABLE B A)
  (PUT-ON A D C)
  (PUT-ON B A)
  (PUT-ON C B)
```

### Conclusão

Ambas as buscas encontraram a mesma solução no mesmo tempo de execução e número de nós expandidos. Porém, a busca regressiva gerou menos nós. A melhor estratégia de busca, portanto, é a regressiva.

# Problema 2

## STRIPS

Veja o arquivo `2/strips.txt`.

Plano:

```
Ir(PosRoom3, Door3)
Ir(Door3, Door1)
Ir(Door1, PosRoom1)
Empurrar(Box1, PosRoom1, Door1)
Empurrar(Box1, Door1, Door2)
Empurrar(Box1, Door2, PosRoom2)
Subir(Box1)
LigarLuz(Switch2)
```

## PDDL

Alguns predicados tiveram que ser alterados ou complementados para se adequarem ao PDDL. 

Veja os arquivo `1/domain.pddl` e `1/problem.pddl`.

### Busca Progressiva

  * Tempo: 93ms
  * Nós gerados: 35
  * Nós expandidos: 9
  * Plano final:

```
  (IR POSROOM3 DOOR3 ROOM3)
  (IR DOOR3 DOOR1 CORRIDOR)
  (IR DOOR1 POSROOM1 ROOM1)
  (EMPURRAR BOX1 POSROOM1 DOOR1 ROOM1)
  (EMPURRAR BOX1 DOOR1 DOOR2 CORRIDOR)
  (EMPURRAR BOX1 DOOR2 POSROOM2 ROOM2)
  (SUBIR BOX1 POSROOM2)
  (LIGAR-LUZ SWITCH2 BOX1 POSROOM2)
```

### Busca Regressiva

  * Tempo: 108ms
  * Nós gerados: 250
  * Nós expandidos: 8
  * Plano final:

```
  (IR POSROOM3 DOOR3 ROOM3)
  (IR DOOR3 DOOR1 CORRIDOR)
  (IR DOOR1 POSROOM1 ROOM1)
  (EMPURRAR BOX1 POSROOM1 DOOR1 ROOM1)
  (EMPURRAR BOX1 DOOR1 DOOR2 CORRIDOR)
  (EMPURRAR BOX1 DOOR2 POSROOM2 ROOM2)
  (SUBIR BOX1 POSROOM2)
  (LIGAR-LUZ SWITCH2 BOX1 POSROOM2)
```

### Conclusão

Esse problema também não apresenta muita ambiguidade e caminhos diferentes a serem tomados pelo planejador. Um caminho diferente automaticamente resultaria em um plano muito menos eficiente (por exemplo, ir para uma sala diferente da 1 (em que estão as caixas) ou 2 (em que está o interruptor)). Por isso, os planos encontrados por ambas as buscas foram iguais.

Observa-se que a busca progressiva resultou em um número bem menor de nós gerados, apesar de ter expandido um a mais em relação à busca regressiva. A progressiva também apresentou melhor tempo de execução.

Portanto, a busca progressiva foi melhor neste caso.
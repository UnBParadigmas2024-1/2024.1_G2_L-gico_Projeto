% Um programa Prolog simples para determinar relações familiares.

% Fatos
pai(joao, maria).
pai(joao, jose).
mae(ana, maria).
mae(ana, jose).
masculino(joao).
masculino(jose).
feminino(maria).
feminino(ana).

% Regras
filho(X, Y) :- pai(Y, X), masculino(X).
filho(X, Y) :- mae(Y, X), masculino(X).
filha(X, Y) :- pai(Y, X), feminino(X).
filha(X, Y) :- mae(Y, X), feminino(X).
irmao(X, Y) :- pai(Z, X), pai(Z, Y), masculino(X), X \= Y.
irma(X, Y) :- pai(Z, X), pai(Z, Y), feminino(X), X \= Y.
avo(X, Y) :- pai(X, Z), pai(Z, Y).
avo(X, Y) :- pai(X, Z), mae(Z, Y).
avoh(X, Y) :- mae(X, Z), pai(Z, Y).
avoh(X, Y) :- mae(X, Z), mae(Z, Y).

% Consulta exemplo: Quem é filho de João?
% ?- filho(X, joao).
% Adicionar um novo prato
adicionar_prato(Prato, Produtos) :-
    assertz(prato(Prato, Produtos)),
    open('dados_pratos.txt', append, Str),
    write_term(Str, prato(Prato, Produtos), [fullstop(true), nl(true)]),
    close(Str).

% Listar todos os pratos da base de dados
listar_pratos :-
    findall(Prato, prato(Prato, _), Pratos),
    write('Pratos disponíveis:'), nl,
    listar_pratos_aux(Pratos).

listar_pratos_aux([]).
listar_pratos_aux([H|T]) :-
    write('- '), write(H), nl,
    listar_pratos_aux(T).

% Ler dados do arquivo e preencher a base de dados
carregar_pratos :-
    open('dados_pratos.txt', read, Str),
    ler_pratos(Str),
    close(Str).

ler_pratos(Str) :-
    read(Str, Term),
    ( Term == end_of_file ->
        true
    ; assertz(Term),
      ler_pratos(Str)
    ).

% Exemplo de consulta que mostra pratos e produtos necessários
consulta_prato(Prato) :-
    prato(Prato, Produtos),
    write('Para preparar '), write(Prato), write(' você precisará de: '), nl,
    listar_produtos(Produtos).

% Pratos e os produtos necessários para prepará-los
prato(feijoada, [feijao, carne, arroz]).
prato(bife, [carne, arroz, feijao]).
prato(cafe_da_manha, [cafe, pao, leite]).
prato(sopa, [feijao, carne, arroz]).
prato(almoco_simples, [arroz, feijao, carne]).
prato(jantar_rapido, [arroz, leite, pao]).
prato(lanche, [pao, leite, cafe]).
prato(cafe_completo, [cafe, pao, leite, carne]).
prato(jantar_simples, [arroz, feijao, leite]).
prato(almoco_completo, [arroz, feijao, carne, pao, leite]).

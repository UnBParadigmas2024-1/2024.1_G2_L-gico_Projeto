% Adicionar um novo prato
adicionar_prato(Prato, Produtos) :-
    assertz(prato(Prato, Produtos)),
    open('dados_pratos.txt', append, Str),
    write_term(Str, prato(Prato, Produtos), [fullstop(true), nl(true)]),
    close(Str).

% Listar todos os pratos da base de dados
listar_pratos :-
    carregar_pratos,
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

% Predicado para cadastrar um novo prato
cadastrar_novo_prato :-
    write('Digite o nome do novo prato: '), read(Prato),
    write('Digite os ingredientes do prato (como uma lista Prolog, por exemplo, [feijao, carne, arroz]): '), nl,
    read(Ingredientes),
    adicionar_prato(Prato, Ingredientes),
    write('Novo prato cadastrado com sucesso!'), nl.

% Definição dos ingredientes e suas dietas e sabores
:- dynamic ingrediente/3.
ingrediente(ovos, [vegetariana], [salgado]).
ingrediente(sal, [sem_gluten, vegana, vegetariana], [salgado]).
ingrediente(oleo, [sem_gluten, vegana, vegetariana], [neutro]).
ingrediente(cebola, [sem_gluten, vegana, vegetariana], [salgado]).
ingrediente(tomate, [sem_gluten, vegana, vegetariana], [salgado]).
ingrediente(azeite, [sem_gluten, vegana, vegetariana], [neutro]).
ingrediente(massa, [vegetariana], [neutro]).
ingrediente(farinha, [vegetariana], [neutro]).
ingrediente(acucar, [vegetariana], [doce]).
ingrediente(chocolate, [vegetariana], [doce]).
ingrediente(manteiga, [vegetariana], [neutro]).
ingrediente(cenoura, [sem_gluten, vegana, vegetariana], [neutro]).
ingrediente(batata, [sem_gluten, vegana, vegetariana], [neutro]).
ingrediente(agua, [sem_gluten, vegana, vegetariana], [neutro]).

% Regra para verificar se um ingrediente é compatível com uma dieta
ingrediente_compativel(Ingrediente, Dieta) :-
    ingrediente(Ingrediente, Dietas, _),
    member(Dieta, Dietas).

% Regra para verificar se todos os ingredientes de uma receita são compatíveis com uma dieta
receita_compativel_com_dieta([], _).
receita_compativel_com_dieta([Ingrediente|Rest], Dieta) :-
    ingrediente_compativel(Ingrediente, Dieta),
    receita_compativel_com_dieta(Rest, Dieta).

% Regras para contar sabores dos ingredientes
contar_sabores([], _, 0).
contar_sabores([Ingrediente|Rest], Sabor, Count) :-
    ingrediente(Ingrediente, _, Sabores),
    (   member(Sabor, Sabores)
    ->  contar_sabores(Rest, Sabor, Count1),
        Count is Count1 + 1
    ;   contar_sabores(Rest, Sabor, Count)
    ).

% Regra para determinar o sabor predominante de uma receita
sabor_predominante(Ingredientes, Sabor) :-
    contar_sabores(Ingredientes, salgado, SalgadoCount),
    contar_sabores(Ingredientes, doce, DoceCount),
    contar_sabores(Ingredientes, neutro, NeutroCount),
    max_member(MaxCount, [SalgadoCount, DoceCount, NeutroCount]),
    (   MaxCount = SalgadoCount
    ->  Sabor = salgado
    ;   MaxCount = DoceCount
    ->  Sabor = doce
    ;   Sabor = neutro
    ).

% Regra para listar todas as receitas compatíveis com uma dieta
listar_receitas_dieta(Dieta) :-
    receita(Nome, Ingredientes),
    receita_compativel_com_dieta(Ingredientes, Dieta),
    writeln(Nome),
    fail.
listar_receitas_dieta(_).

% Regra para listar todas as receitas compatíveis com um sabor
listar_receitas_sabor(Sabor) :-
    receita(Nome, Ingredientes),
    sabor_predominante(Ingredientes, Sabor),
    writeln(Nome),
    fail.
listar_receitas_sabor(_).

% Regra principal para ler o tipo de dieta e imprimir as receitas
sugerir_receitas_dieta :-
    writeln('Digite o tipo de dieta (vegetariana, vegana, sem_gluten):'),
    read(Dieta),
    % Converte a entrada para átomos se for uma lista
    (   is_list(Dieta)
    ->  Dieta = [DietaAtom]
    ;   DietaAtom = Dieta
    ),
    writeln('Receitas compatíveis com a dieta:'),
    listar_receitas_dieta(DietaAtom).

% Regra principal para ler o tipo de sabor e imprimir as receitas
sugerir_receitas_sabor :-
    writeln('Digite o tipo de sabor (salgado, doce, neutro):'),
    read(Sabor),
    % Converte a entrada para átomos se for uma lista
    (   is_list(Sabor)
    ->  Sabor = [SaborAtom]
    ;   SaborAtom = Sabor
    ),
    writeln('Receitas compatíveis com o sabor:'),
    listar_receitas_sabor(SaborAtom).

% Regra para listar todas as receitas compatíveis com uma dieta e sabor
listar_receitas_dieta_sabor(Dieta, Sabor) :-
    receita(Nome, Ingredientes),
    receita_compativel_com_dieta(Ingredientes, Dieta),
    sabor_predominante(Ingredientes, Sabor),
    writeln(Nome),
    fail.
listar_receitas_dieta_sabor(_, _).

% Regra para carregar todos os ingredientes a partir de um arquivo txt
carregar_ingredientes :-
    retractall(ingrediente(_)),  % Limpa todos os ingredientes existentes
    open('ingredientes.txt', read, Stream),
    ler_ingredientes(Stream),
    close(Stream),
    write('Ingredientes carregados com sucesso de ingredientes.txt'), nl,
    listar_ingredientes.

% Regra para ler todos os ingredientes
ler_ingredientes(Stream) :-
    read_line_to_string(Stream, Line),
    ( Line \== end_of_file ->
        assertz(ingrediente(Line)),
        ler_ingredientes(Stream)
    ; true
    ).

% Regra buscar todos os ingredientes na base
listar_ingredientes :-
    findall(Ingrediente, ingrediente(Ingrediente, _, _), ListaIngredientes),
    imprimir_cor(laranja, 'Ingredientes disponíveis: '), nl,
    imprimir_ingredientes(ListaIngredientes), nl.

% Regra para imprimir uma lista de ingredientes
imprimir_ingredientes([]).
imprimir_ingredientes([Ingrediente|Resto]) :-
    write(Ingrediente), nl,
    imprimir_ingredientes(Resto).

% Regra para cadastrar um novo ingrediente
cadastrar_ingrediente :-
    write('Nome do ingrediente: '), nl,
    read_term(user_input, Nome, []), % Lê o nome do ingrediente como um termo
    read_line_to_codes(user_input, _), % Limpa o buffer de entrada
    atom_string(NomeAtom, Nome), % Converte o termo para átomo e depois para string

    write('Características (ex. sem_gluten, vegana, vegetariana - separadas por vírgula): '), nl,
    read_term(user_input, Caracteristicas, []), % Lê características como um termo
    read_line_to_codes(user_input, _), % Limpa o buffer de entrada
    atomic_list_concat(CaracteristicasLista, ',', Caracteristicas), % Converte para lista de átomos

    write('Tipo (ex. salgado, doce, neutro - separados por vírgula): '), nl,
    read_term(user_input, Tipos, []), % Lê tipos como um termo
    read_line_to_codes(user_input, _), % Limpa o buffer de entrada
    atomic_list_concat(TiposLista, ',', Tipos), % Converte para lista de átomos

    assertz(ingrediente(NomeAtom, CaracteristicasLista, TiposLista)), % Adiciona o ingrediente à base de conhecimento
    write('Ingrediente cadastrado com sucesso: '), write(NomeAtom), nl.

% Regra principal para ler o tipo de dieta e sabor e imprimir as receitas
sugerir_receitas_dieta_sabor :-
    writeln('Digite o tipo de dieta (vegetariana, vegana, sem_gluten):'),
    read(Dieta),
    (is_list(Dieta) -> Dieta = [DietaAtom] ; DietaAtom = Dieta),
    writeln('Digite o tipo de sabor (salgado, doce, neutro):'),
    read(Sabor),
    (is_list(Sabor) -> Sabor = [SaborAtom] ; SaborAtom = Sabor),
    writeln('Receitas compatíveis com a dieta e sabor:'),
    listar_receitas_dieta_sabor(DietaAtom, SaborAtom).

limpa_terminal :-
    write('\e[2J').

% Regra para ler um número e chamar uma função com base nele
ler_e_chamar_recomendacao :-
    imprimir_cor(amarelo, '===== RECOMENDAÇÃO DE PRATOS ====='), nl,
    write('Escolha uma opção:'), nl,
    imprimir_cor(azul, '[1]'), write(' - Recomendação de pratos com base no meu tipo de dieta'), nl,
    imprimir_cor(azul, '[2]'), write(' - Recomendação de pratos com base no meu tipo de sabor favorito'), nl,
    imprimir_cor(azul, '[3]'), write(' - Recomendações de pratos com base no meu tipo de dieta e sabor favorito'), nl,
    read(Number), % Lê um número da entrada padrão

    % Chama a função correspondente com base no número lido
    (Number =:= 1 ->
        sugerir_receitas_dieta
    ; Number =:= 2 ->
        sugerir_receitas_sabor
    ; Number =:= 3 ->
        sugerir_receitas_dieta_sabor
    ; % Se o número não corresponder a nenhum caso, exibe uma mensagem de erro
        write('Opção inválida.'), nl
    ).




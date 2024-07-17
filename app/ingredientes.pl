% Definição dos ingredientes e suas dietas e sabores
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

sugerir_receitas_dieta_sabor :-
    writeln('Digite o tipo de dieta (vegetariana, vegana, sem_gluten):'),
    read(Dieta),
    (is_list(Dieta) -> Dieta = [DietaAtom] ; DietaAtom = Dieta),
    writeln('Digite o tipo de sabor (salgado, doce, neutro):'),
    read(Sabor),
    (is_list(Sabor) -> Sabor = [SaborAtom] ; SaborAtom = Sabor),
    writeln('Receitas compatíveis com a dieta e sabor:'),
    listar_receitas_dieta_sabor(DietaAtom, SaborAtom).




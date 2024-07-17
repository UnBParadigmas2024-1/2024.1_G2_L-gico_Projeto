% Definição dos ingredientes e suas dietas
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

% Definição das receitas e seus ingredientes
receita('Omelete', ['ovos', 'sal', 'cebola']).
receita('Salada de Tomate', ['tomate', 'sal', 'azeite', 'cebola']).
receita('Massa com Molho', ['massa', 'tomate', 'sal', 'azeite']).
receita('Bolo de Chocolate', ['farinha', 'ovos', 'acucar', 'chocolate', 'manteiga']).
receita('Sopa de Legumes', ['cenoura', 'batata', 'cebola', 'agua', 'sal']).

% Regra para verificar se um ingrediente é compatível com uma dieta
ingrediente_compativel(Ingrediente, Dieta) :-
    ingrediente(Ingrediente, Dietas, _),
    member(Dieta, Dietas).

% Regra para verificar se todos os ingredientes de uma receita são compatíveis com uma dieta
receita_compativel_com_dieta([], _).
receita_compativel_com_dieta([Ingrediente|Rest], Dieta) :-
    ingrediente_compativel(Ingrediente, Dieta),
    receita_compativel_com_dieta(Rest, Dieta).

% Regra para listar todas as receitas compatíveis com uma dieta
listar_receitas(Dieta) :-
    receita(Nome, Ingredientes),
    receita_compativel_com_dieta(Ingredientes, Dieta),
    writeln(Nome),
    fail.
listar_receitas(_).

% Regra principal para ler o tipo de dieta e imprimir as receitas
sugerir_receitas :-
    writeln('Digite o tipo de dieta (vegetariana, vegana, sem_gluten):'),
    read(Dieta),
    % Converte a entrada para átomo se for uma lista
    (   is_list(Dieta)
    ->  Dieta = [DietaAtom]
    ;   DietaAtom = Dieta
    ),
    writeln('Receitas compatíveis com a dieta:'),
    listar_receitas(DietaAtom).


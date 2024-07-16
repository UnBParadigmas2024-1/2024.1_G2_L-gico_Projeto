% Importa a base de dados de receitas
:- consult('receitas.pl').

% Ingredientes (nome, dietas, sabores)
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

% Predicado para ler preferências do usuário do terminal
ler_preferencias(Dietas) :-
    write('Digite suas preferências de dietas separadas por vírgula (ex: [sem_gluten,vegana]): '), read(DietasAtom),
    atomic_list_concat(DietasList, ',', DietasAtom),
    maplist(atom_string, DietasList, Dietas).

% Verifica se um ingrediente é adequado com base nas preferências de dietas
ingrediente_adequado(Ingrediente, Dietas) :-
    ingrediente(Ingrediente, DietasIngrediente, _), % Ignora os sabores
    memberchk(vegetariana, DietasIngrediente), % Considera vegetariano como compatível com vegetariano
    memberchk(Ingrediente, DietasIngrediente), % Verifica se o ingrediente está na lista de dietas do usuário
    memberchk(Dietas, DietasIngrediente). % Verifica se a dieta é compatível

% Verifica se uma receita é adequada com base nas preferências de dietas
receita_adequada(Receita, Dietas) :-
    receita(Receita, Ingredientes),
    forall(member(Ingrediente, Ingredientes), ingrediente_adequado(Ingrediente, Dietas)).

% Sugere receitas com base nas preferências do usuário
sugerir_receitas :-
    ler_preferencias(Dietas),
    findall(Receita, receita_adequada(Receita, Dietas), Receitas),
    (Receitas = [] -> write('Nenhuma receita encontrada com as preferências fornecidas.'), nl; 
    write('Receitas sugeridas: '), writeln(Receitas)).

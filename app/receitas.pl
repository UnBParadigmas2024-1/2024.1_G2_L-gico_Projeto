% Verifica se uma receita pode ser feita com os ingredientes disponíveis
receita_possivel(IngredientesDisponiveis, NomeReceita) :-
    receita(NomeReceita, IngredientesNecessarios),
    intersection(IngredientesNecessarios, IngredientesDisponiveis, IngredientesNecessarios).

% Imprime uma lista de receitas, cada uma em uma linha separada
imprimir_receitas([]).
imprimir_receitas([H|T]) :-
    write('- '), writeln(H),
    imprimir_receitas(T).

% Imprime uma lista de receitas, cada uma em uma linha separada
imprimir_receitas_incompletas([],_).
imprimir_receitas_incompletas([H|T], IngredientesDisponiveis) :-
    receita(H, IngredientesNecessarios),
    subtract(IngredientesNecessarios, IngredientesDisponiveis, IngredientesFaltam),
    format('- ~w~t~20| faltam: ~w~n', [H, IngredientesFaltam]),
    imprimir_receitas_incompletas(T, IngredientesDisponiveis).

% Encontra todas as receitas possíveis usando setof
sugerir_receitas(IngredientesDisponiveis, ReceitasPossiveis) :-
    setof(NomeReceita, receita_possivel(IngredientesDisponiveis, NomeReceita), ReceitasPossiveis).
    
% Define as receitas e seus ingredientes
% receita(str:'receita', list:[ingredientes, ...])
receita('Omelete', ['ovos', 'sal', 'oleo', 'cebola']).
receita('Salada de Tomate', ['tomate', 'sal', 'azeite', 'cebola']).
receita('Massa com Molho', ['massa', 'tomate', 'sal', 'azeite']).
receita('Bolo de Chocolate', ['farinha', 'ovos', 'acucar', 'chocolate', 'manteiga']).
receita('Sopa de Legumes', ['cenoura', 'batata', 'cebola', 'agua', 'sal']).
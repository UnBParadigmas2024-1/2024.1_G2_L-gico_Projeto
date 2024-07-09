% Verifica se uma receita pode ser feita com os ingredientes disponíveis
receita_possivel(IngredientesDisponiveis, NomeReceita) :-
    receita(NomeReceita, IngredientesNecessarios),
    intersection(IngredientesNecessarios, IngredientesDisponiveis, IngredientesNecessarios).

% Encontra todas as receitas possíveis usando setof
sugerir_receitas(IngredientesDisponiveis, ReceitasPossiveis) :-
    setof(NomeReceita, receita_possivel(IngredientesDisponiveis, NomeReceita), ReceitasPossiveis).
    
% Define as receitas e seus ingredientes
% receita(str:'receita', list:[ingredientes, ...])
receita('Teste', ['ovos']).
receita('Omelete', ['ovos', 'sal', 'oleo', 'cebola']).
receita('Salada de Tomate', ['tomate', 'sal', 'azeite', 'cebola']).
receita('Massa com Molho', ['massa', 'tomate', 'sal', 'azeite']).
receita('Bolo de Chocolate', ['farinha', 'ovos', 'acucar', 'chocolate', 'manteiga']).
receita('Sopa de Legumes', ['cenoura', 'batata', 'cebola', 'agua', 'sal']).

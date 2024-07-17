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
:- dynamic receita/2.

receita('Omelete', ['ovos', 'sal', 'oleo', 'cebola']).
receita('Salada de Tomate', ['tomate', 'sal', 'azeite', 'cebola']).
receita('Massa com Molho', ['massa', 'tomate', 'sal', 'azeite']).
receita('Bolo de Chocolate', ['farinha', 'ovos', 'acucar', 'chocolate', 'manteiga']).
receita('Sopa de Legumes', ['cenoura', 'batata', 'cebola', 'agua', 'sal']).

receita('Frango Grelhado', ['frango', 'sal', 'azeite', 'alho']).
receita('Arroz de Carreteiro', ['arroz', 'carne seca', 'cebola', 'pimentao', 'alho']).
receita('Feijoada', ['feijao preto', 'carne seca', 'linguica', 'cebola', 'alho']).
receita('Moqueca de Peixe', ['peixe', 'tomate', 'pimentao', 'leite de coco', 'azeite de dendê']).
receita('Pão de Queijo', ['polvilho doce', 'queijo minas', 'ovos', 'leite', 'oleo']).

receita('Brigadeiro', ['leite condensado', 'chocolate em pó', 'manteiga', 'granulado']).
receita('Quiche de Alho-Poró', ['massa folhada', 'alho-poró', 'ovos', 'creme de leite', 'queijo']).
receita('Lasanha', ['massa de lasanha', 'carne moída', 'tomate', 'queijo', 'molho bechamel']).
receita('Tapioca', ['goma de tapioca', 'sal', 'queijo', 'presunto']).
receita('Farofa', ['farinha de mandioca', 'cebola', 'alho', 'manteiga', 'sal']).

receita('Torta de Frango', ['massa de torta', 'frango desfiado', 'milho', 'ervilha', 'creme de leite']).
receita('Coxinha', ['frango desfiado', 'farinha de trigo', 'batata', 'caldo de galinha', 'farinha de rosca']).
receita('Beijinho', ['leite condensado', 'coco ralado', 'manteiga', 'açúcar']).
receita('Bolinho de Bacalhau', ['bacalhau desfiado', 'batata', 'ovos', 'salsa', 'cebola']).
receita('Mousse de Maracujá', ['maracujá', 'leite condensado', 'creme de leite', 'gelatina']).

receita('Escondidinho de Carne', ['carne moída', 'mandioca', 'cebola', 'alho', 'queijo parmesão']).
receita('Risoto de Cogumelos', ['arroz arbóreo', 'cogumelos', 'caldo de legumes', 'cebola', 'queijo parmesão']).
receita('Panqueca', ['farinha de trigo', 'ovos', 'leite', 'sal', 'recheio a gosto']).
receita('Cuscuz Paulista', ['farinha de milho', 'tomate', 'palmito', 'ervilha', 'sardinha']).
receita('Vatapá', ['pão', 'leite de coco', 'azeite de dendê', 'camarão', 'amendoim']).


:- dynamic selecionado/1.
selecionado('Omelete').
selecionado('Salada de Tomate').

gerenciar_receitas(adicionar) :-
    write('Digite o nome da receita: '), read(Nome),
    write('Digite os ingredientes (como uma lista Prolog): '), read(Ingredientes),
    assertz(receita(Nome, Ingredientes)),
    write('Receita adicionada com sucesso!'), nl.

gerenciar_receitas(remover) :-
    write('Digite o nome da receita que deseja remover: '), read(Nome),
    retractall(receita(Nome, _)),
    write('Receita removida com sucesso!'), nl.

listar_receitas :-
    findall(Nome, receita(Nome, _), ListaReceitas),
    imprimir_cor(azul, 'Receitas disponíveis: '), nl,
    imprimir_receitas(ListaReceitas), nl.

exportar_receitas_para_arquivo :-
    open('receitas.txt', write, Stream),
    findall((Nome, Ingredientes), receita(Nome, Ingredientes), ListaReceitas),
    exportar_lista_de_receitas(ListaReceitas, Stream),
    close(Stream),
    write('Receitas exportadas com sucesso para receitas.txt'), nl.

exportar_lista_de_receitas([], _).
exportar_lista_de_receitas([(Nome, Ingredientes)|T], Stream) :-
    format(Stream, "receita('~w', [", [Nome]),
    exportar_ingredientes(Ingredientes, Stream),
    writeln(Stream, "])."),
    exportar_lista_de_receitas(T, Stream).

exportar_ingredientes([], _).
exportar_ingredientes([H], Stream) :-
    format(Stream, "'~w'", [H]).
exportar_ingredientes([H|T], Stream) :-
    format(Stream, "'~w', ", [H]),
    exportar_ingredientes(T, Stream).

carregar_receitas_de_arquivo :-
    write('Isso irá sobrescrever todas as receitas existentes que não estejam salvas. Deseja continuar? (sim/nao): '), nl,
    read(Resposta),
    (Resposta == sim ->
        retractall(receita(_, _)),  % Limpa todas as receitas existentes
        open('receitas.txt', read, Stream),
        ler_receitas(Stream),
        close(Stream),
        write('Receitas carregadas com sucesso de receitas.txt'), nl
    ;
        write('Operação cancelada.'), nl
    ), 
    nl,
    listar_receitas.

ler_receitas(Stream) :-
    read(Stream, Term),
    ( Term == end_of_file -> true
    ; assertz(Term),
      ler_receitas(Stream)
    ).
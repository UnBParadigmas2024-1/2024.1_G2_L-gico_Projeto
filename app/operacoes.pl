:- [cores].

% Imprime uma lista de receitas, cada uma em uma linha separada
imprimir_receitas([]).
imprimir_receitas([H|T]) :-
    write('- '), writeln(H),
    imprimir_receitas(T).

% Coleta ingredientes do usuário até que ele digite uma string vazia
coletar_ingredientes(Ingredientes) :-
    % Solicita ao usuário que digite um ingrediente
    write('Digite um ingrediente: '),
    % Lê a entrada do usuário como uma string
    read_line_to_string(user_input, Ingrediente),
    % Remove o ponto final da string, se houver
    (sub_string(Ingrediente, _, 1, 0, F), F="." -> sub_string(Ingrediente, 0, _, 1, IngredienteCorrigido) ; IngredienteCorrigido = Ingrediente),
    % Converte o ingrediente para string, se necessário
    atom_string(IngredienteCorrigido, IngredienteString),
    % Verifica se a entrada do usuário é uma string vazia
    ( Ingrediente = "" ->
        % Se a entrada for uma string vazia, define a lista de ingredientes como vazia para parar o programa
        Ingredientes = []
    ; 
        % Caso contrário, chama o predicado recursivamente para coletar mais ingredientes
        coletar_ingredientes(Restantes),
        % Adiciona o ingrediente atual à lista de ingredientes coletados na cabeça da lista
        Ingredientes = [IngredienteString | Restantes]
    ).


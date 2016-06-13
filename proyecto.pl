% Casos de prueba:
% bienEtiquetado(nodo(4,[arista(3,nodo(1,[arista(2,nodo(3,[arista(1,nodo(2,[]))]))]))])).

bienEtiquetado(Arbol):-
	numNodos(Arbol,N),
	nodoBienEt(N,[],[],Nodos,Aristas,Arbol),
	noHayRepeticion(Nodos),
	noHayRepeticion(Aristas).

nodoBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,nodo(E,A)):-
	etiquetaValida(NumNodos,E),
	validarArista(NumNodos,ENodos,EAristas,E),
	aristaBienEt(NumNodos,[E|ENodos],EAristas,Acum1,Acum2,A),
	Nodos = Acum1,
	Aristas = Acum2.

aristaBienEt(_,ENodos,EAristas,ENodos,EAristas,[]).
aristaBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,[arista(E,Nodo)|T]):-
	aristaBienEt(NumNodos,ENodos,EAristas,Acum1,Acum2,T),
	nodoBienEt(NumNodos,Acum1,[E|Acum2],Acum3,Acum4,Nodo),
	Nodos = Acum3,
	Aristas = Acum4.

etiquetaValida(N,E):-
	integer(E),
	E > 0,
	E =< N.

validarArista(_,[],[],_).
validarArista(NumNodos,[N1|_],[E|_],N2):-
	NumAristas is NumNodos - 1,
	etiquetaValida(NumAristas,E),
	E =:= abs(N1-N2).

noHayRepeticion([]).
noHayRepeticion([H|T]):-
	not(member(H,T)),
	noHayRepeticion(T).

%------------------------------------------------------------------------------%
% numNodos(Nodo,Cantidad_Nodos): Cuenta la cantidad de nodos de un arbol. Para
% esto suma el numero de elementos de la lista de aristas con el numero de nodos
% de cada subarbol (esto es realizado por numAritas y aux)
% 
% Variables:
% 	- R: Etiqueta del nodo        - Len: Cantidad de aristas
% 	- A: Lista de aristas         - M: Numero de nodos bajo el nodo actual
% 	- N: Cantidad total de nodos 
%------------------------------------------------------------------------------%

numNodos(nodo(_,[]),1).
numNodos(nodo(_,A),N):-
	numAristas(A,M),
	length(A,Len),
	N is Len + M.

%------------------------------------------------------------------------------%
% numAristas(Aristas,Cantidad_Nodos): Permite recorrer la lista de aristas y
% aplicar la funcion aux a cada elemento de esta lista.
% 
% Variables:
% 	- H: Primera arista de la lista          - T: Cola de la lista de aristas
% 	- M: Numero de nodos bajo el nodo actual - N: Cantidad total de nodos 
%------------------------------------------------------------------------------%

numAristas([],0). % Caso base, no eliminar
numAristas([H|T],N):-
	aux(H,M),
	numAristas(T,A),
	N is M+A.

%------------------------------------------------------------------------------%
% aux(Arista,Cantidad_Nodos): Permite ejecutar la funcion numNodos al nodo del
% extremo inferior de la arista "Arista"
% 
% Variables:
% 	- N: Cantidad total de nodos bajo la arista del nodo raiz.
%------------------------------------------------------------------------------%

aux(arista(_,Nodo),N):-
	numNodos(Nodo,N).

% Caso de prueba numNodos(nodo(4,[arista(1,nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))])),arista(3,nodo(1,[]))])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))]),N).


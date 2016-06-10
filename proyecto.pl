%bienEtiquetado(nodo(_,[])).
%bienEtiquetado(arbol):- numNodos(arbol,N), validar(N,arbol).
%bienEtiquetado().


%validar(N,nodo(R,[])):- integer(), validarEtiqueta(N,R)

%validarEtiqueta(N,R):-
%	R > 0,
%	R =< N.

% Esto se podria unir en la misma funcion quiza.

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

numNodos(nodo(R,[]),0):- integer(R). % Hace falta este integer(R)? Si no, quitar R
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

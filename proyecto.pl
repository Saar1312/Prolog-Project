% Casos de prueba:
% bienEtiquetado(nodo(4,[arista(3,nodo(1,[arista(2,nodo(3,[arista(1,nodo(2,[]))]))]))])).
% bienEtiquetado(nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))])).

% Anoche Wilmer dijo que si pueden haber etiquetas de aristas repetidas -.-
% Podriamos dejarlo asi, porque dijo como que no les voy a exigir eso tambien porque
% no queda mucho tiempo.

%------------------------------------------------------------------------------%
% bienEtiquetado(Arbol): Determina si un arbol dado esta bien etiquetado.
% Dado un árbol A=(V,E) con |V|=N≥1 (y por lo tanto |E|=N-1) diremos que A está 
% bien etiquetado si:
%
% 	- Para todo e perteneciente a E, si a y b son las etiquetas de sus extremos, 
%	la etiqueta de la arista es    e=|a-b|
%
%	- etiquetas(V)={1, ... N}
%
%	- etiquetas(E)={1, ... N-1}
%
% Variables:
%	- Arbol: Arbol a validar
%	- N: Cantidad total de nodos de Arbol 
%	- Aristas: Lista de las etiquetas de las aristas del arbol
%	- Nodos: Lista con las etiquetas de los nodos del arbol
%------------------------------------------------------------------------------%

bienEtiquetado(Arbol):-
	numNodos(Arbol,N),
	nodoBienEt(N,[],[],Nodos,Aristas,0,0,Arbol),
	noHayRepeticion(Nodos),
	noHayRepeticion(Aristas).

%------------------------------------------------------------------------------%
% numNodos(Nodo,Cantidad_Nodos): Cuenta la cantidad de nodos de un arbol. Para
% esto suma de forma recursiva el numero de descendientes y le suma uno.
% 
% Variables:
% 	- A: Lista de aristas         - L: Numero de nodos bajo el nodo actual
% 	- N: Cantidad total de nodos 
%------------------------------------------------------------------------------%


nodoBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,Padre,Rama,nodo(E,A)):-
	etiquetaValida(NumNodos,E),
	aristaValida(NumNodos,Padre,Rama,E),
	aristaBienEt(NumNodos,[E|ENodos],EAristas,Acum1,Acum2,E,Rama,A),
	Nodos = Acum1,
	Aristas = Acum2.


aristaBienEt(_,ENodos,EAristas,ENodos,EAristas,_,_,[]).
aristaBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,Padre,_,[arista(E,Nodo)|T]):-
	aristaBienEt(NumNodos,ENodos,EAristas,Acum1,Acum2,Padre,E,T),
	nodoBienEt(NumNodos,Acum1,[E|Acum2],Acum3,Acum4,Padre,E,Nodo),
	Nodos = Acum3,
	Aristas = Acum4.

etiquetaValida(N,E):-
	integer(E),
	E > 0,
	E =< N.

aristaValida(_,0,0,_).
aristaValida(NumNodos,N1,E,N2):-
	NumAristas is NumNodos - 1,
	etiquetaValida(NumAristas,E),
	E =:= abs(N1-N2).

noHayRepeticion([]).
noHayRepeticion([H|T]):-
	not(member(H,T)),
	noHayRepeticion(T).

%------------------------------------------------------------------------------%
% numNodos(Nodo,Cantidad_Nodos): Cuenta la cantidad de nodos de un arbol. Para
% esto suma de forma recursiva el numero de descendientes y le suma uno.
% 
% Variables:
% 	- A: Lista de aristas         - L: Numero de nodos bajo el nodo actual
% 	- N: Cantidad total de nodos 
%------------------------------------------------------------------------------%

numNodos(nodo(_,[]),1).
numNodos(nodo(_,A),N):-
	aux(A,L),
	N is L+1.

%------------------------------------------------------------------------------%
% aux(Aristas,Cantidad_Nodos): Permite recorrer la lista de aristas y
% aplicar la funcion numNodos a cada nodo en el extremo inferior de cada arista.
% 
% Variables:
% 	- A: Numero de nodos bajo el nodo actual - N: Cantidad total de nodos 
%------------------------------------------------------------------------------%

aux([],0).
aux([arista(_,Nodo)|T],N):-
	numNodos(Nodo,Acum),
	aux(T,Acum2),
	N is Acum + Acum2.

% Caso de prueba numNodos(nodo(4,[arista(1,nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))])),arista(3,nodo(1,[]))])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))]),N).


/*
nodoBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,nodo(E,A)):-
	etiquetaValida(NumNodos,E),
	aristaValida(NumNodos,ENodos,EAristas,E),
	aristaBienEt(NumNodos,[E|ENodos],EAristas,Acum1,Acum2,A),
	Nodos = Acum1,
	Aristas = Acum2.

aristaBienEt(_,ENodos,EAristas,ENodos,EAristas,[]).
aristaBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,[arista(E,Nodo)|T]):-
	aristaBienEt(NumNodos,ENodos,EAristas,Acum1,Acum2,T),
	nodoBienEt(NumNodos,Acum1,[E|Acum],Acum3,Acum4,Nodo),
	Nodos = Acum3,
	Aristas = Acum4.
*/
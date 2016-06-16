% Casos de prueba:
% bienEtiquetado(nodo(4,[arista(3,nodo(1,[arista(2,nodo(3,[arista(1,nodo(2,[]))]))]))])).
% bienEtiquetado(nodo(4,[arista(1,nodo(3,[])),arista(2,nodo(2,[])),arista(3,nodo(1,[]))])).

% Anoche Wilmer dijo que si pueden haber etiquetas de aristas repetidas -.-
% Podriamos dejarlo asi, porque dijo como que no les voy a exigir eso tambien porque
% no queda mucho tiempo.

%------------------------------------------------------------------------------%
% bienEtiquetado(Arbol): 
%
%	Determina si un arbol dado esta bien etiquetado. Dado un árbol A=(V,E) con 
% |V|=N≥1 (y por lo tanto |E|=N-1) diremos que A está bien etiquetado si:
%
% 	- Para todo e perteneciente a E, si a y b son las etiquetas de sus extremos, 
%	la etiqueta de la arista es    e=|a-b|
%
%	- etiquetas(V)={1, ... N}
%
%	- etiquetas(E)={1, ... N-1}
%
%	Se ha asumido que en un arbol bien etiquetado no pueden haber etiquetas de 
% nodos o aristas repetidas. Por esta razon se realiza la evaluacion del predicado
% noHayRepeticion sobre la lista de etiquetas de nodos y aristas del arbol.
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
% nodoBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,Padre,Rama,Nodo): 
%
% 	Este predicado valida la etiqueta del nodo actual "Nodo" evaluando esta etiqueta
% por medio del predicado etiquetaValida. Ademas permite saber si una arista
% cumple con la condicion e=|a-b| de los arboles bien etiquetados. Luego permite
% recorrer de forma recursiva el arbol recorriendo las aristas por medio del predicado 
% aristaBienEt. Finalmente utiliza acumuladores para unificar la lista de etiquetas
% de nodos y aristas con las variables Nodos y Aristas.
%
% Variables:
%	- NumNodos: Cantidad total de nodos
%	- ENodos: Lista con etiquetas de aristas que va acumulando estos valores para
%			finalmente obtener la lista de nodos del arbol.
%	- EAristas: Lista con etiquetas de aristas que va acumulando estos valores para
%			finalmente obtener la lista de aristas del arbol.
%	- Nodos: Lista de etiquetas de nodos
%	- Aristas: Lista de etiquetas de aristas 
%	- Padre: Etiqueta del nodo padre del nodo actual (permite verificar la arista)
%	- Rama: Etiqueta de la arista que une al nodo actual con su padre
%	- Nodo: Nodo actual
%------------------------------------------------------------------------------%

nodoBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,Padre,Rama,nodo(E,A)):-
	etiquetaValida(NumNodos,E),
	aristaValida(NumNodos,Padre,Rama,E),
	aristaBienEt(NumNodos,[E|ENodos],EAristas,Acum1,Acum2,E,Rama,A),
	Nodos = Acum1,
	Aristas = Acum2.

%------------------------------------------------------------------------------%
% aristaBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,Padre,Rama,Arista): 
%
%	Permite evaluar el predicado nodoBienEt de forma recursiva recorriendo las aristas
% del arbol.
%
% Variables:
%	- NumNodos: Cantidad total de nodos
%	- ENodos: Lista con etiquetas de aristas que va acumulando estos valores para
%			finalmente obtener la lista de nodos del arbol.
%	- EAristas: Lista con etiquetas de aristas que va acumulando estos valores para
%			finalmente obtener la lista de aristas del arbol.
%	- Nodos: Lista de etiquetas de nodos
%	- Aristas: Lista de etiquetas de aristas 
%	- Padre: Etiqueta del nodo padre del nodo actual (permite verificar la arista)
%	- Rama: Etiqueta de la arista que une al nodo actual con su padre
%	- Arista: Arista actual
%------------------------------------------------------------------------------%

aristaBienEt(_,ENodos,EAristas,ENodos,EAristas,_,_,[]).
aristaBienEt(NumNodos,ENodos,EAristas,Nodos,Aristas,Padre,_,[arista(E,Nodo)|T]):-
	aristaBienEt(NumNodos,ENodos,EAristas,Acum1,Acum2,Padre,E,T),
	nodoBienEt(NumNodos,Acum1,[E|Acum2],Acum3,Acum4,Padre,E,Nodo),
	Nodos = Acum3,
	Aristas = Acum4.

%------------------------------------------------------------------------------%
% etiquetaValida(NumNodos,Etiqueta_a_validar): Determina si una etiqueta cumple 
% con las restricciones: 
%
%	- etiquetas(V)={1, ... N}
%	- etiquetas(E)={1, ... N-1}
% 
% Variables:
% 	- E: Etiqueta de un nodo o una arista
% 	- N: Cantidad total de nodos 
%------------------------------------------------------------------------------%

etiquetaValida(N,E):-
	integer(E),
	E > 0,
	E =< N.

%------------------------------------------------------------------------------%
% aristaValida(NumNodos,Etiqueta_padre,Etiqueta_arista,Etiqueta_hijo): 
%
%	Determina si una arista cumple con la restriccion e=|a-b|.
% 
% Variables:
%
% 	- NumNodos: Cantidad total de nodos
% 	- N1: Etiqueta del nodo padre
% 	- N2: Etiqueta del nodo hijo
% 	- E: Etiqueta de la arista
%------------------------------------------------------------------------------%

aristaValida(_,0,0,_).
aristaValida(NumNodos,N1,E,N2):-
	NumAristas is NumNodos - 1,
	etiquetaValida(NumAristas,E),
	E =:= abs(N1-N2).

%------------------------------------------------------------------------------%
% noHayRepeticion(Lista): 
%
%	Determina si una lista no posee repeticiones. Por lo tanto
% el predicado sera verdadero en caso de que Lista no contenga elementos repetidos.
% 
% Variables:
%
% 	- Lista ([H|T]): 
%------------------------------------------------------------------------------%

noHayRepeticion([]).
noHayRepeticion([H|T]):-
	not(member(H,T)),
	noHayRepeticion(T).

%------------------------------------------------------------------------------%
% numNodos(Nodo,Cantidad_Nodos): 
%
%	Cuenta la cantidad de nodos de un arbol. Para
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
% aux(Aristas,Cantidad_Nodos): 
%
%	Permite recorrer la lista de aristas y
% evaluar el predicado numNodos a cada nodo en el extremo inferior de cada arista.
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
esqueleto(N,R,Esqueleto):-
	aux(N,R,0,Esqueleto).

aux(0,_,_,nil). % Si pasan esqueleto(0,1,Arbol), que evalua?
aux(1,_,_,).
aux(N,R,0,Esqueleto):-
	R =< N-1,% ! para que no busque mas si la aridad esta mala?
	aux2([1],N,R,Hijos)
	esq(Hijos).

aux2(1,)
aux2(Padres,N,[H|T],Hijos):-
	numHijos(H,N),
	N =:= length(H2),
	esNoCreciente(H2).

cantidadHijos(L,)

----------------------------------
esqueleto(N,R,esq(Esqueleto)):-
	N > 0,
	R > 0,
	esEsqueleto(N,R,[1],Esqueleto,NumNodos),
	NumNodos == N.

esEsqueleto(_,_,_,[[]],0).
esEsqueleto(N,R,Padres,[H|T],Acum):-
	numHijos(Padres,Hijos),
	length(H,Len),
	Hijos =:= Len,
	headNTail(H,H1,T1),
	esNoCreciente(T1,H1),
	esEsqueleto(N,R,H,[T],M),
	Acum is M + Hijos.

headNTail([H|T],H,T).

numHijos([],0).
numHijos([H|T],N):-
	numHijos(T,M),
	N is H+M.

esNoCreciente([],_).
esNoCreciente([H|T],Head):-
	Head >= H,
	esNoCreciente(T,H).
-----------------------------


esqueleto(N,R,esq(Esqueleto)):-
	esEsqueleto(N,R,[1],Esqueleto),
	contarNodos(Esqueleto,M),
	M == N.

contarNodos([],0).
contarNodos([H|T],NumNodos):-
	numHijos(H,M),
	contarNodos(T,Acum),
	NumNodos is Acum + M.


esEsqueleto(_,_,_,[[]],0).
esEsqueleto(N,R,Padres,[H|T]):-
	numHijos(Padres,Hijos),
	length(H,Len),
	Hijos =:= Len,
	headNTail(H,H1,T1),
	esNoCreciente(T1,H1),
	esEsqueleto(N,R,H,[T]).

headNTail([H|T],H,T).

numHijos([],0).
numHijos([H|T],N):-
	numHijos(T,M),
	N is H+M.

esNoCreciente([],_).
esNoCreciente([H|T],Head):-
	Head >= H,
	esNoCreciente(T,H).


arbolBin(0,nill).
arbolBin(N,nill):-
	N<0.
arbolBin(N,Arbol):-
	N > 0,
	N1 is N-1,
	arbolBin(N1,Arbol1),
	N2 is N1-1,
	arbolBin(N2,Arbol2),
	Arbol = arb(Arbol1,Arbol2).

*/

esqueleto(N,R,Esqueleto):-
	N > 0,
	R > 0,
	esqueleto1(N,R,1,Hijos),
	Esqueleto = esq(Hijos).

esqueleto1(0,_,Len,Lista):-
	zero(Len,Ceros),
	Lista = [Ceros],!.
esqueleto1(N,R,NumHijos,Niveles):-
	esqueleto2(N,R,NumHijos,Hijos,M), % M: Cantidad de nodos en el siguiente nivel
	NumNodos is N - M,
	esqueleto1(NumNodos,R,M,Nivel),
	Niveles = [Hijos|Nivel].

esqueleto2(_,_,0,[],0).
esqueleto2(N,R,Len,Nivel,M):-
	rango(N,Opciones,1),
	member(NumHijos,Opciones),
	NumHijos =< R, % Cada cantidad de hijos que se escoja debe ser menor que la aridad
	Restantes is N - NumHijos,
	Length is Len - 1,
	esqueleto2(Restantes,R,Length,NivelNuevo,M2),
	M is M2 + NumHijos,
	Nivel = [NumHijos|NivelNuevo].

rango(N,Lista,N):-
	Lista = [N].
rango(N,Lista,Acum):-
	Acum < N,
	Acum2 is Acum + 1,
	rango(N,Lista2,Acum2),
	Lista = [Acum|Lista2].

zero(0,[]).
zero(Len,Lista):-
	Restantes is Len - 1,
	zero(Restantes,Lista2),
	Lista = [0|Lista2].
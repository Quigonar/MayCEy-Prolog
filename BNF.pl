:- ['Database'].

% DIFERENTES POSIBLES ESTRUCTURAS PARA LAS ORACIONES INTRODUCIDAS POR EL USUARIO
% oracion(Lista_palabras,[]).
oracion(S0,S):-sintagma_nominal(S0,S1),sintagma_verbal(S1,S). % oracion formada por un sintagma nominal y un sintagma verbal
oracion(S0,S):-adverbio(S0,S1),sintagma_nominal(S1,S2),sintagma_verbal(S2,S). % oracion formada por un adverbio, un sintagma nominal y un sintagma verbal
oracion(S0,S):-sintagma_verbal(S0,S). % oracion formada por un sintagma verbal
oracion(S0,S):-sintagma_nominal(S0,S). % oracion formada por un sintagma nominal
oracion(S0,S):-adverbio(S0,S). % oracion formada por un adverbio
oracion(S0,S):-palabras_clave(S0,S).


% SINTAGMA NOMINAL DE LA ORACION
% formado por pronombres, nombres y complementos directos
sintagma_nominal(S0,S):-pronombre(S0,S).
sintagma_nominal(S0,S):-complemento_directo(S0,S).


% COMPLEMENTO DIRECTO DE LA ORACION
% combinaciones de nombres, adjetivos, y articulos.
complemento_directo(S0,S):-sustantivo(S0,S). % solo lo forma un sustantivo
complemento_directo(S0,S):-adjetivo(S0,S). % solo lo forma un adjetivo
complemento_directo(S0,S):-articulo(S0,S).
complemento_directo(S0,S):-matricula(S0,S1),matricula(S1,S2),matricula(S2,S3),matricula(S3,S).
complemento_directo(S0,S):-articulo(S0,S1),sustantivo(S1,S). % se forma de un articulo y un sustantivo
complemento_directo(S0,S):-articulo(S0,S1),sustantivo(S1,S2),adjetivo(S2,S). % se forma de un articulo, un sustantivo y un adjetivo
complemento_directo(S0,S):-sustantivo(S0,S1),complemento_directo(S1,S). % solo lo forma un sustantivo


% SINTAGMA VERBAL
% formado por pronombres, nombres y complementos directos
sintagma_verbal(S0,S):-verbo_transitivo(S0,S). % solo lo forma un vervo conjugado
sintagma_verbal(S0,S):-verbo_infinitivo(S0,S).
sintagma_verbal(S0,S):-verbo_transitivo(S0,S1),complemento_directo(S1,S). % lo forma un verbo conjugado y un complemento directo
sintagma_verbal(S0,S):-verbo_infinitivo(S0,S1),complemento_directo(S1,S). % lo forma un verbo conjugado y un complemento directo
sintagma_verbal(S0,S):-verbo_transitivo(S0,S1),sintagma_verbal(S1,S).
sintagma_verbal(S0,S):-verbo_infinitivo(S0,S1),sintagma_verbal(S1,S).
sintagma_verbal(S0,S):-conectores(S0,S1),sintagma_verbal(S1,S).
sintagma_verbal(S0,S):-conectores(S0,S1),complemento_directo(S1,S).
sintagma_verbal(S0,S):-verbo_transitivo(S0,S1),complemento_directo(S1,S2),sintagma_verbal(S2,S). % lo forma un verbo conjugado y un complemento directo
sintagma_verbal(S0,S):-verbo_infinitivo(S0,S1),complemento_directo(S1,S2),sintagma_verbal(S2,S). % lo forma un verbo conjugado y un complemento directo

% PALABRAS CLAVES
palabras_clave(S0,S):-saludo(S0,S).
palabras_clave(S0,S):-saludo(S0,S1),maycey(S1,S).
palabras_clave(S0,S):-despedida(S0,S).
palabras_clave(S0,S):-agradecimiento(S0,S).
palabras_clave(S0,S):-solicitud_emergencia(S0,S).

% TODOS LOS ARTICULOS QUE PUEDEN ACOMPAÑAR UN NOMBRE
articulo(['el'|S],S).
articulo(['mas'|S],S).
articulo(['por'|S],S).
articulo(['en'|S],S).
articulo(['para'|S],S).
articulo(['mi'|S],S).
articulo(['este'|S],S).
articulo(['al'|S],S).
articulo(['a'|S],S).
articulo(['los'|S],S).
articulo(['a','los'|S],S).
articulo(['en','los'|S],S).
articulo(['la'|S],S).
articulo(['en','la'|S],S).
articulo(['a','la'|S],S).
articulo(['las'|S],S).
articulo(['en','las'|S],S).
articulo(['a','las'|S],S).
articulo(['un'|S],S).
articulo(['a','un'|S],S).
articulo(['unos'|S],S).
articulo(['a','unos'|S],S).
articulo(['una'|S],S).
articulo(['a','una'|S],S).
articulo(['unas'|S],S).
articulo(['a','unas'|S],S).
articulo(['de'|S],S).
articulo(['medio'|S],S).


% POSIBLES NOMBRES QUE PUEDEN SER UTILIZADOS EN UNA ORACION EN EL COMPLEMENTO DIRECCTO Y EL SINTAGMA NOMINAL
sustantivo(['vuelo'|S],S).
sustantivo(['pasajero'|S],S).
sustantivo(['aerolinea'|S],S).
sustantivo(['copa'|S],S).
sustantivo(['avianca'|S],S).
sustantivo(['latam'|S],S).
sustantivo(['american'|S],S).
sustantivo(['united'|S],S).
sustantivo(['aeromexico'|S],S).
sustantivo(['tec-airlines'|S],S).
sustantivo(['ace'|S], S).
sustantivo(['permiso'|S],S).
sustantivo(['motor'|S],S).
sustantivo(['boing','747'|S],S).
sustantivo(['airbus','a340'|S],S).
sustantivo(['airbus','a380'|S],S).
sustantivo(['embraer','190'|S],S).
sustantivo(['airbus','a220'|S],S).
sustantivo(['cessna'|S],S).
sustantivo(['beechcraft'|S],S). 
sustantivo(['embraer','phenom'|S],S).
sustantivo(['velocidad'|S],S).
sustantivo(['distancia'|S],S).
sustantivo(['direccion'|S],S).
sustantivo([_NumVelocidad,'km/h'|S],S).
sustantivo([_NumDistancia,'km'|S],S).
sustantivo([_NumVuelo|S],S).
sustantivo([_Hora,':',_Minutos|S],S).
sustantivo(['este','a','oeste'|S],S).
sustantivo(['oeste','a','este'|S],S).
sustantivo(['matricula'|S],S).


% POSIBLES ADJETIVOS UTILIZADOS EN UNA ORACION
adjetivo(['rapido'|S],S).
adjetivo(['inmediato'|S],S).
adjetivo(['cardiaco'|S],S).


% POSIBLES VERBOS INFINITIVOS UTILIZADOS EN UNA ORACION
verbo_infinitivo(['salir'|S],S).
verbo_infinitivo(['despegar'|S],S).
verbo_infinitivo(['aterrizar'|S],S).
verbo_infinitivo(['llegar'|S],S).
verbo_infinitivo(['solicitar'|S],S).


% POSIBLES VERBOS TRANSITIVOS O CONJUGADOS UTILIZADOS EN UNA ORACION
verbo_transitivo(['salgo'|S],S).
verbo_transitivo(['voy'|S],S).
verbo_transitivo(['sale'|S],S).
verbo_transitivo(['quiero'|S],S).
verbo_transitivo(['gustaria'|S],S).
verbo_transitivo(['deseo'|S],S).
verbo_transitivo(['quisiera'|S],S).
verbo_transitivo(['tengo'|S],S).
verbo_transitivo(['estoy'|S],S).
verbo_transitivo(['gusto'|S],S).
verbo_transitivo(['solicito'|S],S).
verbo_transitivo(['perdida'|S],S).
verbo_transitivo(['parto'|S],S).
verbo_transitivo(['paro'|S],S).
verbo_transitivo(['secuestro'|S],S).
verbo_transitivo(['es'|S],S).


% POSIBLES PRONOMBRES UTILIZADOS COMO SUJETO EN UNA ORACION
pronombre(['yo'|S],S).
pronombre(['me'|S],S).
pronombre(['mi'|S],S).


% POSIBLES ADVERBIOS DE NEGACION Y AFIRMACION UTILIZADOS EN UNA ORACION
adverbio(['si'|S],S).
adverbio(['si,'|S],S).
adverbio(['no'|S],S).
adverbio(['no,'|S],S).
adverbio(['ninguno,'|S],S).

% POSIBLES SALUDOS UTILIZADOS EN UNA ORACION
saludo(['hola'|S],S).
saludo(['buenas'|S],S).
saludo(['buenos','dias'|S],S).
saludo(['buenas','tardes'|S],S).
saludo(['buenas','noches'|S],S).

% POSIBLES INDICADORES DE EMERGENCIA UTILIZADOS EN UNA ORACION
solicitud_emergencia(['mayday,','mayday'|S],S).
solicitud_emergencia(['mayday','mayday'|S],S).
solicitud_emergencia(['emergencia'|S],S).
solicitud_emergencia(['7500'|S],S).

% POSIBLES LETRAS PARA MATRICULA DE AVION EN UNA ORACION
matricula(['alpha'|S],S).
matricula(['bravo'|S],S). 
matricula(['charlie'|S],S).
matricula(['delta'|S],S).
matricula(['echo'|S],S).
matricula(['foxtrot'|S],S).
matricula(['golf'|S],S).
matricula(['hotel'|S],S).
matricula(['india'|S],S).
matricula(['juliet'|S],S).
matricula(['kilo'|S],S).
matricula(['lima'|S],S).
matricula(['mike'|S],S).
matricula(['november'|S],S).
matricula(['oscar'|S],S).
matricula(['papa'|S],S).
matricula(['quebec'|S],S).
matricula(['romeo'|S],S).
matricula(['sierra'|S],S).
matricula(['tango'|S],S).
matricula(['uniform'|S],S).
matricula(['victor'|S],S).
matricula(['whiskey'|S],S).
matricula(['xray'|S],S).
matricula(['yankee'|S],S).
matricula(['zulu'|S],S).

% POSIBLES AGRADECIMIENTOS UTILIZADOS EN UNA ORACION
agradecimiento(['gracias'|S],S).
agradecimiento(['gracias!'|S],S).
agradecimiento(['muchas','gracias'|S],S).
agradecimiento(['muchas','gracias!'|S],S).

% POSIBLES DESPEDIDAS UTILIZADOS EN UNA ORACION
despedida(['adios'|S],S).
despedida(['chao'|S],S).
despedida(['hasta','luego'|S],S).
despedida(['hasta','pronto'|S],S).
despedida(['cambio','y','fuera'|S],S).

% NOMBRE DE LA MAQUINA
maycey(['maycey'|S],S).
maycey(['maycey!'|S],S).

% POSIBLES CONECTORES UTILIZADOES EN UNA ORACION
conectores(['y'|S],S).
conectores(['adenas'|S],S).
conectores(['o'|S],S).


eliminar_caracter_string(S,C,X) :- atom_concat(L,R,S), atom_concat(C,W,R), atom_concat(L,W,X).

% REGLA PARA LEER LE ORACION DEL USUARIO. ESTA ORACION SE GUARDA COMO UNA LISTA DE PALABRAS PARA LUEGO SER EVALUADA
% POR LA REGLA oracion.
% oracion(). List contiene lo que el usuario escribe
my_read(List):-
    read_string(user,"\n","\r",_,String), % divide la oracion en palabras
    downcase_atom(String, Lstring),       % Convierte la oracion en minusculas
    eliminar_caracter_string(Lstring, '.', Nstring),
    atom_string(Atom, Nstring),           % Convierte el atomo a un string
    atomic_list_concat(List,' ',Atom).    % lista de palabras, caracter a concatenar, variable donde se guarda
    %write(List).
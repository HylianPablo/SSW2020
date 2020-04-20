drop table if exists PertenenciaPlato;
drop table if exists Ingrediente;
drop table if exists PlatoMenu;
drop table if exists Plato;
drop table if exists Comentario;
drop table if exists Entrada;
drop table if exists Guardado;
drop table if exists Usuario;
drop table if exists Dieta;

create table Dieta(
	codigoDieta				integer not null auto_increment,
	titulo					char(20) not null,
	descripcion				text not null,
	fecha					date not null,
	primary key(codigoDieta)
);

create table Usuario(
	nombre					char(50) not null,
	nombreUsuario			char(20) not null,
	contrasena				char(20) not null,
	correo					char(40) not null,
	favorito				integer,
	foreign key(favorito) references Dieta(codigoDieta),
	primary key(nombreUsuario)
);


create table Guardado(
	nombreUsuario			char(20) not null,
	codigoDieta				integer not null,
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	foreign key(codigoDieta) references Dieta(codigoDieta),
	primary key(nombreUsuario, codigoDieta)
);

create table Entrada(
	codigoEntrada			integer not null auto_increment,
	titulo					char(50) not null,
	cuerpo					text,
	nombreUsuario			char(20) not null,
	fecha					date not null,
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	primary key(codigoEntrada)
);

create table Comentario(
	codigoComentario		integer not null auto_increment,
	codigoPadre				integer not null,
	cuerpo					text not null,
	nombreUsuario			char(20) not null,
	fecha					date not null,
	foreign key(codigoPadre) references Entrada(codigoEntrada),
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	primary key(codigoComentario)
);	

create table Plato(
	codigoPlato 			integer not null auto_increment,
	nombre					char(100) not null,
	descripcion				text,
	desayuno				boolean not null,
	vegano					boolean not null,
	vegetariano				boolean not null,
	frutosSecos				boolean not null,
	gluten					boolean not null,
	kcal					integer not null,
	glucidosSimples			integer not null,
	polisacaridos 			integer not null,
	aminoacidos				integer not null ,
	proteinas				integer not null,
	hidratosDeCarbono		integer not null,
	primary key(codigoPlato)
);

create table PlatoMenu(
	codigoPlato				integer not null auto_increment,
	codigoDieta				integer,
	diaSemana				char(20) not null,
	check (diaSemana in ('lunes','martes','miercoles','jueves','viernes','sabado','domingo')),
	momento					char(30) not null,
	check (momento in ('desayuno','comidaPrimero','comidaSegundo','cena')),
	foreign key(codigoPlato) references Plato(codigoPlato), 
	foreign key(codigoDieta) references Dieta(codigoDieta),
	primary key(codigoPlato, codigoDieta)
);

create table Ingrediente(
	codigoIngrediente		integer not null auto_increment,
	nombre 					char(30) not null,
	vegano 					boolean	 not null,
	vegetariano				boolean  not null,
	frutosSecos         	boolean  not null,
	gluten		         	boolean  not null,
	primary key(codigoIngrediente)
);

create table PertenenciaPlato(
	codigoIngrediente		integer not null,
	codigoPlato 			integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	foreign key(codigoPlato) references Plato(codigoPlato),
	primary key(codigoIngrediente, codigoPlato)
);

insert into Dieta (titulo,descripcion,fecha) Values ('Dieta vegeteriana','Una dieta que no lleva animales, salvo ovolácteos','2018-01-01');
insert into Dieta (titulo,descripcion,fecha) Values ('Dieta mediterranea','Una dieta basada en la comida tradicional de la costa mediterranea','2020-04-10');
insert into Dieta (titulo,descripcion,fecha) Values ('Dieta de deportistas','Una dieta orientada a personas que realizan mucho deporte a diario','2020-03-01');


insert into Usuario (nombre,nombreUsuario,contrasena,correo,favorito) Values ('Pedro Sanz Lopez', 'pedsanz', '12345pedro','pedrosanzl@gmail.com',1);
insert into Usuario (nombre,nombreUsuario,contrasena,correo,favorito) Values ('Marta Sanchez Rojo', 'martsanro', 'farola4','marta1912@gmail.com',2);
insert into Usuario (nombre,nombreUsuario,contrasena,correo,favorito) Values ('Marcos Moya Gallo', 'marmoyaga', 'tirabuzon89','marcos.mg@yahoo.com',3);

insert into Guardado (nombreUsuario,codigoDieta) Values ('pedsanz',1);
insert into Guardado (nombreUsuario,codigoDieta) Values ('martsanro',2);
insert into Guardado (nombreUsuario,codigoDieta) Values ('marmoyaga',3);


insert into Entrada (titulo,cuerpo,nombreUsuario,fecha) Values ('Quiero comer bien','Quiero tener una alimentacion sana y no se cocinar','pedsanz','2020-04-03');
insert into Entrada (titulo,cuerpo,nombreUsuario,fecha) Values ('Quiero ser vegana',NULL,'martsanro','2020-03-23');
insert into Entrada (titulo,cuerpo,nombreUsuario,fecha) Values ('Receta de cupcakes','Esta receta me la enseño mi abuela. Lleva harina y huevos','marmoyaga','2020-03-08');


insert into Comentario (codigoPadre,cuerpo,nombreUsuario,fecha) Values (1,'Prueba a evitar demasiadas grasas saturadas y calorías vacias como las propocionadas por bebidas alcoholicas o la bolleria industrial','pedsanz','2020-04-05');
insert into Comentario (codigoPadre,cuerpo,nombreUsuario,fecha) Values (1,'El aguacate es un alimento muy sano, incluyelo en tus platos','marmoyaga','2020-04-06');
insert into Comentario (codigoPadre,cuerpo,nombreUsuario,fecha) Values (2,'No comas carne','pedsanz','2020-03-25');

insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espinaca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Garbanzo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Aceite de oliva',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Ajo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimentón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sal fina',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pez espada',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Limón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Romero',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Piñón',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Macarrón',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Carne picada',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Tomate',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Orégano',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Merluza',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Cebolla',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimiento verde',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimiento rojo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de pollo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Langostinos',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Palitos de cangrejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Piña',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lechuga',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mayonesa',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Vinagre',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimienta negra',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa carbonara',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Agua',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Nata',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Queso',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espagueti',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Costillas de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Almidón',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de limón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa barbacoa',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Leche entera',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mora',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Frambuesa',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Arándanos',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Azúcar',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Melón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Jamón',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pan',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Atún',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Bacon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Harina',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Berza',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Calabacín',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Judía',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Guisante',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zanahoria',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Col',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Haba',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Alcachofa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Endivia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Nuez',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Queso azul',FALSE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Conejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Patata',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Laurel',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Perejil',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Seta',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Huevo',FALSE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Arroz',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Puerro',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Vino blanco',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de limón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Brandy',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Tomillo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Ternera',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mantequilla',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Aceituna',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Chorizo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lenteja',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de ternera',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimienta blanca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lenguado',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Rape',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Gamba',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mejillon',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Marisco',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Solomillo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pepino',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Berenjena',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sal gruesa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lubina',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Esparrago',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Codillo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa César',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pechuga de pollo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pollo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Fideo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Alubia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Tocino',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Morcilla',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espiral',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salmón',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sepia',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de lomo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa verde',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de pavo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Repollo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Negrito',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Acelga',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pepinillo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Chicharro',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Panceta',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Bacalao',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de naranja',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de piña',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de melocotón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Carne de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Café',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Agua caliente',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mermelada de melocotón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de mango',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mermelada de frambuesa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Té',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Menta poleo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de pomelo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mermelada de fresa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mermelada de manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Cacao',TRUE,TRUE,FALSE,FALSE);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Garbanzos con espinacas','Garbanzos de la huerta cocinados con espinaca y aceite de oliva',FALSE,TRUE,TRUE,FALSE,FALSE,350,10,10,10,50,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (1,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,1);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Pez espada','Pez espada con limón y romero, marinado con piñones',FALSE,FALSE,FALSE,TRUE,FALSE,280,10,20,30,20,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (7,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (8,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (9,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (10,2);



insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Macarrones a la boloñesa','Macarrones con carne picada, tomate y orégano',FALSE,FALSE,FALSE,FALSE,TRUE,400,10,10,10,10,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (11,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (12,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (14,3);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Sopa de pescado','Sopa de merluza con cebolla, pimiento verde, pimiento rojo, laurel y ajo',FALSE,FALSE,FALSE,FALSE,FALSE,100,10,15,20,18,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,4);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Filetes de pollo','Filetes de pollo al grill y tomate aliñado',FALSE,FALSE,FALSE,FALSE,FALSE,200,10,10,20,17,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,5);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,5);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (19,5);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Cóctel de langostinos','Cóctel de langostinos con palitos de cangrejo',FALSE,FALSE,FALSE,FALSE,FALSE,80,13,18,28,10,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (20,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (21,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (22,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (24,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,6);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Espaguetis a la carbonara','Espaguetis con salsa carbonara',FALSE,FALSE,FALSE,FALSE,TRUE,141,7,12,11,5,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (27,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (29,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (31,7);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Costillas','Costillas de cerdo a la barbacoa',FALSE,FALSE,FALSE,FALSE,FALSE,186,10,13,12,16,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (32,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (33,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (34,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (35,8);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Yogur de frutas del bosque','Yogur de frutas del bosque',TRUE,TRUE,TRUE,FALSE,TRUE,84,3,6,8,4,10);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (33,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (37,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (38,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (39,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (40,9);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Melón con jamón','Melón con jamón',FALSE,FALSE,FALSE,FALSE,TRUE,237,13,17,18,30,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (41,10);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,10);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Baguettes de atún y bacon','Baguettes de atún y bacon',FALSE,FALSE,FALSE,FALSE,TRUE,275,11,12,10,14,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (45,11);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Lasaña Boloñesa','Lasaña Boloñesa con carne de cerdo',FALSE,FALSE,FALSE,FALSE,TRUE,148,7,15,17,7,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (40,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (47,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,12);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Berza cocida','Berza cocida con aceite, ajo y pimentón',FALSE,TRUE,TRUE,FALSE,FALSE,63,2,8,5,5,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,13);



insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Potaje de garbanzos','Potaje de garbanzos con verduras',FALSE,TRUE,TRUE,FALSE,FALSE,269,5,8,20,12,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,14);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Menestra','Menestra de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,141,7,8,5,6,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (49,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (52,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (53,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (54,15);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada de endivias','Ensalada de endivias con manzana, queso azul cebolla y nueces',FALSE,TRUE,TRUE,TRUE,FALSE,20,1,3,5,2,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (55,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (56,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (57,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (58,16);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Conejo guisado','Conejo guisado con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,TRUE,179,10,3,5,27,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (59,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,17);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Guisantes con jamón','Guisantes con jamón con ajo, cebolla y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,160,15,11,9,5,5);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,18);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Revuelto de setas','Revuelto de setas con huevos y ajo',FALSE,FALSE,TRUE,FALSE,FALSE,28,0,2,3,2,5);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (63,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,19);



insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Arroz frito','Arroz frito con zanahoria, puerro y cebolla',FALSE,TRUE,TRUE,FALSE,FALSE,228,12,8,3,7,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,20);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Merluza al horno','Merluza al horno con cebolla, ajo, vino blanco, zumo de limon, pimentón y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,130,3,10,11,23,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (68,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,21);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ternera asada','Ternera asada con pimiento rojo, cebolla, ajo, zanahorias, brandy, tomillo y patatas',FALSE,FALSE,FALSE,FALSE,FALSE,154,3,8,7,32,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (69,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (70,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (71,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,22);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Pure de patata','Pure de patata con mantequilla y leche entera',FALSE,TRUE,TRUE,FALSE,TRUE,215,7,12,15,4,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,23);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (72,23);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,23);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,23);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Tortilla francesa','Tortilla francesa',FALSE,FALSE,TRUE,FALSE,FALSE,214,17,4,7,13,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,24);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,24);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,24);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensaladilla rusa','Ensaladilla rusa con patatas, zanahorias, huevos, aceitunas y atún',FALSE,FALSE,TRUE,FALSE,FALSE,122,11,2,5,1,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (73,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (24,25);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,25);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Lentejas','Lentejas con chorizo, cebolla, patatas, zanahorias, ajo y aceite',FALSE,FALSE,TRUE,FALSE,FALSE,122,11,2,5,1,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (74,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (75,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,26);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Filete de ternera','Filete de ternera a la plancha',FALSE,FALSE,FALSE,FALSE,FALSE,159,4,12,15,27,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (76,27);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,27);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,27);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Lenguado al horno','Lenguado al horno con harina, limon, pimienta blanca y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,112,2,10,10,21,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (77,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (78,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (8,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,28);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Tortilla de patata','Tortilla de patata con cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,112,2,10,10,21,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,29);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,29);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,29);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,29);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Crema calabacín','Crema calabacín con patatas, cebolla y ajo',FALSE,TRUE,TRUE,FALSE,FALSE,34,3,2,1,1,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,29);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Paella de marisco','Paella de marisco con arroz, rape, gambas y mejillones',FALSE,FALSE,FALSE,FALSE,FALSE,379,13,12,11,23,40);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (79,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (80,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (81,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (82,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (20,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,31);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Solomillo de cerdo','Solomillo de cerdo con arroz',FALSE,FALSE,FALSE,FALSE,FALSE,158,8,12,8,22,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (83,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,32);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Gazpacho','Gazpacho con pimiento verde y pepino',FALSE,TRUE,TRUE,FALSE,FALSE,85,74,11,8,7,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (84,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,33);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Berenjenas en escabeche','Berenjenas en escabeche',FALSE,TRUE,TRUE,FALSE,FALSE,49,1,2,3,1,10);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (85,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (14,34);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Lubina al horno','Lubina al horno con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,98,3,10,13,19,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (87,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,35);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Espaguetis de calabacín','Espaguetis de calabacín con gambas',FALSE,FALSE,FALSE,FALSE,FALSE,176,7,11,12,21,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (31,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (80,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,36);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada mixta','Ensalada mixta con esparragos, aceitunas, huevos y atún',FALSE,FALSE,TRUE,FALSE,FALSE,180,16,8,8,5,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (88,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (73,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,37);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,37);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Hamburguesa de espinacas','Hamburguesa de espinacas',FALSE,FALSE,FALSE,FALSE,TRUE,226,23,12,14,7,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (1,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,38);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Espárragos trigueros a la plancha','',FALSE,TRUE,TRUE,FALSE,FALSE,21,0,0,1,2,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,39);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,39);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (88,39);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Codillo de cerdo asado','',FALSE,FALSE,FALSE,FALSE,FALSE,199,13,9,11,17,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,40);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (89,40);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,40);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada César','Ensalada César con queso, pan y pechuga',FALSE,FALSE,FALSE,FALSE,TRUE,116,10,6,4,8,10);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (90,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (91,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,41);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Sopa de pollo','Sopa de pollo con puerro y zanahoria',FALSE,FALSE,FALSE,FALSE,FALSE,11,0,1,0,1,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (92,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (93,42);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Albóndigas con tomate','',FALSE,FALSE,FALSE,FALSE,TRUE,169,12,7,8,8,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (12,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (77,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,43);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Fabada','Fabada con chorizo, panceta y moriclla',FALSE,FALSE,FALSE,FALSE,FALSE,142,9,14,11,7,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (94,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (108,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (74,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (95,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (96,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,44);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Espirales con tomate','Espirales con tomate con pisto',FALSE,TRUE,TRUE,FALSE,FALSE,345,2,10,15,12,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (97,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,45);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Huevo frito con tomate','',FALSE,TRUE,TRUE,FALSE,FALSE,345,2,10,15,12,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,46);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,46);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,46);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,46);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Patatas con carne','Patatas con carne picada, cebolla y pimiento',FALSE,FALSE,FALSE,FALSE,FALSE,60,2,1,2,4,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (12,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,47);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Salmón al horno','Salmón al horno con patatas, pimiento verde cebolla y vino tinto',FALSE,FALSE,FALSE,FALSE,FALSE,227,16,15,14,22,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (98,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,48);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Escalivada de verduras','Escalivada de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,68,5,0,1,1,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (85,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,49);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Arroz con sepia','Arroz con sepia con pisto y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,101,2,9,11,4,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (99,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,50);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Filete de lomo al ajillo','Filete de cinta de lomo de cerdo al ajillo',FALSE,FALSE,FALSE,FALSE,FALSE,117,4,9,8,20,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (100,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,51);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Merluza en salsa verde','Merluza en rodajas con salsa verde',FALSE,FALSE,FALSE,FALSE,TRUE,133,8,14,10,15,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (101,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,52);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Filete de pavo','Filete de pavo a la plancha',FALSE,FALSE,FALSE,FALSE,FALSE,145,2,15,12,29,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (102,53);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,53);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,53);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,53);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Sopa de verduras','Sopa de verduras con tomate',FALSE,TRUE,TRUE,FALSE,FALSE,59,1,3,12,2,10);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (103,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,54);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Bacalao con tomate','Bacalao fresco o desalatado con tomate',FALSE,FALSE,FALSE,FALSE,FALSE,240,1,1,0,1,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (109,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,55);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Negrito rebozado','Negrito fileteado rebozado con huevos y pan',FALSE,FALSE,FALSE,FALSE,TRUE,240,1,1,0,1,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (104,56);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Rape al horno','Rape al horno con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,240,1,1,0,1,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (79,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,57);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Pure de verduras','Pure de verduras con cebolla, calabacín, cebolla yacelgas',FALSE,TRUE,TRUE,FALSE,FALSE,81,3,10,12,2,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (105,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,58);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Guisantes con jamón','Guisantes con jamón en tacos',FALSE,FALSE,FALSE,FALSE,FALSE,81,3,10,12,2,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,59);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada de alubias','Ensalada de alubias cocidas con pimiento asado',FALSE,TRUE,TRUE,FALSE,FALSE,81,3,10,12,2,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (93,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (106,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,60);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,60);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada de escabeche','Ensalada de escabeche con aceitunas, huevos cocidos y chicharro',FALSE,FALSE,FALSE,FALSE,FALSE,81,3,10,12,2,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (73,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (107,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,61);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,61);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada de pasta','Ensalada de pasta con tomate, queso, chicharro y jamón cocido',FALSE,FALSE,FALSE,FALSE,FALSE,189,9,8,8,7,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (97,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (56,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (107,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,62);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Ensalada de garbanzos','Ensalada de garbanzos cocidos, atún y aceitunas',FALSE,FALSE,FALSE,FALSE,FALSE,189,9,8,8,7,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (106,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (73,63);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Pizza jamón y bacon','Pizza jamon y bacon con tomate, queso, jamón y almidón',FALSE,FALSE,FALSE,FALSE,FALSE,258,10,11,14,11,31);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (45,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (33,64);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Vaso de leche con zumo de naranja','',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,8,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,65);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (110,65); 

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Cafe solo con zumo de naranja y tostada con mermelada de melocotón','',TRUE,TRUE,TRUE,FALSE,FALSE,2,0,0,0,0,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (110,66);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (116,66);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,66);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,66);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (115,66);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Cafe con leche con zumo de mango y tostada con mermelada de frambuesa','',TRUE,FALSE,TRUE,FALSE,FALSE,135,6,7,10,9,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (117,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (118,67);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Café cortado','',TRUE,FALSE,TRUE,FALSE,FALSE,28,2,1,1,2,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,68);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,68);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,68);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Té','',TRUE,FALSE,TRUE,FALSE,FALSE,2,0,0,0,0,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (119,69);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Menta poleo','',TRUE,FALSE,TRUE,FALSE,FALSE,0,0,0,0,0,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (120,70);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Vaso de leche con zumo de pomelo y tostada con mermelada de fresa','',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,8,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,71);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,71);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (121,71);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (122,71);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Vaso de leche con zumo de mango y tostada con mermelada de manzana','',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,8,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,72);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,72);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (117,72);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (123,72);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Vaso de leche con zumo de manzana y tostada con mermelada de melocoton','',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,8,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,73);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,73);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (116,73);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (124,73);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Cafe con leche con zumo de manzana y tostada con mermelada de melocoton','',TRUE,FALSE,TRUE,FALSE,FALSE,135,6,7,10,9,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (124,74);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (116,74);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,74);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,74);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,74);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Cafe cortado con zumo de piña y tostada con mermelada de fresa','',TRUE,FALSE,TRUE,FALSE,FALSE,28,2,1,1,2,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,75);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,75);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (111,75);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (122,75);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Menta poleo con zumo de piña y tostada con mermelada de fresa','',TRUE,FALSE,TRUE,FALSE,FALSE,0,0,0,0,0,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (111,76);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (122,76);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (120,76);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Menta poleo con con zumo de pomelo y tostada con mermelada de fresa','',TRUE,FALSE,TRUE,FALSE,FALSE,0,0,0,0,0,0);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (120,77);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (121,77);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (122,77);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Colacao','',TRUE,TRUE,TRUE,FALSE,FALSE,158,3,6,7,8,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,78);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (125,78);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Colacao y zumo de naranja con tostada de mermelada de frambuesa','',TRUE,TRUE,TRUE,FALSE,FALSE,158,3,6,7,8,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,79);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (125,79);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (113,79);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (118,79);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Vaso de leche con zumo de piña','',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,8,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,80);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (111,80);


insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,aminoacidos,proteinas,hidratosDeCarbono) Values ('Vaso de leche con zumo de melocoton','',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,8,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,81);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (112,81);

insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'lunes','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'lunes','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'lunes','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'lunes','cena');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'martes','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'martes','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'martes','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'martes','cena');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'miercoles','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'miercoles','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'miercoles','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'miercoles','cena');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'jueves','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'jueves','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'jueves','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'jueves','cena');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'viernes','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'viernes','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'viernes','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'viernes','cena');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'sabado','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'sabado','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'sabado','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'sabado','cena');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'domingo','desayuno');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'domingo','comidaPrimero');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'domingo','comidaSegundo');
insert into PlatoMenu (codigoDieta, diaSemana, momento) Values (1,'domingo','cena');

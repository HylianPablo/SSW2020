drop table if exists Huevo;
drop table if exists Cerdo;
drop table if exists Pescado;
drop table if exists Marisco;
drop table if exists Lactosa;
drop table if exists Hindu;
drop table if exists Cacahuete;
drop table if exists Soja;
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
	correo					char(40) unique not null,
	favorito				integer,
	codigoImg				integer,
	foreign key(favorito) references Dieta(codigoDieta),
	primary key(nombreUsuario)
);

create table Guardado(
	nombreUsuario					char(20) not null,
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
	lipidos					integer not null ,
	proteinas				integer not null,
	foto 					char(80),
	enlace					char(150),
	primary key(codigoPlato)
);

create table PlatoMenu(
	  codigoPlatoMenu      integer not null auto_increment,
	  codigoPlato        integer not null,
	  codigoDieta        integer,
	  diaSemana        char(20) not null,
	  check (diaSemana in ('lunes','martes','miércoles','jueves','viernes','sábado','domingo')),
	  momento          char(30) not null,
	  check (momento in ('desayuno','comidaPrimero','comidaSegundo','cena')),
	  foreign key(codigoPlato) references Plato(codigoPlato), 
	  foreign key(codigoDieta) references Dieta(codigoDieta),
	  primary key(codigoPlatoMenu)
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

create table Marisco(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Pescado(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Cerdo(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Lactosa(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Huevo(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Hindu(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Cacahuete(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

create table Soja(
	codigoIngrediente		integer not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	primary key(codigoIngrediente)
);

insert into Dieta (titulo,descripcion,fecha) Values ('Dieta mediterránea','Una dieta basada en la comida tradicional de la costa mediterránea.','2020-04-10');
insert into Dieta (titulo,descripcion,fecha) Values ('Dieta de deportistas','Una dieta orientada a personas que realizan mucho deporte a diario.','2020-03-01');
insert into Dieta (titulo,descripcion,fecha) Values ('Dieta vegeteriana','Una dieta que no lleva animales, salvo ovolácteos.','2018-01-01');


insert into Usuario (nombre,nombreUsuario,contrasena,correo,favorito) Values ('Pedro Sanz López', 'pedsanz', '12345pedro','pedrosanzl@gmail.com',1);
insert into Usuario (nombre,nombreUsuario,contrasena,correo,favorito) Values ('Marta Sanchez Rojo', 'martsanro', 'farola4','marta1912@gmail.com',2);
insert into Usuario (nombre,nombreUsuario,contrasena,correo,favorito) Values ('Marcos Moya Gallo', 'marmoyaga', 'tirabuzon89','marcos.mg@yahoo.com',3);

insert into Guardado (nombreUsuario,codigoDieta) Values ('pedsanz',1);
insert into Guardado (nombreUsuario,codigoDieta) Values ('pedsanz',2);
insert into Guardado (nombreUsuario,codigoDieta) Values ('martsanro',2);
insert into Guardado (nombreUsuario,codigoDieta) Values ('marmoyaga',3);


insert into Entrada (titulo,cuerpo,nombreUsuario,fecha) Values ('Quiero comer bien','Quiero tener una alimentación sana y no se cocinar.','pedsanz','2020-04-03');
insert into Entrada (titulo,cuerpo,nombreUsuario,fecha) Values ('Quiero ser vegana.','Me he dado cuenta de que los animales merecen vivir','martsanro','2020-03-23');
insert into Entrada (titulo,cuerpo,nombreUsuario,fecha) Values ('Receta de cupcakes.','Esta receta me la enseño mi abuela. Lleva harina y huevos.','marmoyaga','2020-03-08');


insert into Comentario (codigoPadre,cuerpo,nombreUsuario,fecha) Values (1,'Prueba a evitar demasiadas grasas saturadas y calorías vacías como las propocionadas por bebidas alcohólicas o la bollería industrial.','pedsanz','2020-04-05');
insert into Comentario (codigoPadre,cuerpo,nombreUsuario,fecha) Values (1,'El aguacate es un alimento muy sano, inclúyelo en tus platos.','marmoyaga','2020-04-06');
insert into Comentario (codigoPadre,cuerpo,nombreUsuario,fecha) Values (2,'No comas carne.','pedsanz','2020-03-25');

insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espinacas',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Garbanzos',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Aceite de oliva',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Ajos',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimentón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sal fina',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pez espada',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Limón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Romero',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Piñones',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Macarrones',TRUE,TRUE,FALSE,TRUE);
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
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mayonesa',TRUE,FALSE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Vinagre',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimienta negra',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa carbonara',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Agua',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Nata',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Queso',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espaguetis',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Costillas de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Almidón',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de limón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa barbacoa',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Leche entera',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Moras',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Frambuesas',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Arándanos',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Azúcar',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Melón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Jamón',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pan',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Atún',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Bacon',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Harina',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Berza',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Calabacín',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Judía',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Guisantes',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zanahoria',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Col',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Habas',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Alcachofa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Endivia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Nueces',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Queso azul',FALSE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Conejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Patata',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Laurel',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Perejil',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Setas',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Huevo',FALSE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Arroz',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Puerro',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Vino blanco',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de limón',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Brandy',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Tomillo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Ternera',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mantequilla',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Aceitunas',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Chorizo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lentejas',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de ternera',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pimienta blanca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lenguado',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Rape',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Gambas',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mejillones',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Marisco',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Solomillo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pepino',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Berenjena',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sal gruesa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lubina',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espárragos',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Codillo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa César',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Pechuga de pollo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Trozos de pollo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Fideos',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Alubias',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Tocino',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Morcilla',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Espirales',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salmón',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sepia',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de lomo de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Salsa verde',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Filete de pavo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Repollo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Negrito',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Acelgas',TRUE,TRUE,FALSE,FALSE);
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
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Té rojo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Menta poleo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de pomelo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mermelada de fresa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mermelada de manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Zumo de manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Cacao',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Galletas',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mantequilla de cacahuete',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Mango',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Sandía',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Lima',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Anchoa',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Aguacate',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Campurrinas',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Membrillo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Yogur',FALSE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Fresa',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Avena',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Ricota',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Tofu',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente (nombre,vegano,vegetariano,frutosSecos,gluten) Values ('Plátano',TRUE,TRUE,FALSE,FALSE);

insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Garbanzos con espinacas','Garbanzos de la huerta cocinados con espinaca y aceite de oliva',FALSE,TRUE,TRUE,FALSE,FALSE,140,2,200,25,12,'GarbanzosConEspinacas.jpg','https://www.laespanolaaceites.com/recetas/potaje-de-garbanzos/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Pez espada','Pez espada con limón y romero, marinado con piñones',FALSE,FALSE,FALSE,TRUE,FALSE,363,0,32,19,47,'PezEspada.jpg','https://www.cookforyourlife.org/es/recetas/pescado-horneado-con-limon-y-romero/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Macarrones a la boloñesa','Macarrones con carne picada, tomate y orégano',FALSE,FALSE,FALSE,FALSE,TRUE,306,3,205,25,24,'MacarronesALaBolonesa','https://cookpad.com/es/recetas/4486568-macarrones-con-carne-picada');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Sopa de pescado','Sopa de merluza con cebolla, pimiento verde, pimiento rojo, laurel y ajo',FALSE,FALSE,FALSE,FALSE,FALSE,228,0,32,18,46,'SopaDePescado.jpg','https://cookpad.com/es/recetas/5980657-sopa-de-pescado-al-estilo-de-mi-madre');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Filetes de pollo','Filetes de pollo al grill y tomate aliñado',FALSE,FALSE,FALSE,FALSE,FALSE,292,2,42,22,53,'FileteDePollo.jpg','https://cookpad.com/es/recetas/11522996-filetes-de-pechuga-de-pollo-al-grill-y-tomate-alinado');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Cóctel de langostinos','Cóctel de langostinos con palitos de cangrejo',FALSE,FALSE,FALSE,FALSE,FALSE,212,0,41,21,18,'CoctelDeLangostinos.jpg','https://www.pescanova.es/recetas/coctel-de-langostinos-y-palitos-de-mar');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Espaguetis a la carbonara','Espaguetis con salsa carbonara',FALSE,FALSE,FALSE,FALSE,TRUE,306,1,212,28,16,'EspaguetisDeSalsaCarbonara.jpg','https://www.lamansiondelasideas.com/cocina-facil-con-parmelia/espaguetis-salsa-carbonara/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Costillas','Costillas de cerdo a la barbacoa',FALSE,FALSE,FALSE,FALSE,FALSE,226,2,41,15,55,'CostillasDeCerdo.jpg','https://www.directoalpaladar.com/recetas-de-carnes-y-aves/bbq-ribs-new-york-la-receta-definitiva-de-costillas-de-cerdo-a-la-barbacoa');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Yogur de frutas del bosque','Yogur de frutas del bosque',TRUE,TRUE,TRUE,FALSE,TRUE,126,12,4,3,5,'YogurDeFrutasDelBosque.jpg','https://www.nooddle.es/receta/yogur-griego-con-frutos-del-bosque');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Melón con jamón','Melón con jamón',FALSE,FALSE,FALSE,FALSE,TRUE,150,8,2,4,10,'MelonConJamon.jpg','https://okdiario.com/recetas/carpaccio-melon-jamon-605');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Baguettes de atún y bacon','Baguettes de atún y bacon',FALSE,FALSE,FALSE,FALSE,TRUE,275,2,33,27,47,'BaguettesDeAtunYBacon.jpg','http://www.annarecetasfaciles.com/2017/04/paninis-caseros-pizza-rapida-de-pan.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Lasaña Boloñesa','Lasaña Boloñesa con carne de cerdo',FALSE,FALSE,FALSE,FALSE,TRUE,280,0,208,24,24,'LasanaBolonesa.jpg','https://www.recetasdesbieta.com/lasagna-original/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Berza cocida','Berza cocida con aceite, ajo y pimentón',FALSE,TRUE,TRUE,FALSE,FALSE,60,1,204,21,9,'BerzaCocida.jpg','https://cocinandofacilcon.blogspot.com/2017/12/berza-cocida-col.html?view=classic');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Potaje de garbanzos','Potaje de garbanzos con verduras',FALSE,TRUE,TRUE,FALSE,FALSE,269,4,212,23,11,'PotajeDeGarbanzos.jpg','https://www.recetasdeescandalo.com/potaje-de-garbanzos-con-verduras-facil-y-rico/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Menestra','Menestra de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,144,0,180,18,9,'Menestra.jpg','https://www.directoalpaladar.com/recetas-de-legumbres-y-verduras/menestra-verduras-tradicional-receta-toda-vida-que-vegana');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada de endivias','Ensalada de endivias con manzana, queso azul cebolla y nueces',FALSE,TRUE,TRUE,TRUE,FALSE,150,8,40,4,20,'EnsaladaDeEndividas.jpg','https://www.dietfarma.com/receta/ensalada-de-endivias-con-nueces-manzana-y-queso-fresco');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Conejo guisado','Conejo guisado con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,TRUE,272,0,120,10,56,'ConejoGuisadoConPatatas.jpg','https://cookpad.com/es/recetas/6731522-conejo-guisado-con-patatas');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Guisantes con jamón','Guisantes con jamón con ajo, cebolla y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,310,1,45,9,43,'GuisantesConJamon.jpg','https://cookpad.com/es/recetas/97244-guisantes-con-jamon');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Revuelto de setas','Revuelto de setas con huevos y ajo',FALSE,FALSE,TRUE,FALSE,FALSE,92,2,140,8,23,'RevueltoDeSetas.jpg','https://cookpad.com/es/recetas/104468-huevos-revueltos-con-setas-y-ajos-tiernos');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Arroz frito','Arroz frito con zanahoria, puerro y cebolla',FALSE,TRUE,TRUE,FALSE,FALSE,333,2,170,7,37,'ArrozFrito.jpg','https://www.elespanol.com/cocinillas/recetas/microondas/20160122/arroz-frito-rapido-receta-paso/1000386011396_30.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Merluza al horno','Merluza al horno con cebolla, ajo, vino blanco, zumo de limon, pimentón y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,264,0,30,8,52,'MerluzaAlHorno.jpg','https://www.directoalpaladar.com/recetas-de-pescados-y-mariscos/merluza-al-horno-ajada-al-limon-receta-facil-rapida');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ternera asada','Ternera asada con pimiento rojo, cebolla, ajo, zanahorias, brandy, tomillo y patatas',FALSE,FALSE,FALSE,FALSE,FALSE,227,0,28,15,58,'TerneraAsada.jpg','https://www.recetasderechupete.com/carne-asada-en-cazuela-receta-a-la-gallega/22512/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Puré de patata','Puré de patata con mantequilla y leche entera',FALSE,TRUE,TRUE,FALSE,TRUE,260,8,200,7,8,'PureDePatata.jpg','https://www.recetasderechupete.com/como-preparar-el-mejor-pure-de-patata/14328/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Tortilla francesa','Tortilla francesa',FALSE,FALSE,TRUE,FALSE,FALSE,126,1,70,10,38,'TortillaFrancesa.jpg','https://www.hogarmania.com/cocina/recetas/huevos/tortilla-francesa-8688.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensaladilla rusa','Ensaladilla rusa con patatas, zanahorias, huevos, aceitunas y atún',FALSE,FALSE,TRUE,FALSE,FALSE,194,4,157,13,35,'EnsaladillaRusa.jpg','https://www.hogarmania.com/cocina/recetas/ensaladas-verduras/ensaladilla-rusa-3145.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Lentejas','Lentejas con chorizo, cebolla, patatas, zanahorias, ajo y aceite',FALSE,FALSE,FALSE,FALSE,FALSE,178,1,170,18,46,'LentejasConChorizo.jpg','http://www.recetasparatres.com/2015/09/lentejas-con-chorizo.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Filete de ternera','Filete de ternera a la plancha',FALSE,FALSE,FALSE,FALSE,FALSE,318,0,27,12,58,'FileteDeTernera.jpg','https://www.gallinablanca.es/recetas/filetes-de-ternera-empanados/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Lenguado al horno','Lenguado al horno con harina, limón, pimienta blanca y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,346,1,28,10,55,'LenguadoAlHorno.jpg','https://lenguadoalhorno.com/con-limon/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Tortilla de patata','Tortilla de patata con cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,266,2,35,16,37,'TortillaDePatataConCebolla.jpg','https://cocina-familiar.com/tortilla-de-patata-con-cebolla.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Crema calabacín','Crema calabacín con patatas, cebolla y ajo',FALSE,TRUE,TRUE,FALSE,FALSE,169,3,156,7,12,'CremaDeCalabacinYPatata.jpg','https://cremacalabacin.com/crema-calabacin-patata/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Paella de marisco','Paella de marisco con arroz, rape, gambas y mejillones',FALSE,FALSE,FALSE,FALSE,FALSE,343,2,193,13,59,'PaellaDeMarisco.jpg','https://www.hogarmania.com/cocina/recetas/arroces-cereales/paella-pescado-marisco-33253.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Solomillo de cerdo','Solomillo de cerdo con arroz',FALSE,FALSE,FALSE,FALSE,FALSE,222,2,28,13,57,'SolomilloDeCerdo.jpg','http://wikicocina.com/recetas/carnes/solomillo-de-cerdo-char-siu-con-arroz-frito-chino');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Gazpacho','Gazpacho con pimiento verde y pepino',FALSE,TRUE,TRUE,FALSE,FALSE,110,6,160,7,28,'Gazpacho.jpg','https://www.miarevista.es/cocina/cremas/receta/gazpacho-andaluz');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Berenjenas en escabeche','Berenjenas en escabeche',FALSE,TRUE,TRUE,FALSE,FALSE,98,5,140,4,9,'BerenjenasEnEscabeche.jpg','https://elcomidista.elpais.com/elcomidista/2013/10/10/articulo/1381381200_138138.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Lubina al horno','Lubina al horno con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,220,0,28,7,52,'LubinaAlHorno.jpg','https://www.hogarmania.com/cocina/recetas/pescados-mariscos/lubina-horno-patatas-9378.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Espaguetis con calabacín','Espaguetis de calabacín con gambas',FALSE,FALSE,FALSE,FALSE,FALSE,176,1,180,11,25,'EspaguetisDeCalabacin.jpg','https://www.antena3.com/programas/karlos-arguinano/recetas/pasta/espaguetis-calabacin-gambas_201910235db03cad0cf252ab407b1b3c.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada mixta','Ensalada mixta con espárragos, aceitunas, huevos y atún',FALSE,FALSE,TRUE,FALSE,FALSE,135,2,80,8,7,'EnsaladaMixtaConEsparragos.jpg','https://estoyhechouncocinillas.com/2009/09/ensalada-mixta-del-cocinillas.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Hamburguesa de espinacas','Hamburguesa de espinacas con arroz y tomate',FALSE,FALSE,TRUE,FALSE,TRUE,248,3,180,15,23,'HamburguesasDeEspinacas.jpg','https://www.miscosillasdecocina.com/2014/06/hamburguesas-de-arroz-y-espinacas.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Espárragos trigueros a la plancha','Espárragos trigueros a la plancha complementado con flan de tomate',FALSE,TRUE,TRUE,FALSE,FALSE,21,2,70,7,9,'EsparragosTrigueros.jpg','https://www.velocidadcuchara.com/esparragos-la-plancha-con-flan-de-tomate/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Codillo de cerdo asado','Codillo de cerdo asado',FALSE,FALSE,FALSE,FALSE,FALSE,199,3,32,23,57,'CodilloDeCerdoAsado.jpg','https://www.comedera.com/codillo-al-horno-asado/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada César','Ensalada César con pollo, queso, pan y pechuga',FALSE,FALSE,FALSE,FALSE,TRUE,116,10,133,7,8,'EnsaladaCesar.jpg','https://ensaladacesar.info/ensalada-cesar-con-pollo/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Sopa de pollo','Sopa de pollo con puerro y zanahoria',FALSE,FALSE,FALSE,FALSE,FALSE,11,0,152,12,21,'CaldoPolloConVerduras.jpg','https://www.lecturas.com/recetas/caldo-pollo-verduras_3409.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Albóndigas con tomate','Albóndigas con tomate',FALSE,FALSE,FALSE,FALSE,TRUE,169,12,42,24,48,'AlbóndigasConTomate.jpg','https://www.thermorecetas.com/albondigas-tomate-clasico/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Fabada','Fabada con chorizo, panceta y morcilla',FALSE,FALSE,FALSE,FALSE,FALSE,142,9,14,11,33,'Fabada.jpg','https://recetinas.com/alubias-blancas-con-chorizo-morcilla-y-panceta/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Espirales de pisto','Espirales de pisto con tomate',FALSE,TRUE,TRUE,FALSE,FALSE,345,4,178,17,28,'EnsaladaDePistoConTomate.jpg','https://www.bezzia.com/espirales-pasta-verduras-salsa-pisto/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Huevo frito con tomate','Huevo frito con tomate',FALSE,TRUE,TRUE,FALSE,FALSE,345,4,40,19,47,'ArrozConTomateYHuevo.jpg','https://cocinayrecetas.hola.com/calamaresensutinta/20111014/arroz-con-tomate-y-huevo/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Patatas con carne','Patatas con carne picada, cebolla y pimiento',FALSE,FALSE,FALSE,FALSE,FALSE,60,7,56,14,54,'PatatasConCarnePicada.jpg','https://www.antena3.com/programas/karlos-arguinano/recetas/carnes/pastel-familiar-de-carne-de-karlos-arguinano_202003305e81b7e295e62a0001c698e8.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Salmón al horno','Salmón al horno con patatas, pimiento verde cebolla y vino tinto',FALSE,FALSE,FALSE,FALSE,FALSE,227,16,56,11,52,'SalmonAlHorno.jpg','https://comida.uncomo.com/receta/como-hacer-salmon-al-horno-con-patatas-41665.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Escalivada de verduras','Escalivada de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,68,2,140,7,9,'EscaviladaDeVerduras.jpg','https://www.cocinatis.com/receta/escalivada-de-verduras-asadas');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Arroz con sepia','Arroz con sepia con pisto y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,101,7,50,16,30,'ArrozConSepia.jpg','https://okdiario.com/recetas/arroz-sepia-2405298');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Filete de lomo al ajillo','Filete de cinta de lomo de cerdo al ajillo',FALSE,FALSE,FALSE,FALSE,FALSE,117,19,49,17,58,'FileteDeLomoDeCerdo.jpg','http://cocineraymadre.com/2018/03/28/lomo-de-cerdo-al-ajillo/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Merluza en salsa verde','Merluza en rodajas con salsa verde',FALSE,FALSE,FALSE,FALSE,TRUE,133,4,44,13,48,'MerluzaEnSalsaVerde.jpg','https://www.todoreceta.com/merluza-en-salsa-verde/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Filete de pavo','Filete de pavo a la plancha',FALSE,FALSE,FALSE,FALSE,FALSE,145,3,41,15,47,'FileteDePavoALaPlancha.jpg','https://www.dietfarma.com/receta/pechuga-de-pavo-la-plancha');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Sopa de verduras','Sopa de tortellini y verduras con tomate',FALSE,TRUE,TRUE,FALSE,FALSE,59,2,150,11,33,'SopaDeTortelliniYVerduras.jpg','https://www.hola.com/cocina/recetas/20190125136076/receta-sopa-verdura-tomate-cs/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Bacalao con tomate','Bacalao fresco o desalatado con tomate',FALSE,FALSE,FALSE,FALSE,FALSE,240,4,53,17,48,'BacalaoFrescoConTomate.jpg','https://www.recetasdeescandalo.com/bacalao-con-tomate-receta-tradicional-muy-facil-y-rica/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Negrito rebozado','Negrito fileteado rebozado con huevos y pan',FALSE,FALSE,FALSE,FALSE,TRUE,240,2,48,13,54,'NegritoRebozado.jpg','https://www.recetasgratis.net/receta-de-pescado-rebozado-crujiente-paso-a-paso-60779.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Rape al horno','Rape al horno con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,FALSE,240,1,47,12,53,'RapeAlHorno.jpg','https://www.hogarmania.com/cocina/recetas/pescados-mariscos/rape-horno-784.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Puré de verduras','Puré de verduras con cebolla, calabacín, cebolla y acelgas',FALSE,TRUE,TRUE,FALSE,FALSE,81,2,183,7,8,'PureDeVerduras.jpg','https://hoycomemossano.com/2013/10/pure-de-verduras-calabacin-vainas-y.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Guisantes con jamón','Guisantes con jamón en tacos',FALSE,FALSE,FALSE,FALSE,FALSE,81,3,163,9,27,'GuisantesConJamonEnTacos.jpg','https://cookpad.com/es/recetas/1971681-guisantes-con-jamon');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada de alubias','Ensalada de alubias cocidas con pimiento asado',FALSE,TRUE,TRUE,FALSE,FALSE,85,1,90,12,9,'EnsaladaDeAlubiasBlancas.jpg','https://www.comedera.com/ensalada-de-judias-blancas/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada de escabeche','Ensalada de escabeche con aceitunas, huevos cocidos y chicharro',FALSE,FALSE,FALSE,FALSE,FALSE,81,3,100,10,10,'EnsaladaDeEscabecheConChicharro.jpg','https://ensaladistas.com/receta/ensalada-de-chicharro-en-escabeche-con-granada-y-aceitunas/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada de pasta','Ensalada de pasta con tomate, queso, chicharro y jamón cocido',FALSE,FALSE,FALSE,FALSE,FALSE,189,2,87,11,11,'EnsaladaDePastaConTomate.jpg','http://eltoquedeelena.blogspot.com/2016/07/ensalada-de-pasta-con-mayonesa-al-curry.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Ensalada de garbanzos','Ensalada de garbanzos cocidos, atún y aceitunas',FALSE,FALSE,FALSE,FALSE,FALSE,189,2,93,8,8,'EnsaladaDeGarbanzos.jpg','https://cookpad.com/gt/recetas/10093567-ensalada-de-garbanzos-con-atun');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Pizza de jamón y bacon','Pizza de jamón y bacon con tomate, queso y almidón',FALSE,FALSE,FALSE,FALSE,FALSE,258,2,57,16,45,'PizzaConJamon.jpg','http://www.lacocinaderebeca.es/2011/11/pizza-de-jamon-york-y-bacon.html');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Vaso de leche con cacao y galletas','Vaso de leche con cacao puro y galletas integrales',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,80,7,10,'VasoDeLecheConGalletas.jpg','https://www.directoalpaladar.com/postres/galletas-integrales-avena-italianas-receta-vegana-para-desayuno-merienda');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Gachas de plátano','Gachas con plátano fresco y mantequilla de cacahuete con copos de avena',TRUE,FALSE,TRUE,TRUE,FALSE,147,2,53,14,8,'GachasDePlatanoYMantequillaDeCacahuete.jpg','https://www.hsnstore.com/blog/gachas-de-avena-con-mantequilla-de-cacahuete/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Zumo de mango y tostada','Zumo de mango y tostada con mermelada de frambuesa',TRUE,TRUE,TRUE,FALSE,TRUE,135,6,78,8,9,'ZumoYTostadaConMermeladaDeFrambuesa.jpg','https://www.kiwilimon.com/receta/postres/postres-con-frutas/pan-tostado-con-mermelada-de-fresa');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Sandía aliñada con lima','Sandía aliñada con lima y azúcar moreno',TRUE,TRUE,TRUE,FALSE,FALSE,28,1,100,11,15,'SandiaAlinadaConLima.jpg','https://alimentarte.net/sandia-alinada-con-lima-y-pimienta-el-postre-del-verano/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Hummus y crudités','Hummus de garbanzos con palitos de zanahoria',TRUE,TRUE,TRUE,FALSE,FALSE,143,1,170,10,31,'HummusDeGarbanzosConPalitosDeZanahoria.jpg','https://www.kiwilimon.com/receta/botanas/dips/zanahoria-con-hummus-de-garbanzo');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Tostadas de anchoa y tomate','Tostadas de tomate triturado con anchoas',TRUE,FALSE,FALSE,FALSE,FALSE,102,7,87,14,9,'Tostadas de anchoa y tomate.jpg','http://www.laguita.com/vivaelpicoteo/index.php?option=com_k2&view=item&id=119:pan-tostado-con-fritada-de-tomates-y-anchoas-ahumadas&Itemid=190&lang=es');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Huevos y aguacate','Huevos revueltos con aguacate',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,67,10,8,'HuevosRevuletosConAguacate.jpg','https://www.hatcook.com/receta/huevos-revueltos-con-aguacate');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Café y campurrianas','Café con pastas tradicionales',TRUE,FALSE,TRUE,FALSE,FALSE,110,8,77,10,8,'CafeConPastasTradicionales.jpg','https://www.hola.com/cocina/escuela/2011031851643/receta/pastas/caseras/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Queso con membrillo','Queso fresco con membrillo y pan',TRUE,FALSE,TRUE,FALSE,TRUE,146,8,57,10,8,'QuesoFrescoConMembrilloYPan.jpg','http://www.demoslavueltaaldia.com/receta/tosta-de-membrillo-queso-fresco-y-avellanas');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Tostadas con aceite y tomate','Tostadas de aceite de oliva y sal con tomate',TRUE,TRUE,TRUE,FALSE,TRUE,135,6,47,10,11,'TostadasDeTomateConAceite','https://blogosferathermomix.es/trucosdecocinathermomix/2019/08/02/tomate-rallado/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Bizcocho de zanahoria y café','Bizcocho tradicional de zanahoria Y café cortado',TRUE,FALSE,TRUE,FALSE,FALSE,98,2,51,4,12,'BizcochoDeZanahoriaYCafe.jpg','https://www.hola.com/cocina/recetas/20191120154517/bizcocho-de-zanahoria/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Yogur con fresas','Yogur con fresas y copos de avena',TRUE,FALSE,TRUE,FALSE,FALSE,67,0,0,3,11,'YogurConFresasYCoposDeAvena.jpg','https://recetas.lidl.es/Receta/Batido-de-fresa-con-yogur-y-avena');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Batido de espinacas y aguacate','Batido de espinacas, aguacate y leche',TRUE,FALSE,TRUE,FALSE,FALSE,75,4,42,5,14,'BatidoDeEspinacasConAguacate.jpg','https://cocinandoconciencias.com/batido-de-espinacas-con-aguacate/');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Baguel de salmón','Baguel de salmón con ricota',TRUE,FALSE,FALSE,FALSE,TRUE,158,3,6,7,9,'BagelDeSalmonYRicotta.jpg','https://www.nooddle.es/receta/bagel-de-salmon-ahumado-y-ricotta');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Pan de leche con mantequilla','Bollo tradicional de leche con mantequilla',TRUE,FALSE,TRUE,FALSE,FALSE,158,3,6,7,13,'BolloTradicional.jpg','https://canalcocina.es/receta/bollitos-de-leche-dulces');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Tortitas de avena y yogur','Tortillas de avena acompañadas de yogur',TRUE,FALSE,TRUE,FALSE,FALSE,146,8,7,10,14,'TortitasDeAvenaYYogur.jpg','https://www.nooddle.es/receta/tortitas-de-avena-y-yogur-griego');
insert into Plato (nombre,descripcion,desayuno,vegano,vegetariano,frutosSecos,gluten,kcal,glucidosSimples,polisacaridos,lipidos,proteinas,foto,enlace) Values ('Sándwich vegetal','Sándwich de tomate, lechuga y tofu',TRUE,TRUE,TRUE,FALSE,TRUE,146,8,7,10,15,'SandwichVegetal.jpg','https://www.hazteveg.com/receta/1398/Sandwich-con-tofu');


insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (1,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,1);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,1);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (7,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (8,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (9,2);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (10,2);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (11,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (12,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,3);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (14,3);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,4);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (115,4);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,5);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,5);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (19,5);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (20,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (21,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (22,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (24,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,6);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,6);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (27,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (29,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,7);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (31,7);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (32,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (33,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (34,8);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (35,8);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (33,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (37,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (38,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (39,9);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (40,9);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (41,10);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,10);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,11);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (45,11);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (40,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (47,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,12);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,12);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,13);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,13);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,14);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,14);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (49,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (52,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (53,15);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (54,15);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (55,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (56,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (57,16);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (58,16);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (59,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,17);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,17);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,18);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,18);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (63,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,19);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,19);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,20);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,20);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (68,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,21);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,21);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (69,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (70,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (71,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,22);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,22);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,23);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (72,23);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,23);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,23);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,24);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,24);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,24);

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

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (74,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (75,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,26);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,26);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (76,27);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,27);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,27);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (77,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (78,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (8,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,28);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,28);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,29);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,29);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,29);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,29);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,30);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,30);

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

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (83,32);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,32);
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

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (84,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,33);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,33);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (85,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,34);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (14,34);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (87,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,35);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,35);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (31,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (80,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,36);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,36);

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

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (1,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,38);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,38);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,39);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,39);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (88,39);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,40);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (89,40);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,40);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (90,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (91,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,41);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,41);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (92,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (93,42);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (115,42);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (12,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (77,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,43);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,43);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (94,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (108,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (74,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (95,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (96,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,44);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,44);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (97,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,45);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,45);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,46);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,46);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,46);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,46);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (12,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,47);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,47);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (98,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,48);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,48);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (85,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,49);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,49);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (65,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (99,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (17,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (18,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,50);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,50);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (100,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (61,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (28,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,51);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,51);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (101,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (15,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,52);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,52);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (102,53);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,53);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,53);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,53);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (103,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (5,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,54);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (115,54);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (109,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,55);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,55);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,56);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (104,56);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (79,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (25,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,57);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (62,57);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (66,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (48,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (105,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (67,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,58);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,58);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (50,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (4,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,59);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (26,59);

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

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (97,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (56,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (60,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (107,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,62);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,62);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (16,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (106,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (44,63);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (73,63);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (46,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (42,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (45,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (6,64);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (33,64);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,65);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (125,65); 
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (126,65); 

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (127,66);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (140,66);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (128,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,67);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (118,67);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (130,68);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (129,68);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (2,69);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,69);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,70);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (131,70);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,70);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,71);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (132,71);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,72);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (133,72);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (30,73);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (134,73);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,73);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,74);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,74);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (3,74);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (114,75);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (51,75);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (64,75);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (135,76);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (136,76);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (137,76);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (1,77);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,77);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (132,77);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,78);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (98,78);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (138,78);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,79);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (36,79);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (72,79);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (135,80);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (137,80);

insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (43,81);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (13,81);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (23,81);
insert into PertenenciaPlato (codigoIngrediente,codigoPlato) Values (139,81);



insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (65,1,'lunes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (1,1,'lunes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (2,1,'lunes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (3,1,'lunes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (66,1,'martes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (4,1,'martes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (5,1,'martes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (6,1,'martes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (67,1,'miercoles','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (7,1,'miercoles','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (8,1,'miercoles','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (9,1,'miercoles','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (68,1,'jueves','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (10,1,'jueves','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (11,1,'jueves','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (12,1,'jueves','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (69,1,'viernes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (13,1,'viernes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (14,1,'viernes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (15,1,'viernes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (70,1,'sabado','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (16,1,'sabado','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (17,1,'sabado','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (18,1,'sabado','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (71,1,'domingo','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (19,1,'domingo','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (20,1,'domingo','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (21,1,'domingo','cena');

insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (72,2,'lunes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (22,2,'lunes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (23,2,'lunes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (24,2,'lunes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (73,2,'martes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (25,2,'martes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (26,2,'martes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (27,2,'martes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (74,2,'miercoles','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (28,2,'miercoles','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (29,2,'miercoles','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (30,2,'miercoles','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (75,2,'jueves','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (31,2,'jueves','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (32,2,'jueves','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (33,2,'jueves','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (76,2,'viernes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (34,2,'viernes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (35,2,'viernes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (36,2,'viernes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (77,2,'sabado','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (37,2,'sabado','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (38,2,'sabado','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (39,2,'sabado','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (78,2,'domingo','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (40,2,'domingo','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (41,2,'domingo','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (42,2,'domingo','cena');

insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (80,3,'lunes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (1,3,'lunes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (23,3,'lunes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (24,3,'lunes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (76,3,'martes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (25,3,'martes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (30,3,'martes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (10,3,'martes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (79,3,'miercoles','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (33,3,'miercoles','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (38,3,'miercoles','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (29,3,'miercoles','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (75,3,'jueves','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (45,3,'jueves','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (58,3,'jueves','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (39,3,'jueves','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (77,3,'viernes','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (54,3,'viernes','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (49,3,'viernes','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (60,3,'viernes','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (74,3,'sabado','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (34,3,'sabado','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (81,3,'sabado','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (61,3,'sabado','cena');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (72,3,'domingo','desayuno');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (37,3,'domingo','comidaPrimero');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (46,3,'domingo','comidaSegundo');
insert into PlatoMenu (codigoPlato, codigoDieta, diaSemana, momento) Values (63,3,'domingo','cena');


insert into Marisco (codigoIngrediente) Values (20);
insert into Marisco (codigoIngrediente) Values (21);
insert into Marisco (codigoIngrediente) Values (80);
insert into Marisco (codigoIngrediente) Values (81);
insert into Marisco (codigoIngrediente) Values (82);


insert into Pescado (codigoIngrediente) Values (7);
insert into Pescado (codigoIngrediente) Values (15);
insert into Pescado (codigoIngrediente) Values (44);
insert into Pescado (codigoIngrediente) Values (78);
insert into Pescado (codigoIngrediente) Values (79);
insert into Pescado (codigoIngrediente) Values (87);
insert into Pescado (codigoIngrediente) Values (98);
insert into Pescado (codigoIngrediente) Values (104);
insert into Pescado (codigoIngrediente) Values (109);
insert into Pescado (codigoIngrediente) Values (132);


insert into Cerdo (codigoIngrediente) Values (32);
insert into Cerdo (codigoIngrediente) Values (35);
insert into Cerdo (codigoIngrediente) Values (42);
insert into Cerdo (codigoIngrediente) Values (45);
insert into Cerdo (codigoIngrediente) Values (74);
insert into Cerdo (codigoIngrediente) Values (83);
insert into Cerdo (codigoIngrediente) Values (89);
insert into Cerdo (codigoIngrediente) Values (95);
insert into Cerdo (codigoIngrediente) Values (96);
insert into Cerdo (codigoIngrediente) Values (100);
insert into Cerdo (codigoIngrediente) Values (107);
insert into Cerdo (codigoIngrediente) Values (108);
insert into Cerdo (codigoIngrediente) Values (27);
insert into Cerdo (codigoIngrediente) Values (12);
insert into Cerdo (codigoIngrediente) Values (113);
insert into Cerdo (codigoIngrediente) Values (92);


insert into Lactosa (codigoIngrediente) Values (27);
insert into Lactosa (codigoIngrediente) Values (29);
insert into Lactosa (codigoIngrediente) Values (58);
insert into Lactosa (codigoIngrediente) Values (30);
insert into Lactosa (codigoIngrediente) Values (72);
insert into Lactosa (codigoIngrediente) Values (90);


insert into Huevo (codigoIngrediente) Values (64);
insert into Huevo (codigoIngrediente) Values (24);
insert into Huevo (codigoIngrediente) Values (27);


insert into Hindu (codigoIngrediente) Values (12);
insert into Hindu (codigoIngrediente) Values (27);
insert into Hindu (codigoIngrediente) Values (71);
insert into Hindu (codigoIngrediente) Values (76);


insert into Soja (codigoIngrediente) Values (138);


insert into Cacahuete (codigoIngrediente) Values (128);

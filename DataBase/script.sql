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
	codigoDieta	char(20) not null,
	titulo		char(20) not null,
	descripcion	text not null,
	fecha		date not null,
	primary key(codigoDieta)
);

create table Usuario(
	nombre					char(50) not null,
	nombreUsuario				char(20) not null,
	contrasena				char(20) not null,
	correo					char(40) not null,
	favorito				char(20),
	foreign key(favorito) references Dieta(codigoDieta),
	primary key(nombreUsuario)
);


create table Guardado(
	nombreUsuario				char(20) not null,
	codigoDieta				char(20) not null,
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	foreign key(codigoDieta) references Dieta(codigoDieta),
	primary key(nombreUsuario, codigoDieta)
);

create table Entrada(
	codigoEntrada				char(20) not null,
	titulo					char(50) not null,
	cuerpo					text,
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	primary key(codigoEntrada)
);

create table Comentario(
	codigoComentario			char(20) not null,
	codigoPadre				char(20) not null,
	cuerpo					text not null,
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(codigoPadre) references Entrada(codigoEntrada),
	foreign key(nombreUsuario) references Usuario(nombreUsuario),
	primary key(codigoComentario)
);	

create table Plato(
	codigoPlato 				char(20) not null,
	nombre					char(30) not null,
	descripcion				text,
	desayuno				boolean not null,
	vegano					boolean not null,
	vegetariano				boolean not null,
	frutosSecos				boolean not null,
	gluten					boolean not null,
	kcal					integer not null,
	glucidosSimples				integer not null,
	polisacaridos 				integer not null,
	aminoacidos				integer not null,
	proteinas				integer not null,
	hidratosDeCarbono			integer not null,
	primary key(codigoPlato)
);

create table PlatoMenu(
	codigoPlato				char(20) not null,
	codigoDieta				char(20) not null,
	diaSemana				char(20) not null,
	check (diaSemana in ('lunes','martes','miercoles','jueves','viernes','sabado','domingo')),
	momento					char(30) not null,
	check (momento in ('desayuno','comidaPrimero','comidaSegundo','cena')),
	foreign key(codigoPlato) references Plato(codigoPlato), 
	foreign key(codigoDieta) references Dieta(codigoDieta),
	primary key(codigoPlato, codigoDieta)
);

create table Ingrediente(
	codigoIngrediente			char(20) not null,
	nombre 					char(30) not null,
	vegano 					boolean	 not null,
	vegetariano				boolean  not null,
	frutosSecos         			boolean  not null,
	gluten		         		boolean  not null,
	primary key(codigoIngrediente)
);

create table PertenenciaPlato(
	codigoIngrediente		char(20) not null,
	codigoPlato 			char(20) not null,
	foreign key(codigoIngrediente) references Ingrediente(codigoIngrediente),
	foreign key(codigoPlato) references Plato(codigoPlato),
	primary key(codigoIngrediente, codigoPlato)
);

insert into Dieta Values ('00000000','Dieta vegeteriana','Una dieta que no lleva animales, salvo ovolácteos','2018-01-01');
insert into Dieta Values ('00000001','Dieta mediterranea','Una dieta basada en la comida tradicional de la costa mediterranea','2020-04-10');
insert into Dieta Values ('00000002','Dieta de deportistas','Una dieta orientada a personas que realizan mucho deporte a diario','2020-03-01');

insert into Usuario Values ('Pedro Sanz Lopez', 'pedsanz', '12345pedro','pedrosanzl@gmail.com','00000000');
insert into Usuario Values ('Marta Sanchez Rojo', 'martsanro', 'farola4','marta1912@gmail.com','00000000');
insert into Usuario Values ('Marcos Moya Gallo', 'marmoyaga', 'tirabuzon89','marcos.mg@yahoo.com','00000000');

insert into Guardado Values ('pedsanz','00000000');
insert into Guardado Values ('martsanro','00000000');
insert into Guardado Values ('marmoyaga','00000000');

insert into Entrada Values ('00000','Quiero comer bien','Quiero tener una alimentacion sana y no se cocinar','pedsanz','2020-04-03');
insert into Entrada Values ('00001','Quiero ser vegana',NULL,'martsanro','2020-03-23');
insert into Entrada Values ('00002','Receta de cupcakes','Esta receta me la enseño mi abuela. Lleva harina y huevos','marmoyaga','2020-03-08');

insert into Comentario Values ('00000','00000','Prueba a no comer bollos','marmoyaga','2020-04-05');
insert into Comentario Values ('00001','00000','El aguacate es un alimento muy sano, incluyelo en tus platos','marmoyaga','2020-04-06');
insert into Comentario Values ('00002','00001','No comas carne','pedsanz','2020-03-25');

insert into Plato Values ('00000000','Garbanzos con espinacas','Garbanzos de la huerta cocinados con espinaca y aceite de oliva',FALSE,TRUE,TRUE,FALSE,FALSE,350,10,10,10,50,20);
insert into Ingrediente Values('00000001','Espinaca',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000002','Garbanzo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000003','Aceite de oliva',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000004','Ajo',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000005','Pimenton',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000006','Sal',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000001','00000000');
insert into PertenenciaPlato Values('00000002','00000000');
insert into PertenenciaPlato Values('00000003','00000000');
insert into PertenenciaPlato Values('00000004','00000000');
insert into PertenenciaPlato Values('00000005','00000000');
insert into PertenenciaPlato Values('00000006','00000000');


insert into Plato Values ('00000001','Pez espada','Pez espada con limón y romero, marinado con piñones',FALSE,FALSE,FALSE,TRUE,FALSE,280,10,20,30,20,20);
insert into Ingrediente Values('00000007','Pez espada',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000008','Limon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000009','Romero',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000010','Piñones',TRUE,TRUE,TRUE,FALSE); 
insert into PertenenciaPlato Values('00000006','00000001');
insert into PertenenciaPlato Values('00000007','00000001');
insert into PertenenciaPlato Values('00000008','00000001');
insert into PertenenciaPlato Values('00000009','00000001');
insert into PertenenciaPlato Values('00000010','00000001');



insert into Plato Values ('00000002','Macarrones a la boloñesa','Macarrones con carne picada, tomate y oregano',FALSE,FALSE,FALSE,FALSE,TRUE,400,10,10,10,10,60);
insert into Ingrediente Values('00000011','Macarron',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente Values('00000012','Carne picada',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente Values('00000013','Tomate',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000014','Oregano',TRUE,TRUE,FALSE,TRUE);
insert into PertenenciaPlato Values('00000006','00000002');
insert into PertenenciaPlato Values('00000011','00000002');
insert into PertenenciaPlato Values('00000012','00000002');
insert into PertenenciaPlato Values('00000013','00000002');
insert into PertenenciaPlato Values('00000014','00000002');


insert into Plato Values ('00000003','Sopa de pescado','Sopa de merluza con cebolla, pimiento verde, pimiento rojo, laurel y ajo',FALSE,FALSE,FALSE,FALSE,FALSE,100,10,15,20,18,60);
insert into Ingrediente Values('00000015','Merluza',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000016','Cebolla',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000017','Pimiento verde',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000018','Pimiento rojo',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000004','00000003');
insert into PertenenciaPlato Values('00000015','00000003');
insert into PertenenciaPlato Values('00000016','00000003');
insert into PertenenciaPlato Values('00000017','00000003');
insert into PertenenciaPlato Values('00000018','00000003');


insert into Plato Values ('00000004','Filetes de pollo','Filetes de pollo al grill y tomate aliñado',FALSE,FALSE,FALSE,FALSE,FALSE,200,10,10,20,17,47);
insert into Ingrediente Values('00000019','Filete de pollo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000004');
insert into PertenenciaPlato Values('00000013','00000004');
insert into PertenenciaPlato Values('00000019','00000004');


insert into Plato Values ('00000005','Cóctel de langostinos','Cóctel de langostinos con palitos de cangrejo',FALSE,FALSE,FALSE,FALSE,FALSE,80,13,18,28,10,60);
insert into Ingrediente Values('00000020','Langostinos',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000021','Palitos de cangrejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000022','Pinia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000023','Lechuga',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000024','Mayonesa',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000025','Vinagre',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000026','Pimienta',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000005');
insert into PertenenciaPlato Values('00000020','00000005');
insert into PertenenciaPlato Values('00000021','00000005');
insert into PertenenciaPlato Values('00000022','00000005');
insert into PertenenciaPlato Values('00000023','00000005');
insert into PertenenciaPlato Values('00000024','00000005');
insert into PertenenciaPlato Values('00000025','00000005');
insert into PertenenciaPlato Values('00000026','00000005');


insert into Plato Values ('00000006','Espaguetis a la carbonara','Espaguetis con salsa carbonara',FALSE,FALSE,FALSE,FALSE,TRUE,141,7,12,11,5,13);
insert into Ingrediente Values('00000027','Salsa carbonara',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000028','Agua',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000029','Nata',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000030','Queso',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000031','Espaguetis',FALSE,FALSE,FALSE,TRUE);
insert into PertenenciaPlato Values('00000006','00000006');
insert into PertenenciaPlato Values('00000027','00000006');
insert into PertenenciaPlato Values('00000028','00000006');
insert into PertenenciaPlato Values('00000029','00000006');
insert into PertenenciaPlato Values('00000030','00000006');
insert into PertenenciaPlato Values('00000031','00000006');


insert into Plato Values ('00000007','Costillas','Costillas de cerdo a la barbacoa',FALSE,FALSE,FALSE,FALSE,FALSE,186,10,13,12,16,8);
insert into Ingrediente Values('00000032','Costillas de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000033','Almidon',FALSE,FALSE,FALSE,TRUE);
insert into Ingrediente Values('00000034','Zumo de limon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000035','Salsa barbacoa',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000007');
insert into PertenenciaPlato Values('00000032','00000007');
insert into PertenenciaPlato Values('00000033','00000007');
insert into PertenenciaPlato Values('00000034','00000007');
insert into PertenenciaPlato Values('00000035','00000007');


insert into Plato Values ('00000008','Yogourt de frutas del bosque','Yogourt de frutas del bosque',TRUE,TRUE,TRUE,FALSE,TRUE,84,3,6,8,4,10);
insert into Ingrediente Values('00000036','Leche entera',TRUE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000037','Mora',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000038','Frambuesa',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000039','Arandanos',TRUE, TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000040','Azucar',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000033','00000008');
insert into PertenenciaPlato Values('00000036','00000008');
insert into PertenenciaPlato Values('00000037','00000008');
insert into PertenenciaPlato Values('00000038','00000008');
insert into PertenenciaPlato Values('00000039','00000008');
insert into PertenenciaPlato Values('00000040','00000008');


insert into Plato Values ('00000009','Melon con jamon','Melon con jamon',FALSE,FALSE,FALSE,FALSE,TRUE,237,13,17,18,30,1);
insert into Ingrediente Values('00000041','Melon',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000042','Jamon',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000041','00000009');
insert into PertenenciaPlato Values('00000042','00000009');


insert into Plato Values ('00000010','Baguettes de atun y bacon','Baguettes de atun y bacon',FALSE,FALSE,FALSE,FALSE,TRUE,275,11,12,10,14,30);
insert into Ingrediente Values('00000043','Pan',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000044','Atun',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000045','Bacon',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000010');
insert into PertenenciaPlato Values('00000043','00000010');
insert into PertenenciaPlato Values('00000044','00000010');
insert into PertenenciaPlato Values('00000045','00000010');

insert into Plato Values ('00000011','Lasania Boloniesa','Lasania Boloniesa con carne de cerdo',FALSE,FALSE,FALSE,FALSE,TRUE,148,7,15,17,7,15);
insert into Ingrediente Values('00000046','Harina',TRUE,TRUE,FALSE,TRUE);
insert into Ingrediente Values('00000065','Carne de cerdo',FALSE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000013','00000011');
insert into PertenenciaPlato Values('00000040','00000011');
insert into PertenenciaPlato Values('00000036','00000011');
insert into PertenenciaPlato Values('00000065','00000011');
insert into PertenenciaPlato Values('00000046','00000011');
insert into PertenenciaPlato Values('00000016','00000011');
insert into PertenenciaPlato Values('00000004','00000011');
insert into PertenenciaPlato Values('00000026','00000011');


insert into Plato Values ('00000012','Berza cocida','Berza cocida con aceite, ajo y pimenton',FALSE,TRUE,TRUE,FALSE,FALSE,63,2,8,5,5,11);
insert into Ingrediente Values('00000047','Berza',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000004','00000012');
insert into PertenenciaPlato Values('00000006','00000012');
insert into PertenenciaPlato Values('00000028','00000012');
insert into PertenenciaPlato Values('00000003','00000012');
insert into PertenenciaPlato Values('00000005','00000012');



insert into Plato Values ('00000013','Potaje de garbanzos','Potaje de garbanzos con verduras',FALSE,TRUE,TRUE,FALSE,FALSE,269,5,8,20,12,45);
insert into Ingrediente Values('00000048','Calabacin',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000005','00000013');
insert into PertenenciaPlato Values('00000004','00000013');
insert into PertenenciaPlato Values('00000002','00000013');
insert into PertenenciaPlato Values('00000016','00000013');
insert into PertenenciaPlato Values('00000017','00000013');
insert into PertenenciaPlato Values('00000013','00000013');
insert into PertenenciaPlato Values('00000003','00000013');


insert into Plato Values ('00000014','Menestra','Menestra de verduras',FALSE,TRUE,TRUE,FALSE,FALSE,141,7,8,5,6,12);
insert into Ingrediente Values('00000049','Judia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000050','Guisante',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000051','Zanahoria',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000052','Col',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000053','Haba',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000054','Alcachofa',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000014');
insert into PertenenciaPlato Values('00000003','00000014');
insert into PertenenciaPlato Values('00000025','00000014');
insert into PertenenciaPlato Values('00000049','00000014');
insert into PertenenciaPlato Values('00000050','00000014');
insert into PertenenciaPlato Values('00000051','00000014');
insert into PertenenciaPlato Values('00000052','00000014');
insert into PertenenciaPlato Values('00000053','00000014');
insert into PertenenciaPlato Values('00000054','00000014');


insert into Plato Values ('00000015','Ensalada de endivias','Ensalada de endivias con manzana, queso azul cebolla y nueces',FALSE,TRUE,TRUE,TRUE,FALSE,20,1,3,5,2,12);
insert into Ingrediente Values('00000055','Endivia',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000056','Manzana',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000057','Nuez',TRUE,TRUE,TRUE,FALSE);
insert into Ingrediente Values('00000058','Queso azul',FALSE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000015');
insert into PertenenciaPlato Values('00000003','00000015');
insert into PertenenciaPlato Values('00000025','00000015');
insert into PertenenciaPlato Values('00000016','00000015');
insert into PertenenciaPlato Values('00000055','00000015');
insert into PertenenciaPlato Values('00000056','00000015');
insert into PertenenciaPlato Values('00000057','00000015');
insert into PertenenciaPlato Values('00000058','00000015');


insert into Plato Values ('00000016','Conejo guisado','Conejo guisado con patatas y cebolla',FALSE,FALSE,FALSE,FALSE,TRUE,179,10,3,5,27,0);
insert into Ingrediente Values('00000059','Conejo',FALSE,FALSE,FALSE,FALSE);
insert into Ingrediente Values('00000060','Patata',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000061','Laurel',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000016');
insert into PertenenciaPlato Values('00000003','00000016');
insert into PertenenciaPlato Values('00000004','00000016');
insert into PertenenciaPlato Values('00000046','00000016');
insert into PertenenciaPlato Values('00000017','00000016');
insert into PertenenciaPlato Values('00000026','00000016');
insert into PertenenciaPlato Values('00000059','00000016');
insert into PertenenciaPlato Values('00000060','00000016');
insert into PertenenciaPlato Values('00000061','00000016');


insert into Plato Values ('00000017','Guisantes con jamon','Guisantes con jamon con ajo, cebolla y perejil',FALSE,FALSE,FALSE,FALSE,FALSE,160,15,11,9,5,5);
insert into Ingrediente Values('00000062','Perejil',TRUE,TRUE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000006','00000017');
insert into PertenenciaPlato Values('00000003','00000017');
insert into PertenenciaPlato Values('00000004','00000017');
insert into PertenenciaPlato Values('00000016','00000017');
insert into PertenenciaPlato Values('00000042','00000017');
insert into PertenenciaPlato Values('00000050','00000017');
insert into PertenenciaPlato Values('00000062','00000017');


insert into Plato Values ('00000018','Revuelto de setas','Revuelto de setas con huevos y ajo',FALSE,FALSE,FALSE,FALSE,FALSE,28,0,2,3,2,5);
insert into Ingrediente Values('00000063','Seta',TRUE,TRUE,FALSE,FALSE);
insert into Ingrediente Values('00000064','Huevo',TRUE,FALSE,FALSE,FALSE);
insert into PertenenciaPlato Values('00000063','00000018');
insert into PertenenciaPlato Values('00000064','00000018');
insert into PertenenciaPlato Values('00000006','00000018');
insert into PertenenciaPlato Values('00000003','00000018');
insert into PertenenciaPlato Values('00000062','00000018');



insert into PlatoMenu Values ('00000002','00000001','lunes','comidaPrimero');
insert into PlatoMenu Values ('00000001','00000001','lunes','comidaSegundo');
insert into PlatoMenu Values ('00000000','00000000','jueves','cena');
insert into PlatoMenu Values ('00000003','00000000','lunes','desayuno');


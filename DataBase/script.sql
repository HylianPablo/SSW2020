drop table if exists Usuario;
drop table if exists Guardado;
drop table if exists Dieta;
drop table if exists Entrada;
drop table if exists Comentario;
drop table if exists PlatoMenu;
drop table if exists Plato;
drop table if exists PertenenciaPlato;
drop table if exists Ingrediente;
 
create table Usuario(
	nombre					char(50) not null,
	nombreUsuario				char(20) not null,
	contraseña				char(20) not null,
	correo					char(40) not null,
	favorito				char(20),
	foreign key(favorito) references Dieta,
	primary key(nombreUsuario)
);


create table Guardado(
	nombreUsuario				char(20) not null,
	codigoDieta				char(20) not null,
	foreign key(nombreUsuario) references Usuario,
	foreign key(codigoDieta) references Dieta,
	primary key(nombreUsuario, codigoDieta)
);

create table Entrada(
	codigoEntrada				char(20) not null,
	titulo					char(50) not null,
	cuerpo					char(500),
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(nombreUsuario) references Usuario,
	primary key(codigoEntrada)
);

create table Comentario(
	codigoComentario			char(20) not null,
	codigoPadre				char(20) not null,
	cuerpo					char(500) not null,
	nombreUsuario				char(20) not null,
	fecha					date not null,
	foreign key(codigoPadre) references Entrada,
	foreign key(nombreUsuario) references Usuario,
	primary key(codigoComentario)
);

create table PlatoMenu(
	codigoPlato				char(20) not null,
	codigoDieta				char(20) not null,
	diaSemana				char(20) not null,
	check (diaSemana in ('lunes','martes','miercoles','jueves','viernes','sabado','domingo')),
	momento					char(30) not null,
	check (momento in ('desayuno','comidaPrimero','comidaSegundo','cena')),
	foreign key(codigoPlato) references Plato, 
	foreign key(codigoDieta) references Dieta,
	primary key(codigoPlato, codigoDieta)
);	

create table Dieta(
	codigoDieta	char(20) not null,
	titulo		char(20) not null,
	descriptcion	char(500) not null,
	primary key(codigoDieta)
);

create table Plato(
	codigoPlato 				char(20) not null,
	nombre					char(30) not null,
	descripcion				char(500),
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

create table PertenenciaPlato(
	codigoIngrediente		char(20) not null,
	codigoPlato 			char(20) not null,
	foreign key(codigoIngrediente) references Ingrediente,
	foreign key(codigoPlato) references Plato,
	primary key(codigoIngrediente, codigoPlato)
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

insert into Usuario Values ('Pedro Sanz Lopez', 'pedsanz', '12345pedro','pedrosanzl@gmail.com','36587J');
insert into Usuario Values ('Marta Sanchez Rojo', 'martsanro', 'farola4','pedrosanzl@gmail.com','36587J');
insert into Usuario Values ('Pedro Sanz Lopez', 'pedsanz', '12345pedro','pedrosanzl@gmail.com','36587J');

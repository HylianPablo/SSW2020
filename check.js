var registrado = false;

function registered(){
	registrado = true;
	window.location.href = "lunes.html";
	JSON.stringify(registrado);
}

function unregistered(){
	registrado = false;
	window.location.href = "lunes.html";
}

function comprobar(){
	if(!registrado){
		window.location.href = "iniciarSesion.html";
		//document.getElementById('salidaDieta').setAttribute('href', 'iniciarSesion.html');
	}else{
		window.location.href = "paginaUsuario.html";
		//document.getElementById('salidaDieta').setAttribute('href', 'paginaUsuario.html');
	}
}
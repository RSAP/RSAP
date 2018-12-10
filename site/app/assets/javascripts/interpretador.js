function seletorLang(entrada) {
	// console.log("");
	switch (entrada) {
		case "c":
			return "clike";
		default:
			return entrada;
	}
}

function interpretar(texto, conteiner) {
	var linhas = texto.split("\n");
	var saida = "";
	var acabado = false;
	var lang = "";
	for (var i = 0; i < linhas.length; i++) {
		if (linhas[i].includes(";;lang=")) {
			lang = linhas[i].split(";;lang=")[1];
			lang = seletorLang(lang);
			saida += "<pre class='language-";
			saida += lang;
			saida += "'><code class='language-";
			saida += lang;
			saida += "'>";
		} else {
			var fim = false;
			if (linhas[i].includes("\t")) {
				saida += "";
			}
			if (linhas[i].includes(";;endlang")) {
				acabado = true;
				fim = true;
				saida += " </pre></code>";
			}

			if (!fim) {
				saida += linhas[i];
			}

			saida += "<br>";
		}
	}
	if (!acabado) {
		saida += " </pre></code>";
	}
	document.getElementById(conteiner).innerHTML = saida;
}

function habilitarTextArea() {

	var textareas = document.getElementsByTagName("textarea");
	var count = textareas.length;
	for (var i = 0; i < count; i++) {
		textareas[i].onkeydown = function(e) {
			if (e.keyCode == 9 || e.which == 9) {
				e.preventDefault();
				var s = this.selectionStart;
				this.value = this.value.substring(0, this.selectionStart) + "\t" + this.value.substring(this.selectionEnd);
				this.selectionEnd = s + 1;
			}
		}
	}
}

function mudarCategoria() {

	var selectBox = document.getElementsByName("post[categoria]")[0];
	var selected = selectBox.options[selectBox.selectedIndex].value;
	var textarea = document.getElementById("imagemCategoria");
	console.log(selected);
	// if (selected === '1') { 	textarea.show(); } else { 	textarea.hide(); }
}

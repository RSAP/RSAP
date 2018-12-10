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
	let linhas = texto.split("\n");
	let saida = "";
	let acabado = false;
	let lang = "";
	for (let i = 0; i < linhas.length; i++) {
		let linhaAtual = linhas[i];
		if (linhaAtual.includes(";;lang=")) {
			lang = linhaAtual.split(";;lang=")[1];
			lang = seletorLang(lang);
			saida += "<pre class='language-";
			saida += lang;
			saida += "'><code class='language-";
			saida += lang;
			saida += "'>";
		} else {
			let fim = false;
			if (linhaAtual.includes("\t")) {
				saida += "";
			}
			if (linhaAtual.includes(";;endlang")) {
				acabado = true;
				fim = true;
				saida += " </pre></code>";
			}

			if (!fim) {
				saida += linhaAtual;
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
	// esse codigo permite o uso da tecla tab em textareas
	let textareas = document.getElementsByTagName("textarea");
	let count = textareas.length;
	for (let i = 0; i < count; i++) {
		textareas[i].onkeydown = function(e) {
			if (e.keyCode === 9 || e.which === 9) {
				e.preventDefault();
				let s = this.selectionStart;
				this.value = this.value.substring(0, this.selectionStart) + "\t" + this.value.substring(this.selectionEnd);
				this.selectionEnd = s + 1;
			}
		};
	}
}

function mudarCategoria() {

	let selectBox = document.getElementsByName("post[categoria]")[0];
	let selected = selectBox.options[selectBox.selectedIndex].value;
	let textarea = document.getElementById("imagemCategoria");
	// console.log(selected);
	// if (selected === '1') { 	textarea.show(); } else { 	textarea.hide(); }
}

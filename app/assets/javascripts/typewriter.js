// Création d'une classe qui va contenir 

class Typewriter {
  constructor(typewriterSpan, textToRotate) {
    this.typewriterSpan = typewriterSpan; //span dans lequel se trouve le texte
    this.textToRotate = textToRotate; //array des différentes string à afficher
    this.restTime = 2000; //temps de "pause" entre l'écriture et la suppression du texte
    this.text = ''; //texte affiché
    this.isDeleting = false; //boolean qui permet de savoir si le texte est en train d'être écrit ou supprimé
    this.loop = 0; //index de la string de l'array textToRotate à afficher
    this.minTick = 30;
    this.maxTick = 80;
    this.tick(); //lancement de la fonction d'animation dès qu'une instance est déclarée
  }

  tick() {
    let i = this.loop % this.textToRotate.length;
    let fullText = this.textToRotate[i]; //string complète à afficher

    if (this.isDeleting) {
      this.text = fullText.substring(0, this.text.length - 1);
    } else {
      this.text = fullText.substring(0, this.text.length + 1);
    }

    this.typewriterSpan.innerHTML = `<span class='wrapper'>${this.text}</span>`

    let tickTime = this.maxTick - (Math.random() * (this.maxTick - this.minTick)) //temps du tick aléatoire (entre 50 et 100ms) pour donner un coté plus "humain"

    tickTime = this.isDeleting ? tickTime / 2 : tickTime; //suppression du texte 2fois plus rapide

    if (!this.isDeleting && this.text === fullText) { //si le texte est complètement écrit
      tickTime = this.restTime
      this.isDeleting = true;
    } else if (this.isDeleting && this.text === '') { //si le texte est complètement effacé
      tickTime = 500; //cooldown
      this.isDeleting = false;
      this.loop++;
    }

    setTimeout(() => this.tick(), tickTime)
  }
}

window.onload = () => {
  const typewriterSpan = document.querySelector('.typewriter');
  const textToRotate = typewriterSpan.getAttribute('data-type');

  if (textToRotate) {
    new Typewriter(typewriterSpan, JSON.parse(textToRotate));
  }
}
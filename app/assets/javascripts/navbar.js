const connexionBtn = document.querySelector(".connexion-btn");
const connexionMenu = document.querySelector(".navbar__items__connexion__menu");

connexionBtn.addEventListener("click", function() {
  connexionBtn.classList.toggle("active");
  connexionMenu.classList.toggle("active");
})

connexionMenu.addEventListener('mouseleave', function() {
  connexionMenu.classList.remove("active");
  connexionBtn.classList.remove("active");
})
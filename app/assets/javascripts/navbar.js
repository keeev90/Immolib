const connexionBtn = document.querySelector(".connexion-btn");
const connexionMenu = document.querySelector(".navbar__items__connexion__menu");
const hamburgerBtn = document.querySelector('.hamburger-btn');
const hamburgerMenu = document.querySelector('.hamburger-menu');


if (connexionBtn) {
  connexionBtn.addEventListener("click", function() {
    connexionBtn.classList.toggle("active");
    connexionMenu.classList.toggle("active");
  });

  connexionMenu.addEventListener('mouseleave', function() {
    connexionMenu.classList.remove("active");
    connexionBtn.classList.remove("active");
  });
}

hamburgerBtn.addEventListener('click', () => {
  hamburgerBtn.classList.toggle('is-active');
  hamburgerMenu.classList.toggle('is-active');
  console.log('coucou')
});

window.addEventListener('scroll', () => {
  const scroll = Math.round(window.scrollY || window.pageYOffset)
  if (scroll > 100) {
    hamburgerBtn.style.display = 'block';
  } else if (scroll < 100) {
    hamburgerBtn.style.display = 'none';
  }
});
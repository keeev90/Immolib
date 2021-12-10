const connectionBtns = document.querySelectorAll(".connection-btn");
const hamburgerBtn = document.querySelector('.hamburger-btn');
const hamburgerMenu = document.querySelector('.hamburger-menu');

connectionBtns.forEach(btn => {
  const connectionMenu = btn.parentNode.querySelector('.navbar__items__connection__menu');

  btn.addEventListener("click", function() {
    btn.classList.toggle("active");
    connectionMenu.classList.toggle("active");
  });

  connectionMenu.addEventListener('mouseleave', function() {
    connectionMenu.classList.remove("active");
    btn.classList.remove("active");
  });
});

hamburgerBtn.addEventListener('click', () => {
  hamburgerBtn.classList.toggle('is-active');
  hamburgerMenu.classList.toggle('is-active');
  
  if (hamburgerMenu.classList.contains('is-active')) {
    document.body.setAttribute('style', 'overflow: hidden')
  } else {
    document.body.setAttribute('style', 'overflow: auto')
  }
});

window.addEventListener('scroll', () => {
  const scroll = Math.round(window.scrollY || window.pageYOffset)
  if (scroll > 100) {
    hamburgerBtn.style.display = 'block';
  } else if (scroll < 100 && window.innerWidth > 800) {
    hamburgerBtn.style.display = 'none';
  }
});

window.addEventListener('resize', () => {
  if (window.innerWidth < 800) {
    hamburgerBtn.style.display = 'block'
  } else {
    hamburgerBtn.style.display = 'none'
  }
})
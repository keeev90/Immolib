const home = document.querySelector('.home');
const watermark = document.querySelector('.home-watermark h1');

window.addEventListener('scroll', () => {
  const y = 1 + (window.scrollY || window.pageXOffset) / 500;
  const lightness = 47 * y < 100 ? 47 * y : 100;

  home.setAttribute('style', `background-color: hsl(174, 62%, ${lightness}%)`);
});

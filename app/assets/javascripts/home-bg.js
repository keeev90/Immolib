const intro = document.querySelector('.home-intro');
const video = intro.querySelector('video');
const text = intro.querySelector('.home-intro__text');

const next = document.getElementById('benefits-1');

const controller = new ScrollMagic.Controller();

const videoScene = new ScrollMagic.Scene({
  duration: 2300,
  triggerElement: intro,
  triggerHook: 0
})
  .setPin(intro)
  .addTo(controller);

const textAnim = gsap.to(text, {
  duration: 2,
  opacity: 1,
  opacity: 0
});

const textScene = new ScrollMagic.Scene({
  duration: 1000,
  triggerElement: intro,
  triggerHook: 0
})
  .setTween(textAnim)
  .addTo(controller);

let accelAmount = 0.6;
let scroll = 0;
let delay = 0;

videoScene.on('update', e => {
  scroll = e.scrollPos / 1000;
});

setInterval(() => {
  delay += (scroll - delay) * accelAmount;

  video.currentTime = delay;
}, 66.6)
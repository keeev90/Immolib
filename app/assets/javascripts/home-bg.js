const doc = document.documentElement;
const intro = document.querySelector('.home-intro');
const video = intro.querySelector('video');
const text = intro.querySelector('.home-intro__text');
const anchorLink = intro.querySelector('a[href="#benefits-1"]')

const sections = document.querySelectorAll('.benefits-section');
const nav = document.querySelector('.navbar');

const arrowUp = document.querySelector('.arrow-up');

const controller = new ScrollMagic.Controller();

gsap.registerPlugin(ScrollToPlugin);

videoDuration = 3800;

let videoScene = new ScrollMagic.Scene({
  duration: videoDuration,
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

let textScene = new ScrollMagic.Scene({
  duration: 1000,
  triggerElement: intro,
  triggerHook: 0
})
  .setTween(textAnim)
  .addTo(controller);

const arrowAnim = gsap.fromTo(arrowUp, {
  opacity: 0
}, {
  duration: .1,
  visibility: 'visible',
  opacity: .6
});

let arrowScene = new ScrollMagic.Scene({
  duration: 0,
  triggerElement: anchorLink,
  triggerHook: 0
})
  .setTween(arrowAnim)
  .addTo(controller);

let accelAmount = 0.3;
let scroll = 0;
let delay = 0;

videoScene.on('update', e => {
  scroll = e.scrollPos / 1000;
});

let noScrollAccel = 0.038;

setInterval(() => {
  if (scroll === 0) {
    delay += noScrollAccel;

    if (delay >= 0.6) delay = 0;
  } else {
    delay += (scroll - delay) * accelAmount;
  }

  video.currentTime = delay;
}, 120);

sections.forEach(section => {
  new ScrollMagic.Scene({
    triggerElement: section,
    triggerHook: 0.6,
    duration: 0,
    offset: 50
  })
    .setClassToggle(section, "visible")
    .addTo(controller);
});

const resetDuration = () => {
  document.body.setAttribute('style', 'overflow: auto');
  videoScene.duration(videoDuration);
};

controller.scrollToBenefits = () => {
  document.body.setAttribute('style', 'overflow: hidden');
  videoScene.duration(videoDuration * 2);

  gsap.to(window, {
    duration: 3,
    scrollTo: 
      videoDuration
      + window.innerHeight
      + nav.clientHeight
      + 50,
    ease: 'none',
    onComplete: resetDuration
  });
};

anchorLink.addEventListener('click', e => {
  e.preventDefault();
  gsap.to(window, {
    duration: 0.05,
    scrollTo: nav.clientHeight,
    onComplete: controller.scrollToBenefits
  });
});

function pageScroll() {
  const YOffset = (window.pageYOffset || doc.scrollTop) - (doc.clientTop || 0);
  if (YOffset === 0) {
    return;
  } else {
    window.scrollBy(0, -50);
    scrolldelay = setTimeout(pageScroll,10);
  }
};

arrowUp.addEventListener('click', pageScroll);
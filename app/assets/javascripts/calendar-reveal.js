const calInstructions = document.querySelector('.calendar-wrapper>.instructions');

const instrDisplay = () => {
  calInstructions.setAttribute('style', 'display: none');
}

calInstructions.addEventListener('mouseenter', () => {
  gsap.to('.instructions', {
    duration: .5,
    opacity: 0,
    onComplete: instrDisplay
  });
});
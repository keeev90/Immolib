const toggle = document.querySelector('.yes-no-toggle');
const yesBtn = toggle.querySelector('.yes-btn');
const noBtn = toggle.querySelector('.no-btn');
const check = toggle.querySelector('div');
const hiddenField = document.getElementById('appointment_is_interested');

check.classList = hiddenField.value

yesBtn.addEventListener('click', () => {
  check.classList = 'yes';
  hiddenField.value = true
});

noBtn.addEventListener('click', () => {
  check.classList = 'no';
  hiddenField.value = false;
})
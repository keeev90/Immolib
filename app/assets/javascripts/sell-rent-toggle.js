const toggle = document.querySelector('.sell-rent-toggle');
const rentBtn = toggle.querySelector('.rent-btn');
const sellBtn = toggle.querySelector('.sell-btn');
const check = toggle.querySelector('div');
const hiddenField = document.getElementById('property_owner_project');

check.classList = hiddenField.value

rentBtn.addEventListener('click', () => {
  check.classList = 'rent';
  hiddenField.value = 'rent'
});

sellBtn.addEventListener('click', () => {
  check.classList = 'sell';
  hiddenField.value = 'sell';
})
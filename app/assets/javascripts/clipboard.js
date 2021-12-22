const copyIcons = document.querySelectorAll('.fa-copy');

copyIcons.forEach(icon => {
  icon.addEventListener('click', () => {
    navigator.clipboard.writeText(icon.parentNode.querySelector('a').textContent);
    icon.querySelector('.copy-text').innerText = 'Copié !';
  });

  icon.addEventListener('mouseleave', () => {
    icon.querySelector('.copy-text').innerText = "Copier le lien";
  })
});
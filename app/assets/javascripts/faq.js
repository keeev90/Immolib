questions = document.querySelectorAll(".faq-element__question");

questions.forEach(q => {
  q.addEventListener('click', function() {
    q.classList.toggle("active");
  })
})
const modal = document.querySelector(".picture-modal-wrapper");
const picBtn = document.querySelector(".pic");
const closeBtn = modal.querySelector(".modal-close");
const blocker = modal.querySelector('.blocker');

picBtn.addEventListener("click", function() {
  modal.classList.toggle("hidden");
});

closeBtn.addEventListener("click",function() {
  modal.classList.add("hidden");
});

blocker.addEventListener('click', () => {
  modal.classList.add('hidden');
})
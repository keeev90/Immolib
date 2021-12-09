const closeBtn = document.querySelector(".modal-close");
const profileModal = document.querySelector(".picture-profile-modal");
const profileBtn = document.querySelector(".profile-wrapper__informations__right");

profileBtn.addEventListener("click", function() {
  profileModal.classList.toggle("hidden");
})

closeBtn.addEventListener("click",function() {
  profileModal.classList.add("hidden");
})
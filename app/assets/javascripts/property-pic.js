const closeBtn = document.querySelector(".modal-close");
const profileModal = document.querySelector(".picture-profile-modal");
const profileBtn = document.querySelector(".property-picture");

profileBtn.addEventListener("click", function() {
  profileModal.classList.toggle("hidden");
})

closeBtn.addEventListener("click",function() {
  profileModal.classList.add("hidden");
})
document.addEventListener("turbo:load", () => {
  const flashes = document.querySelectorAll('.flash');

  flashes.forEach(flash => {
    flash.style.transition = "opacity 0.5s ease-in-out"; // Плавное исчезновение
    setTimeout(() => {
      flash.style.opacity = '0'; // Начинаем плавное исчезновение
      flash.addEventListener('transitionend', () => flash.remove());
    }, 3000); // Ждем 3 секунды перед исчезновением
  });
});
  